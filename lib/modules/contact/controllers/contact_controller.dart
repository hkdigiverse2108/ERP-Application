import 'dart:async';

import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  static ContactController get instance => Get.find();

  final isLoading = false.obs;
  final contactList = <ContactModel>[].obs;

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final limit = 10.obs;

  final searchController = TextEditingController();
  final typeFilter = Rx<String?>(null);
  final activeFilter = Rx<String?>(null);

  final _repo = ContactRepository();

  // Caching
  final _cache =
      <
        String,
        ({
          List<ContactModel> items,
          DateTime fetchedAt,
          int totalPages,
          int totalItems,
        })
      >{};
  final _cacheExpiry = const Duration(minutes: 5);

  // Search Timer
  Timer? _debounceTimer;

  @override
  void onReady() {
    super.onReady();
    fetchContacts();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchController.text}_${typeFilter.value}_${activeFilter.value}';

  Future<void> fetchContacts() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    // Check if cache exists and is not expired
    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      contactList.value = cached.items;
      totalPages.value = cached.totalPages;
      totalItems.value = cached.totalItems;
      return;
    }

    try {
      isLoading.value = true;
      final response = await _repo.getContacts(
        page: currentPage.value,
        limit: limit.value,
        search: searchController.text.isEmpty ? null : searchController.text,
        typeFilter: typeFilter.value,
        activeFilter: activeFilter.value,
      );

      _cache[key] = (
        items: response.items,
        fetchedAt: DateTime.now(),
        totalPages: response.totalPages,
        totalItems: response.totalItems,
      );

      contactList.assignAll(response.items);
      totalPages.value = response.totalPages;
      totalItems.value = response.totalItems;
      currentPage.value = response.currentPage;
    } catch (e) {
      debugPrint(e.toString());
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
      _clearCache();
      fetchContacts();
    });
  }

  void onFiltersChanged(Map<String, String?> filters) {
    typeFilter.value = filters['typeFilter'];
    activeFilter.value = filters['activeFilter'];
    _clearCache();
    fetchContacts();
  }

  void goToPage(int page) {
    currentPage.value = page;
    fetchContacts();
  }
}
