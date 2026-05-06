import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'dart:async';

import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/purchase/purchase_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurchaseOrderController extends GetxController {
  static PurchaseOrderController get instance => Get.find();

  final _repository = PurchaseRepository();
  final _contactRepository = ContactRepository();

  final purchaseOrders = <PurchaseOrderModel>[].obs;
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
      <String, ({List<PurchaseOrderModel> items, DateTime fetchedAt})>{};
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
    getPurchaseOrdersData();
  }

  Future<void> getSuppliers() async {
    try {
      final res = await _contactRepository.getContactDropdown(
        typeFilter: ContactType.supplier.name,
      );
      suppliers.value = res;
    } catch (e) {
      Log.e("Purchase Module Error (PurchaseOrder)", e);
    }
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}';

  Future<void> getPurchaseOrdersData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      purchaseOrders.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final res = await _repository.getAllPurchaseOrder(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        supplierFilter: filters['supplierFilter'],
        statusFilter: filters['statusFilter'],
        activeFilter: filters['activeFilter'],
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      purchaseOrders.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
    } catch (e) {
      Log.e("Purchase Module Error (PurchaseOrder)", e);
    } finally {
      isLodding.value = false;
    }
  }

  Future<void> deletePurchaseOrder(String id) async {
    try {
      final ResModel res = await _repository.deletePurchaseOrder(id);
      if (res.status == 200) {
        AppSnackbar.success(
          res.message ?? "Purchase order deleted successfully",
        );
        await refreshData();
      } else {
        AppSnackbar.error(res.message ?? "Failed to delete purchase order");
      }
    } catch (e) {
      Log.e("Purchase Module Error (PurchaseOrder Delete)", e);
      AppSnackbar.error("An error occurred while deleting purchase order");
    }
  }

  Future<void> refreshData() async {
    _cache.clear();
    currentPage.value = 1;
    await getPurchaseOrdersData();
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
      getPurchaseOrdersData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getPurchaseOrdersData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getPurchaseOrdersData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getPurchaseOrdersData();
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}
