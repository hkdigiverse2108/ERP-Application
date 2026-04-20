import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxesController extends GetxController {
  static TaxesController get instance => Get.find();

  final _repo = TaxRepository();

  final taxes = <TaxItemModel>[].obs;
  final isLoading = false.obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  // Caching
  final _cache =
      <
        String,
        ({
          List<TaxItemModel> items,
          int totalPages,
          int totalItems,
          DateTime fetchedAt,
        })
      >{};
  final _cacheExpiry = const Duration(minutes: 5);

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}';

  @override
  void onReady() {
    super.onReady();
    getTaxesData();
  }

  Future<void> getTaxesData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      taxes.value = cached.items;
      totalPages.value = cached.totalPages;
      totalItems.value = cached.totalItems;
      return;
    }

    try {
      isLoading.value = true;
      final res = await _repo.getTaxesForTable(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        filters: filters.isEmpty ? null : filters,
      );

      _cache[key] = (
        items: res.items,
        totalPages: res.totalPages,
        totalItems: res.totalItems,
        fetchedAt: DateTime.now(),
      );

      taxes.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      Log.e("Settings Module Error (Taxes)", e);
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
      getTaxesData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getTaxesData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getTaxesData();
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
