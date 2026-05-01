import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/data/model/pos/sales_register_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/pos/sales_register_repository.dart';
import 'package:ai_setu/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesRegisterController extends GetxController {
  static SalesRegisterController get instance => Get.find();

  final _repository = SalesRegisterRepository();
  final _userRepository = UserRepository();

  final salesRegisters = <SalesRegisterModel>[].obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final users = <UserDropDownModel>[].obs;

  // Caching
  final _cache =
      <String, ({List<SalesRegisterModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final isLoading = false.obs;
  Worker? _fyWorker;

  @override
  void onInit() {
    super.onInit();
    selectedDateRange.value = FinancialYearController.to.selectedRange;
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        updateDateRange(year.dateRange);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getAllUserDropDown();
    getSalesRegisterData();
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}';

  Future<void> getAllUserDropDown() async {
    try {
      final res = await _userRepository.getUserDropDown();
      users.value = res;
    } catch (e) {
      Log.e("POS Module Error (SalesRegister)", e);
    }
  }

  Future<void> getSalesRegisterData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      salesRegisters.value = cached.items;
      return;
    }

    try {
      isLoading.value = true;
      final pagination = await _repository.getAllSalesRegister(
        page: currentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        statusFilter: filters['statusFilter'],
        salesManFilter: filters['salesManFilter'],
        activeFilter: filters['activeFilter'],
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      salesRegisters.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("POS Module Error (SalesRegister)", e);
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
      getSalesRegisterData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getSalesRegisterData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getSalesRegisterData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getSalesRegisterData();
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}

