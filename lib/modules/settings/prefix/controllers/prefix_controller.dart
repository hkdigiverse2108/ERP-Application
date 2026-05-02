import 'dart:async';
import 'package:ai_setu/data/model/prefix/prefix_model.dart';
import 'package:ai_setu/data/repositories/settings/prefix_repository.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class PrefixController extends GetxController {
  static PrefixController get instance => Get.find();

  final _repo = PrefixRepository();

  // Observable state
  final prefixes = <PrefixModel>[].obs;
  final isLoading = false.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final limit = 10.obs;

  // Search
  final searchQuery = "".obs;
  Timer? _searchDebounce;

  // Cache settings
  final _cache = <String, dynamic>{};
  final _cacheTimestamp = <String, DateTime>{};
  static const _cacheDuration = Duration(minutes: 5);

  @override
  void onInit() {
    super.onInit();
    getPrefixes();
  }

  Future<void> getPrefixes({bool useCache = true}) async {
    final cacheKey =
        "prefixes_${currentPage.value}_${limit.value}_${searchQuery.value}";

    // Check cache
    if (useCache && _cache.containsKey(cacheKey)) {
      final timestamp = _cacheTimestamp[cacheKey];
      if (timestamp != null &&
          DateTime.now().difference(timestamp) < _cacheDuration) {
        prefixes.value = _cache[cacheKey];
        return;
      }
    }

    try {
      isLoading.value = true;
      final result = await _repo.getAllPrefixes(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value,
      );

      prefixes.value = result.items;
      totalPages.value = result.totalPages;
      totalItems.value = result.totalItems;

      // Update cache
      _cache[cacheKey] = result.items;
      _cacheTimestamp[cacheKey] = DateTime.now();
    } catch (e) {
      AppSnackbar.error(e.toString());
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
      getPrefixes();
    });
  }

  void goToPage(int page) {
    if (page < 1 || page > totalPages.value) return;
    currentPage.value = page;
    getPrefixes();
  }

  void _clearCache() {
    _cache.clear();
    _cacheTimestamp.clear();
  }
}
