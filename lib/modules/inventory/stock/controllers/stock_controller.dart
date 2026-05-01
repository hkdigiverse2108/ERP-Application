import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';

import 'package:ai_setu/data/model/brand/brand_model.dart';
import 'package:ai_setu/data/model/category/category_model.dart';
import 'package:ai_setu/data/model/invetory/stock_model.dart';
import 'package:ai_setu/data/repositories/inventory/brand_repository.dart';
import 'package:ai_setu/data/repositories/inventory/category_repository.dart';
import 'package:ai_setu/data/repositories/inventory/stock_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  static StockController get instance => Get.find();

  final _repo = StockRepository();
  final _categoryRepo = CategoryRepository();
  final _brandRepo = BrandRepository();

  final stocks = <StockItemModel>[].obs;

  final category = <CategoryDropdownModel>[].obs;
  final subCategory = <CategoryDropdownModel>[].obs;
  final brand = <BrandDropdownModel>[].obs;
  final subBrand = <BrandDropdownModel>[].obs;

  final selectedCategoryId = ''.obs;
  final selectedBrandId = ''.obs;

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final activeFilters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache =
      <
        String,
        ({
          List<StockItemModel> items,
          DateTime fetchedAt,
          int totalPages,
          int totalItems,
        })
      >{};
  final _cacheExpiry = const Duration(minutes: 5);

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Watch for category change to load sub-categories
    ever(selectedCategoryId, (id) => _loadSubCategories(id));
    // Watch for brand change to load sub-brands
    ever(selectedBrandId, (id) => _loadSubBrands(id));
  }

  @override
  void onReady() {
    super.onReady();
    _loadFilterData();
    getStockList();
  }

  void _loadFilterData() async {
    try {
      final results = await Future.wait([
        _categoryRepo.getCategories(), // root categories
        _brandRepo.getBrands(), // root brands
      ]);
      category.value = results[0] as List<CategoryDropdownModel>;
      brand.value = results[1] as List<BrandDropdownModel>;
    } catch (e) {
      Log.e('Inventory Module Error (Stock) - Filter data load failed', e);
    }
  }

  Future<void> _loadSubCategories(String id) async {
    // Cascade reset: clear sub-category selection when parent changes
    if (activeFilters.containsKey('subCategoryFilter')) {
      final newFilters = Map<String, dynamic>.from(activeFilters);
      newFilters.remove('subCategoryFilter');
      activeFilters.value = newFilters;
      _clearCache();
      getStockList();
    }

    if (id.isEmpty) {
      subCategory.clear();
      return;
    }
    try {
      subCategory.value = await _categoryRepo.getCategories(
        parentCategoryFilter: id,
      );
    } catch (e) {
      Log.e('Inventory Module Error (Stock) - Sub-category load failed', e);
    }
  }

  Future<void> _loadSubBrands(String id) async {
    // Cascade reset: clear sub-brand selection when parent changes
    if (activeFilters.containsKey('subBrandFilter')) {
      final newFilters = Map<String, dynamic>.from(activeFilters);
      newFilters.remove('subBrandFilter');
      activeFilters.value = newFilters;
      _clearCache();
      getStockList();
    }

    if (id.isEmpty) {
      subBrand.clear();
      return;
    }
    try {
      subBrand.value = await _brandRepo.getBrands(parentBrandFilter: id);
    } catch (e) {
      Log.e('Inventory Module Error (Stock) - Sub-brand load failed', e);
    }
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${activeFilters.toString()}';

  Future<void> getStockList() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    // Check if cache exists and is not expired
    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      stocks.value = cached.items;
      totalPages.value = cached.totalPages;
      totalItems.value = cached.totalItems;
      return;
    }

    try {
      isLoading.value = true;
      final res = await _repo.getStockList(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: activeFilters['activeFilter'],
        categoryFilter: activeFilters['categoryFilter'],
        subCategoryFilter: activeFilters['subCategoryFilter'],
        brandFilter: activeFilters['brandFilter'],
        subBrandFilter: activeFilters['subBrandFilter'],
      );

      _cache[key] = (
        items: res.items,
        fetchedAt: DateTime.now(),
        totalPages: res.totalPages,
        totalItems: res.totalItems,
      );

      stocks.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      Log.e("Inventory Module Error (Stock)", e);
    } finally {
      isLoading.value = false;
    }
  }

  void _clearCache() {
    _cache.clear();
    currentPage.value = 1;
  }

  void onSearch(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = query;
      _clearCache();
      getStockList();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    activeFilters.value = filters;
    // Update IDs for reactive sub-filtering
    selectedCategoryId.value = filters['categoryFilter'] ?? '';
    selectedBrandId.value = filters['brandFilter'] ?? '';

    _clearCache();
    getStockList();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getStockList();
    }
  }
}

