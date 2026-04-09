import 'package:ai_setu/data/model/pos/credit_note_model.dart';
import 'package:ai_setu/data/model/pos/oredr_list_model.dart';
import 'package:ai_setu/data/model/pos/sales_register_model.dart';
import 'package:ai_setu/data/repositories/pos_repositories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosController extends GetxController {
  static PosController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalItems = 0.obs;
  final RxInt limit = 10.obs;
  final RxString searchQuery = ''.obs;
  final RxMap<String, dynamic> filters = RxMap<String, dynamic>();
  final RxString activeModule = ''.obs;

  final Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    ),
  );

  final RxList<SalesRegisterModel> salesRegisters =
      RxList<SalesRegisterModel>();
  final RxList<OredrListModel> posOrders = RxList<OredrListModel>();
  final RxList<CreditNoteModel> creditNotes = RxList<CreditNoteModel>();

  final repo = PosRepositories();

  @override
  void onInit() {
    super.onInit();
    ever(selectedDateRange, (_) => refreshData());
  }

  void setActiveModule(String module) {
    if (activeModule.value != module) {
      activeModule.value = module;
      currentPage.value = 1;
      // We don't call refreshData here because the view will call it or we'll trigger it.
      // Actually, calling it here is better for first load.
      refreshData();
    }
  }

  void refreshData() {
    if (activeModule.value == 'salesRegister') {
      fetchSalesRegisters();
    } else if (activeModule.value == 'orderList') {
      fetchPosOrders();
    } else if (activeModule.value == 'creditNote') {
      fetchCreditNotes();
    }
  }

  Map<String, dynamic> _getParams() {
    return {
      "page": currentPage.value,
      "limit": limit.value,
      "search": searchQuery.value,
      "startDate": selectedDateRange.value.start.toIso8601String(),
      "endDate": selectedDateRange.value.end.toIso8601String(),
      ...filters,
    };
  }

  Future<void> fetchSalesRegisters() async {
    isLoading.value = true;
    try {
      final res = await repo.getAllSalesRegister(_getParams());
      final List targetList = _extractList(res.data, "pos_cash_register_data");

      salesRegisters.assignAll(
        targetList.map((e) => SalesRegisterModel.fromJson(e)).toList(),
      );

      _extractPagination(res.data);
    } catch (e) {
      debugPrint("Error fetching sales registers: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPosOrders() async {
    isLoading.value = true;
    try {
      final res = await repo.getAllPosOrder(_getParams());
      final List targetList = _extractList(res.data, "pos_order_data");

      posOrders.assignAll(
        targetList.map((e) => OredrListModel.fromJson(e)).toList(),
      );

      _extractPagination(res.data);
    } catch (e) {
      debugPrint("Error fetching POS orders: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCreditNotes() async {
    isLoading.value = true;
    try {
      final res = await repo.getAllPosCreditNote(_getParams());
      final List targetList = _extractList(res.data, "pos_credit_note_data");

      creditNotes.assignAll(
        targetList.map((e) => CreditNoteModel.fromJson(e)).toList(),
      );

      _extractPagination(res.data);
    } catch (e) {
      debugPrint("Error fetching Credit Notes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List _extractList(dynamic data, String fallbackKey) {
    if (data is Map) {
      if (data.containsKey("data") && data["data"] is List) return data["data"];
      if (data.containsKey(fallbackKey) && data[fallbackKey] is List)
        return data[fallbackKey];

      for (var val in data.values) {
        if (val is List && val.isNotEmpty) return val;
      }
    } else if (data is List) {
      return data;
    }
    return [];
  }

  void _extractPagination(dynamic data) {
    if (data is Map) {
      if (data['state'] != null) {
        totalPages.value =
            int.tryParse(data['state']['totalPages']?.toString() ?? '1') ?? 1;
        // Check if totalItems is inside state
        if (data['state']['totalItems'] != null) {
          totalItems.value = int.tryParse(data['state']['totalItems'].toString()) ?? 0;
        }
      }
      
      // Look for total items at top level if not found in state
      if (totalItems.value == 0) {
        totalItems.value = int.tryParse(
          data['totalData']?.toString() ??
          data['totalItems']?.toString() ??
          data['total']?.toString() ??
          '0'
        ) ?? 0;
      }
    }
  }

  void onSearch(String query) {
    searchQuery.value = query;
    currentPage.value = 1;
    refreshData();
  }

  void onFiltersChanged(Map<String, dynamic> newFilters) {
    filters.assignAll(newFilters);
    currentPage.value = 1;
    refreshData();
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      refreshData();
    }
  }
}
