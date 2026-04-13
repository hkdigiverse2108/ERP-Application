import 'dart:async';
import 'package:ai_setu/data/model/brand/brand_model.dart';
import 'package:ai_setu/data/model/category/category_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/repositories/brand_repository.dart';
import 'package:ai_setu/data/repositories/category_repository.dart';
import 'package:ai_setu/data/repositories/product_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _repo = ProductRepository();
  final _categoryRepo = CategoryRepository();
  final _brandRepo = BrandRepository();
  final _taxRepo = TaxRepository();

  final products = <ProductItemModel>[].obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final selectedCategoryId = ''.obs;
  final selectedBrandId = ''.obs;

  final category = <CategoryDropdownModel>[].obs;
  final subCategory = <CategoryDropdownModel>[].obs;
  final brand = <BrandDropdownModel>[].obs;
  final subBrand = <BrandDropdownModel>[].obs;
  final tax = <TaxDropdownModel>[].obs;

  // Caching
  final _cache =
      <String, ({List<ProductItemModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final isLodding = false.obs;

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
    getProductsData();
    _loadFilterData();
  }

  Future<void> _loadSubCategories(String id) async {
    // Cascade reset: clear sub-category selection when parent changes
    if (filters.containsKey('subCategoryFilter')) {
      final newFilters = Map<String, dynamic>.from(filters);
      newFilters.remove('subCategoryFilter');
      filters.value = newFilters;
      _clearCache();
      getProductsData();
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
      debugPrint('Sub-category load failed: $e');
    }
  }

  Future<void> _loadSubBrands(String id) async {
    // Cascade reset: clear sub-brand selection when parent changes
    if (filters.containsKey('subBrandFilter')) {
      final newFilters = Map<String, dynamic>.from(filters);
      newFilters.remove('subBrandFilter');
      filters.value = newFilters;
      _clearCache();
      getProductsData();
    }

    if (id.isEmpty) {
      subBrand.clear();
      return;
    }
    try {
      subBrand.value = await _brandRepo.getBrands(parentBrandFilter: id);
    } catch (e) {
      debugPrint('Sub-brand load failed: $e');
    }
  }

  void _loadFilterData() async {
    try {
      final results = await Future.wait([
        _categoryRepo.getCategories(), // root categories
        _brandRepo.getBrands(), // root brands
        _taxRepo.getTaxes(),
      ]);
      category.value = results[0] as List<CategoryDropdownModel>;
      brand.value = results[1] as List<BrandDropdownModel>;
      tax.value = results[2] as List<TaxDropdownModel>;
    } catch (e) {
      debugPrint('Filter data load failed: $e');
    }
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}';

  Future<void> getProductsData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    // Check if cache exists and is not expired
    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      products.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final res = await _repo.getProductsForTable(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        filters: filters.isEmpty ? null : filters,
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      products.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLodding.value = false;
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
      getProductsData();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    // Update IDs for reactive sub-filtering
    selectedCategoryId.value = filters['categoryFilter'] ?? '';
    selectedBrandId.value = filters['brandFilter'] ?? '';

    _clearCache();
    getProductsData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getProductsData();
    }
  }
}
