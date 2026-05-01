import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';

import 'package:ai_setu/data/repositories/bank_cash/bank_repository.dart';
import 'package:get/get.dart';

class BankController extends GetxController {
  static BankController get instance => Get.find();

  final _repository = BankRepository();

  final banks = <BankModel>[].obs;
  final isLodding = false.obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache = <String, ({List<BankModel> items, DateTime fetchedAt})>{};
  final _cacheExpiry = const Duration(minutes: 5);

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  @override
  void onReady() {
    super.onReady();
    getBanksData();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}';

  Future<void> getBanksData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      banks.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final pagination = await _repository.getAllBanks(
        page: currentPage.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: filters['activeFilter'],
      );

      _cache[key] = (items: pagination.items, fetchedAt: DateTime.now());

      banks.value = pagination.items;
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("Bank/Cash Module Error (Bank)", e);
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
      getBanksData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getBanksData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getBanksData();
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}

