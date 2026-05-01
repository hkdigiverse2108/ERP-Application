import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';

import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/bank_cash/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  final _repository = PaymentRepository();
  final _contactRepository = ContactRepository();
  final VoucherType? voucherType;

  PaymentController({this.voucherType = VoucherType.purchase});

  final payments = <PosPaymentModel>[].obs;
  final selectedDateRange = FinancialYearController.to.selectedRange.obs;

  late Worker _fyWorker;
  late Worker _branchWorker;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final customers = <ContactDropdownModel>[].obs;

  // Caching
  final _cache =
      <String, ({List<PosPaymentModel> items, DateTime fetchedAt})>{};
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
        getPaymentsData();
      }
    });

    _branchWorker = ever(BranchController.to.selectedBranch, (_) {
      _clearCache();
      getPaymentsData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getCustomers();
    getPaymentsData();
  }

  Future<void> getCustomers() async {
    try {
      final res = await _contactRepository.getContactDropdown(
        typeFilter: ContactType.customer.name,
      );
      customers.value = res;
    } catch (e) {
      Log.e("Bank/Cash Module Error (Payment)", e);
    }
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) {
    final branchId = BranchController.to.selectedBranch.value?.id;
    return '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}_$branchId';
  }

  Future<void> getPaymentsData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      payments.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final pagination = await _repository.getAllPayments(
        page: currentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        voucherTypeFilter: voucherType?.name,
        partyFilter: filters['partyFilter'],
        paymentTypeFilter: filters['paymentTypeFilter'],
        activeFilter: filters['activeFilter'],
        branchId: BranchController.to.selectedBranch.value?.id,
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      payments.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("Bank/Cash Module Error (Payment)", e);
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
      getPaymentsData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getPaymentsData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getPaymentsData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getPaymentsData();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    _fyWorker.dispose();
    _branchWorker.dispose();
    super.onClose();
  }
}

