import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/bank_cash/salary_model.dart';

import 'package:ai_setu/data/repositories/salary_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalaryController extends GetxController {
  static SalaryController get instance => Get.find();

  final _repository = SalaryRepository();

  final salaries = <SalaryModel>[].obs;
  final selectedDateRange = FinancialYearController.to.selectedRange.obs;

  late Worker _fyWorker;
  late Worker _branchWorker;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache = <String, ({List<SalaryModel> items, DateTime fetchedAt})>{};
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
    _setupGlobalFilters();
  }

  void _setupGlobalFilters() {
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        selectedDateRange.value = year.dateRange;
        _clearCache();
        getSalaryData();
      }
    });

    _branchWorker = ever(BranchController.to.selectedBranch, (_) {
      _clearCache();
      getSalaryData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getSalaryData();
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) {
    final branchId = BranchController.to.selectedBranch.value?.id;
    return '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}_$branchId';
  }

  Future<void> getSalaryData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      salaries.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final pagination = await _repository.getAllSalaries(
        page: currentPage.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: filters['activeFilter'],
        branchId: BranchController.to.selectedBranch.value?.id,
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      salaries.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("Bank/Cash Module Error", e);
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
      getSalaryData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getSalaryData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getSalaryData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getSalaryData();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    _fyWorker.dispose();
    _branchWorker.dispose();
    super.onClose();
  }
}
