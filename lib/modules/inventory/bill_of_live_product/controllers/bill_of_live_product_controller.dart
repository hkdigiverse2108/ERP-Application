import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/data/repositories/settings/branch_repository.dart';
import 'package:ai_setu/data/repositories/inventory/bill_of_live_product_repository.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillOfLiveProductController extends GetxController {
  static BillOfLiveProductController get instance => Get.find();

  final _repo = BillOfLiveProductRepository();
  final _branchRepo = BranchRepository();
  final billOfLiveProducts = <BillOfLiveProductModel>[].obs;

  final selectedDateRange = FinancialYearController.to.selectedRange.obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final activeFilters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final branches = <BranchDropdownModel>[].obs;

  // Caching
  final _cache =
      <String, ({List<BillOfLiveProductModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final RxBool isLoading = false.obs;

  Worker? _fyWorker;
  Worker? _branchWorker;

  @override
  void onInit() {
    super.onInit();
    // Listen to date range changes
    ever(selectedDateRange, (_) {
      _clearCache();
      getBillOfLiveProductData();
    });

    // Listen to global financial year changes
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        selectedDateRange.value = year.dateRange;
      }
    });

    // Listen to global branch changes
    _branchWorker = ever(BranchController.to.selectedBranch, (branch) {
      if (branch == null) return;
      _clearCache();
      getBillOfLiveProductData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getBillOfLiveProductData();
    getBranchesDropdown();
  }

  Future<void> getBranchesDropdown() async {
    try {
      final res = await _branchRepo.getBranchesDropdown();
      branches.value = res;
    } catch (e) {
      Log.e("Inventory Module Error (BillOfLiveProduct Branches)", e);
    }
  }

  String _getCacheKey(int page) {
    final branchId = BranchController.to.selectedBranch.value?.id;
    return '${page}_${searchQuery.value}_${activeFilters.toString()}_${selectedDateRange.value.start}_${selectedDateRange.value.end}_$branchId';
  }

  Future<void> getBillOfLiveProductData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      billOfLiveProducts.value = cached.items;
      return;
    }

    try {
      isLoading.value = true;

      // Combine local filters with global branch and date range
      final Map<String, dynamic> combinedFilters = Map.from(activeFilters);

      // Global branch filter
      if (!combinedFilters.containsKey('branchFilter')) {
        final globalBranchId = BranchController.to.selectedBranch.value?.id;
        if (globalBranchId != null) {
          combinedFilters['branchFilter'] = globalBranchId;
        }
      }

      // Date range filters
      combinedFilters['startDate'] = DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDateRange.value.start);
      combinedFilters['endDate'] = DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDateRange.value.end);

      final res = await _repo.getBillOfLiveProductList(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        filter: combinedFilters,
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      billOfLiveProducts.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      Log.e("Inventory Module Error (BillOfLiveProduct)", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    _cache.clear();
    currentPage.value = 1;
    await getBillOfLiveProductData();
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
      getBillOfLiveProductData();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    _fyWorker?.dispose();
    _branchWorker?.dispose();
    super.onClose();
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    activeFilters.value = filters;
    _clearCache();
    getBillOfLiveProductData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getBillOfLiveProductData();
    }
  }

  Future<void> deleteBillOfLiveProduct(String id) async {
    try {
      final success = await _repo.deleteBillOfLiveProduct(id);
      if (success) {
        AppSnackbar.success("Bill of live product deleted successfully");
        await refreshData();
      } else {
        AppSnackbar.error("Failed to delete bill of live product");
      }
    } catch (e) {
      Log.e("Error deleting bill of live product", e);
      AppSnackbar.error(
        "An error occurred while deleting bill of live product",
      );
    }
  }
}
