import 'dart:async';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class PaymentTermsController extends GetxController {
  static PaymentTermsController get instance => Get.find();

  final _repo = PaymentTermsRepository();

  // Observable state
  final paymentTerms = <PaymentTermsModel>[].obs;
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
    getPaymentTerms();
  }

  Future<void> getPaymentTerms({bool useCache = true}) async {
    final cacheKey =
        "payment_terms_${currentPage.value}_${limit.value}_${searchQuery.value}_${activeFilter.value}";

    // Check cache
    if (useCache && _cache.containsKey(cacheKey)) {
      final timestamp = _cacheTimestamp[cacheKey];
      if (timestamp != null &&
          DateTime.now().difference(timestamp) < _cacheDuration) {
        paymentTerms.value = _cache[cacheKey];
        return;
      }
    }

    try {
      isLoading.value = true;
      final result = await _repo.getPaymentTerms(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value,
        activeFilter: activeFilter.value,
      );

      paymentTerms.value = result.items;
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
      getPaymentTerms();
    });
  }

  void onFiltersChanged(Map<String, String?> filters) {
    activeFilter.value = filters['activeFilter'] ?? "";
    currentPage.value = 1;
    _clearCache();
    getPaymentTerms();
  }

  void goToPage(int page) {
    if (page < 1 || page > totalPages.value) return;
    currentPage.value = page;
    getPaymentTerms();
  }

  Future<void> refreshData() async {
    _clearCache();
    await getPaymentTerms();
  }

  void _clearCache() {
    _cache.clear();
    _cacheTimestamp.clear();
  }

  Future<void> deletePaymentTerm(String id) async {
    try {
      isLoading.value = true;
      await _repo.deletePaymentTerm(id);
      await refreshData();
      AppSnackbar.success("Payment term deleted successfully");
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
