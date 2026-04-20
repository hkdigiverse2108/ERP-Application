import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart';
import 'package:ai_setu/data/repositories/branch_repository.dart';
import 'package:ai_setu/data/repositories/material_consumption_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialConsumptionController extends GetxController {
  static MaterialConsumptionController get instance => Get.find();

  final _repo = MaterialConsumptionRepository();
  final _branchRepo = BranchRepository();
  final materialConsumptions = <MaterialConsumptionModel>[].obs;

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;
  final branches = <BranchDropdownModel>[].obs;

  // Caching
  final _cache =
      <String, ({List<MaterialConsumptionModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getMaterialConsumptionData();
    getBranchesDropdown();
  }

  Future<void> getBranchesDropdown() async {
    try {
      final res = await _branchRepo.getBranchesDropdown();
      branches.value = res;
    } catch (e) {
      Log.e("Inventory Module Error (MaterialConsumption)", e);
    }
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}';

  Future<void> getMaterialConsumptionData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      materialConsumptions.value = cached.items;
      return;
    }

    try {
      isLoading.value = true;
      final res = await _repo.getMaterialConsumptionList(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        filter: filters.isEmpty ? null : filters,
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      materialConsumptions.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      Log.e("Inventory Module Error (MaterialConsumption)", e);
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
      getMaterialConsumptionData();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getMaterialConsumptionData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getMaterialConsumptionData();
    }
  }
}
