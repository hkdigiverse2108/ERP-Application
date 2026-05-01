import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';

import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/selas/invoice_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/sales/sales_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InvoiceController extends GetxController {
  static InvoiceController get instance => Get.find();

  final _repository = SalesRepository();
  final _contactRepository = ContactRepository();

  final invoices = <InvoiceModel>[].obs;
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
  final _cache = <String, ({List<InvoiceModel> items, DateTime fetchedAt})>{};
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
    // Start with global FY range
    selectedDateRange.value = FinancialYearController.to.selectedRange;

    // Listen to changes
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        updateDateRange(year.dateRange);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getCustomers();
    getInvoicesData();
  }

  Future<void> getCustomers() async {
    try {
      final res = await _contactRepository.getContactDropdown(
        typeFilter: ContactType.customer.name,
      );
      customers.value = res;
    } catch (e) {
      Log.e("Sales Module Error (Invoice)", e);
    }
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}';

  Future<void> getInvoicesData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      invoices.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final pagination = await _repository.getInvoice(
        page: currentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        customerFilter: filters['customerFilter'],
        statusFilter: filters['statusFilter'],
        activeFilter: filters['activeFilter'],
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      invoices.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
      currentPage.value = pagination.currentPage;
    } catch (e) {
      Log.e("Sales Module Error (Invoice)", e);
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
      getInvoicesData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getInvoicesData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getInvoicesData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getInvoicesData();
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}

