import 'dart:async';

import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _repo = UserRepository();

  final users = <UserModel>[].obs;
  final filters = <String, dynamic>{}.obs;

  // Search & Filter
  final searchQuery = ''.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache = <String, ({List<UserModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final isLodding = false.obs;

  @override
  void onReady() {
    super.onReady();
    getUsersData();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}';

  Future<void> getUsersData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    // Check if cache exists and is not expired
    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      users.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final res = await _repo.getAllUser(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        filters: filters.isEmpty ? null : filters,
      );

      _cache[key] = (items: res.items, fetchedAt: DateTime.now());

      users.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
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
      getUsersData();
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
    getUsersData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getUsersData();
    }
  }
}
