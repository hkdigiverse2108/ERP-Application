import 'dart:async';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalChargeController extends GetxController {
  static AdditionalChargeController get instance => Get.find();

  final _repo = AdditionalChargeRepository();

  // Observable state
  final charges = <AdditionalChargeModel>[].obs;
  final isLoading = false.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final limit = 10.obs;

  // Search and Filters
  final searchQuery = "".obs;
  final activeFilter = "".obs;
  Timer? _searchDebounce;

  // Cache settings
  final _cache = <String, dynamic>{};
  final _cacheTimestamp = <String, DateTime>{};
  static const _cacheDuration = Duration(minutes: 5);

  @override
  void onInit() {
    super.onInit();
    getCharges();
  }

  Future<void> getCharges({bool useCache = true}) async {
    final cacheKey =
        "charges_${currentPage.value}_${limit.value}_${searchQuery.value}_${activeFilter.value}";

    // Check cache
    if (useCache && _cache.containsKey(cacheKey)) {
      final timestamp = _cacheTimestamp[cacheKey];
      if (timestamp != null &&
          DateTime.now().difference(timestamp) < _cacheDuration) {
        charges.value = _cache[cacheKey];
        return;
      }
    }

    try {
      isLoading.value = true;
      final result = await _repo.getAdditionalCharges(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value,
        activeFilter: activeFilter.value,
      );

      charges.value = result.items;
      totalPages.value = result.totalPages;
      totalItems.value = result.totalItems;

      // Update cache
      _cache[cacheKey] = result.items;
      _cacheTimestamp[cacheKey] = DateTime.now();
    } catch (e) {
      Log.e("Settings Module Error (AdditionalCharge)", e);
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = query;
      currentPage.value = 1;
      _clearCache();
      getCharges();
    });
  }

  void onFiltersChanged(Map<String, String?> filters) {
    activeFilter.value = filters['activeFilter'] ?? "";
    currentPage.value = 1;
    _clearCache();
    getCharges();
  }

  void goToPage(int page) {
    if (page < 1 || page > totalPages.value) return;
    currentPage.value = page;
    getCharges();
  }

  void _clearCache() {
    _cache.clear();
    _cacheTimestamp.clear();
  }
}
