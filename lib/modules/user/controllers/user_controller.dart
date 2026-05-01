import 'package:ai_setu/core/services/logger_service.dart';
import 'dart:async';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/user/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _repo = UserRepository();

  final users = <UserModel>[].obs;
  final activeFilter = Rxn<String>();

  // Search & Filter
  final searchQuery = ''.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache =
      <
        String,
        ({
          List<UserModel> items,
          DateTime fetchedAt,
          int totalPages,
          int totalItems,
        })
      >{};
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
      '${page}_${searchQuery.value}_${activeFilter.value}';

  Future<void> getUsersData({int page = 1}) async {
    final key = _getCacheKey(page);
    final cached = _cache[key];

    // Check if cache exists and is not expired
    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      users.value = cached.items;
      totalPages.value = cached.totalPages;
      totalItems.value = cached.totalItems;
      currentPage.value = page;
      return;
    }

    try {
      isLodding.value = true;
      final res = await _repo.getAllUser(
        page: page,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: activeFilter.value,
      );

      _cache[key] = (
        items: res.items,
        fetchedAt: DateTime.now(),
        totalPages: res.totalPages,
        totalItems: res.totalItems,
      );

      users.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = page;
    } catch (e) {
      Log.e("Error fetching users", e);
    } finally {
      isLodding.value = false;
    }
  }

  void onSearch(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = query;
      _cache.clear();
      getUsersData(page: 1);
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    activeFilter.value = filters['activeFilter'];
    _cache.clear();
    getUsersData(page: 1);
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      await getUsersData(page: page);
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}

