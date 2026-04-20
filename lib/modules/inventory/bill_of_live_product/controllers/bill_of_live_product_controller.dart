import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/data/repositories/bill_of_live_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillOfLiveProductController extends GetxController {
  static BillOfLiveProductController get instance => Get.find();

  final _repo = BillOfLiveProductRepository();
  final billOfLiveProducts = <BillOfLiveProductModel>[].obs;

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
      <String, ({List<BillOfLiveProductModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getBillOfLiveProductData();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${activeFilters.toString()}';

  Future<void> getBillOfLiveProductData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      billOfLiveProducts.value = cached.items;
      return;
    }

    try {
      isLoading.value = true;
      final res = await _repo.getBillOfLiveProductList(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: activeFilters.isEmpty ? null : activeFilters.toString(),
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      billOfLiveProducts.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      Log.e("Inventory Module Error (BillOfLiveProduct)", e);
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
      getBillOfLiveProductData();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    activeFilters.value = filters;
    _clearCache();
    getBillOfLiveProductData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getBillOfLiveProductData();
    }
  }
}
