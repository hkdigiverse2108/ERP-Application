import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';

import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/sales/sales_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EstimateController extends GetxController {
  static EstimateController get instance => Get.find();

  final _repository = SalesRepository();
  final _contactRepository = ContactRepository();

  final estimates = <EstimateModel>[].obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final customers = <ContactDropdownModel>[].obs;

  // Caching
  final _cache = <String, ({List<EstimateModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final isLodding = false.obs;
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

    // Listen to global branch changes
    ever(BranchController.to.selectedBranch, (_) {
      _clearCache();
      getEstimatesData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getCustomers();
    getEstimatesData();
  }

  Future<void> getCustomers() async {
    try {
      final res = await _contactRepository.getContactDropdown(
        typeFilter: ContactType.customer.name,
      );
      customers.value = res;
    } catch (e) {
      Log.e("Sales Module Error (Estimate)", e);
    }
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) {
    final branchId = BranchController.to.selectedBranch.value?.id;
    return '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}_$branchId';
  }

  Future<void> getEstimatesData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      estimates.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final pagination = await _repository.getEstimate(
        page: currentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        customerFilter: filters['customerFilter'],
        statusFilter: filters['statusFilter'],
        activeFilter: filters['activeFilter'],
        branchId:
            filters['branchFilter'] ??
            BranchController.to.selectedBranch.value?.id,
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      estimates.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
      currentPage.value = pagination.currentPage;
    } catch (e) {
      Log.e("Sales Module Error (Estimate)", e);
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
      getEstimatesData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getEstimatesData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getEstimatesData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getEstimatesData();
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}
