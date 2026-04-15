import 'dart:async';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart';
import 'package:ai_setu/data/repositories/contact_repository.dart';
import 'package:ai_setu/data/repositories/purchase_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SupplierBillController extends GetxController {
  static SupplierBillController get instance => Get.find();

  final _repository = PurchaseRepository();
  final _contactRepository = ContactRepository();

  final supplierBills = <SupplierBillModel>[].obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final suppliers = <ContactDropdownModel>[].obs;

  // Caching
  final _cache =
      <String, ({List<SupplierBillModel> items, DateTime fetchedAt})>{};
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
  }

  @override
  void onReady() {
    super.onReady();
    getSuppliers();
    getSupplierBillsData();
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}';

  Future<void> getSuppliers() async {
    try {
      final List<ContactDropdownModel> res = await _contactRepository
          .getContactDropdown(typeFilter: ContactType.supplier.name);
      suppliers.value = res;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getSupplierBillsData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      supplierBills.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final ResModel res = await _repository.getAllSupplierBill(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        supplierFilter: filters['supplierFilter'],
        paymentStatus: filters['paymentStatus'],
        activeFilter: filters['activeFilter'],
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
      );

      if (res.status == 200 && res.data != null) {
        final List? dataList =
            res.data["supplierBill_data"] ?? res.data["supplier_bill_data"];
        final items = dataList != null
            ? dataList
                  .map(
                    (e) =>
                        SupplierBillModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
            : <SupplierBillModel>[];

        _cache[key] = (items: items, fetchedAt: DateTime.now());

        supplierBills.value = items;
        totalPages.value = res.data["state"]?["totalPages"] ?? 1;
        totalItems.value = res.data["totalData"] ?? 0;
      }
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
      getSupplierBillsData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getSupplierBillsData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getSupplierBillsData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getSupplierBillsData();
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}
