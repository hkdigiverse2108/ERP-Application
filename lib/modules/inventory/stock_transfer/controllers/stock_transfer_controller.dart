import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'dart:async';
import 'package:ai_setu/data/model/invetory/stock_transfer_model.dart';
import 'package:ai_setu/data/repositories/inventory/stock_transfer_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTransferController extends GetxController {
  static StockTransferController get instance => Get.find();

  final _repository = StockTransferRepository();

  final transfers = <StockTransferModel>[].obs;
  final RxBool isLoading = false.obs;

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
          List<StockTransferModel> items,
          DateTime fetchedAt,
          int totalPages,
          int totalItems,
        })
      >{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getStockTransfers();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${activeFilters.toString()}';

  Future<void> getStockTransfers() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      transfers.value = cached.items;
      totalPages.value = cached.totalPages;
      totalItems.value = cached.totalItems;
      return;
    }

    try {
      isLoading.value = true;
      final res = await _repository.getStockTransferList(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        branchId: activeFilters['branchFilter'],
        fromDate: activeFilters['startDate'],
        toDate: activeFilters['endDate'],
        activeFilter: activeFilters['activeFilter'],
        typeFilter: activeFilters['typeFilter'],
        statusFilter: activeFilters['statusFilter'],
      );

      _cache[key] = (
        items: res.items,
        fetchedAt: DateTime.now(),
        totalPages: res.totalPages,
        totalItems: res.totalItems,
      );

      transfers.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      Log.e("Inventory Module Error (Stock Transfer)", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    _cache.clear();
    currentPage.value = 1;
    await getStockTransfers();
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
      getStockTransfers();
    });
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    activeFilters['startDate'] = range.start.toIso8601String();
    activeFilters['endDate'] = range.end.toIso8601String();
    _clearCache();
    getStockTransfers();
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    activeFilters.addAll(filters);
    // Remove null values
    activeFilters.removeWhere((key, value) => value == null || value == '');
    _clearCache();
    getStockTransfers();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getStockTransfers();
    }
  }

  Future<void> deleteStockTransfer(String id) async {
    try {
      final success = await _repository.deleteStockTransfer(id);
      if (success) {
        AppSnackbar.success("Stock transfer deleted successfully");
        await refreshData();
      } else {
        AppSnackbar.error("Failed to delete stock transfer");
      }
    } catch (e) {
      Log.e("Error deleting stock transfer", e);
      AppSnackbar.error("An error occurred while deleting stock transfer");
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
