import 'dart:async';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/consumption_type/consumption_type_model.dart';
import 'package:ai_setu/data/repositories/settings/consumption_type_repository.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:get/get.dart';

class ConsumptionTypeController extends GetxController {
  static ConsumptionTypeController get instance => Get.find();

  final _repo = ConsumptionTypeRepository();

  // Observable state
  final types = <ConsumptionTypeModel>[].obs;
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
    getConsumptionTypes();
  }

  Future<void> getConsumptionTypes({bool useCache = true}) async {
    final cacheKey =
        "consumption_${currentPage.value}_${limit.value}_${searchQuery.value}_${activeFilter.value}";

    // Check cache
    if (useCache && _cache.containsKey(cacheKey)) {
      final timestamp = _cacheTimestamp[cacheKey];
      if (timestamp != null &&
          DateTime.now().difference(timestamp) < _cacheDuration) {
        types.value = _cache[cacheKey];
        return;
      }
    }

    try {
      isLoading.value = true;
      final result = await _repo.getConsumptionTypes(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value,
        activeFilter: activeFilter.value,
      );

      types.value = result.items;
      totalPages.value = result.totalPages;
      totalItems.value = result.totalItems;

      // Update cache
      _cache[cacheKey] = result.items;
      _cacheTimestamp[cacheKey] = DateTime.now();
    } catch (e) {
      Log.e("Settings Module Error (ConsumptionType)", e);
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
      getConsumptionTypes();
    });
  }

  void onFiltersChanged(Map<String, String?> filters) {
    activeFilter.value = filters['activeFilter'] ?? "";
    currentPage.value = 1;
    _clearCache();
    getConsumptionTypes();
  }

  void goToPage(int page) {
    if (page < 1 || page > totalPages.value) return;
    currentPage.value = page;
    getConsumptionTypes();
  }

  Future<void> refreshData() async {
    _clearCache();
    await getConsumptionTypes();
  }

  Future<void> deleteConsumptionType(String id) async {
    try {
      final item = types.firstWhereOrNull((e) => e.id == id);
      if (item != null && item.isSystemGenerated) {
        AppSnackbar.error(
          "System-generated consumption type cannot be deleted",
        );
        return;
      }
      await _repo.deleteConsumptionType(id);
      AppSnackbar.success("Consumption type deleted successfully");
      await refreshData();
    } catch (e) {
      AppSnackbar.error(e.toString());
    }
  }

  void _clearCache() {
    _cache.clear();
    _cacheTimestamp.clear();
  }
}
