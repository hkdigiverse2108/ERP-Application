import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/data/repositories/crm/coupon_repository.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponController extends GetxController {
  static CouponController get instance => Get.find();

  final _repository = CouponRepository();

  final couponList = <CouponModel>[].obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache = <String, ({List<CouponModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final isLoading = false.obs;
  Worker? _fyWorker;
  Worker? _branchWorker;

  @override
  void onInit() {
    super.onInit();
    selectedDateRange.value = FinancialYearController.to.selectedRange;
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        updateDateRange(year.dateRange);
      }
    });
    _branchWorker = ever(BranchController.to.selectedBranch, (branch) {
      if (branch == null) return;
      _clearCache();
      getCouponData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getCouponData();
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}_${_formatDate(selectedDateRange.value.start)}_${_formatDate(selectedDateRange.value.end)}';

  Future<void> getCouponData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      couponList.value = cached.items;
      return;
    }

    try {
      isLoading.value = true;
      final pagination = await _repository.getAllCoupon(
        page: currentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: filters['activeFilter'],
        // branchId: BranchController.to.selectedBranchId,
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      couponList.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("CRM Module Error (Coupon)", e);
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
      getCouponData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getCouponData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getCouponData();
    }
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    _clearCache();
    getCouponData();
  }

  Future<void> refreshData() async {
    _cache.clear();
    currentPage.value = 1;
    await getCouponData();
  }

  Future<void> deleteCoupon(String id) async {
    try {
      final ResModel res = await _repository.deleteCoupon(id);
      if (res.status == 200) {
        AppSnackbar.success(res.message ?? "Coupon deleted successfully");
        await refreshData();
      } else {
        AppSnackbar.error(res.message ?? "Failed to delete coupon");
      }
    } catch (e) {
      Log.e("CRM Module Error (Coupon Delete)", e);
      AppSnackbar.error("An error occurred while deleting coupon");
    }
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _branchWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}
