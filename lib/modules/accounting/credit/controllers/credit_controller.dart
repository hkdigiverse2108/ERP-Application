import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'dart:async';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/accounting/cradit_note_model.dart';
import 'package:ai_setu/data/repositories/accounting/accounting_repository.dart';
import 'package:get/get.dart';

class CreditController extends GetxController {
  static CreditController get instance => Get.find();

  final _repository = AccountingRepository();

  final creditNotes = <CreditNoteModel>[].obs;

  // Search & Filter
  final searchQuery = ''.obs;
  final filters = <String, dynamic>{}.obs;
  Timer? _debounceTimer;

  // Caching
  final _cache =
      <String, ({List<CreditNoteModel> items, DateTime fetchedAt})>{};
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
    getCreditNotesData();
  }

  String _getCacheKey(int page) =>
      '${page}_${searchQuery.value}_${filters.toString()}';

  Future<void> getCreditNotesData() async {
    final key = _getCacheKey(currentPage.value);
    final cached = _cache[key];

    if (cached != null &&
        DateTime.now().difference(cached.fetchedAt) < _cacheExpiry) {
      creditNotes.value = cached.items;
      return;
    }

    try {
      isLodding.value = true;
      final ResModel res = await _repository.getCreditNote(
        page: currentPage.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: filters['activeFilter'],
      );

      if (res.status == 200 && res.data != null) {
        final List? dataList =
            res.data["creditNote_data"] ??
            res.data["purchaseCreditNote_data"] ??
            res.data["data"];

        final items = dataList != null
            ? dataList
                  .map(
                    (e) => CreditNoteModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
            : <CreditNoteModel>[];

        _cache[key] = (items: items, fetchedAt: DateTime.now());

        creditNotes.value = items;
        totalPages.value = res.data["state"]?["totalPages"] ?? 1;
        totalItems.value = res.data["totalData"] ?? 0;
      }
    } catch (e) {
      Log.e("Accounting Module Error (Credit)", e);
    } finally {
      isLodding.value = false;
    }
  }

  Future<void> deleteCreditNote({required String id}) async {
    try {
      final success = await _repository.deleteCreditNote(id: id);
      if (success) {
        AppSnackbar.success("Credit note deleted successfully");
        await refreshData();
      } else {
        AppSnackbar.error("Failed to delete credit note");
      }
    } catch (e) {
      Log.e("Error deleting credit note", e);
      AppSnackbar.error("An error occurred while deleting credit note");
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
      getCreditNotesData();
    });
  }

  void onFiltersChanged(Map<String, dynamic> filters) {
    this.filters.value = filters;
    _clearCache();
    getCreditNotesData();
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getCreditNotesData();
    }
  }

  Future<void> refreshData() async {
    _cache.clear();
    currentPage.value = 1;
    await getCreditNotesData();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
