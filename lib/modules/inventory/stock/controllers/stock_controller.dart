import 'dart:async';

import 'package:ai_setu/data/model/invetory/stock_model.dart';
import 'package:ai_setu/data/repositories/stock_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  static StockController get instance => Get.find();

  final _repo = StockRepository();
  final stocks = <StockItemModel>[].obs;

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final activeFilters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache = <String, ({List<StockItemModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getStockList();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${activeFilters.toString()}';

  Future<void> getStockList() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      stocks.value = cached.items;
      return;
    }

    try {
      isLoading.value = true;
      final res = await _repo.getStockList(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value,
        activeFilter: "true",
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      stocks.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      debugPrint(e.toString());
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
