import 'package:ai_setu/data/repositories/purchase_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart';
import 'package:ai_setu/data/model/purchase/purchase_debit_note_model.dart';
import 'package:intl/intl.dart';

class PurchaseController extends GetxController {
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final isLoading = false.obs;

  final purchaseOrderList = <PurchaseOrderModel>[].obs;
  final supplierBillList = <SupplierBillModel>[].obs;
  final purchaseDebitNoteList = <PurchaseDebitNoteModel>[].obs;

  final repo = PurchaseRepository();

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  void resetPagination() {
    currentPage.value = 1;
    totalPages.value = 1;
    totalItems.value = 0;
  }

  Future<void> fetchPurchaseOrders() async {
    try {
      isLoading.value = true;
      final api = Get.find<ApiService>();

      final String url =
          ApiConstants.buildUrl(ApiConstants.getAllPurchaseOrder, {
            "page": currentPage.value,
            "limit": 10,
            "fromDate": DateFormat(
              'yyyy-MM-dd',
            ).format(selectedDateRange.value.start),
            "toDate": DateFormat(
              'yyyy-MM-dd',
            ).format(selectedDateRange.value.end),
          });

      final res = await api.get(url);

      if (res.status == 200 && res.data != null) {
        final dynamic rawData = res.data;
        List<dynamic> targetList = _extractList(rawData);
        _extractPagination(rawData);

        purchaseOrderList.assignAll(
          targetList.map((e) => PurchaseOrderModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      debugPrint("Error fetching purchase orders: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSupplierBills() async {
    try {
      isLoading.value = true;
      final api = Get.find<ApiService>();

      final String url =
          ApiConstants.buildUrl(ApiConstants.getAllSupplierBill, {
            "page": currentPage.value,
            "limit": 10,
            "fromDate": DateFormat(
              'yyyy-MM-dd',
            ).format(selectedDateRange.value.start),
            "toDate": DateFormat(
              'yyyy-MM-dd',
            ).format(selectedDateRange.value.end),
          });

      final res = await api.get(url);

      if (res.status == 200 && res.data != null) {
        final dynamic rawData = res.data;
        List<dynamic> targetList = _extractList(rawData);
        _extractPagination(rawData);

        supplierBillList.assignAll(
          targetList.map((e) => SupplierBillModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      debugPrint("Error fetching supplier bills: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPurchaseDebitNotes() async {
    try {
      isLoading.value = true;
      final api = Get.find<ApiService>();

      final String url = ApiConstants.buildUrl(
        ApiConstants.getAllPurchaseDebitNote,
        {
          "page": currentPage.value,
          "limit": 10,
          "fromDate": DateFormat('yyyy-MM-dd').format(selectedDateRange.value.start),
          "toDate": DateFormat('yyyy-MM-dd').format(selectedDateRange.value.end),
        },
      );

      final res = await api.get(url);

      if (res.status == 200 && res.data != null) {
        final dynamic rawData = res.data;
        List<dynamic> targetList = _extractList(rawData);
        _extractPagination(rawData);

        purchaseDebitNoteList.assignAll(
          targetList.map((e) => PurchaseDebitNoteModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      debugPrint("Error fetching purchase debit notes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<dynamic> _extractList(dynamic rawData) {
    if (rawData is List) {
      return rawData;
    } else if (rawData is Map) {
      if (rawData.containsKey("data") && rawData["data"] is List) {
        return rawData["data"];
      } else if (rawData.containsKey("purchaseOrder_data") &&
          rawData["purchaseOrder_data"] is List) {
        return rawData["purchaseOrder_data"];
      } else if (rawData.containsKey("supplierBill_data") &&
          rawData["supplierBill_data"] is List) {
        return rawData["supplierBill_data"];
      } else if (rawData.containsKey("supplier_bill_data") &&
          rawData["supplier_bill_data"] is List) {
        return rawData["supplier_bill_data"];
      } else if (rawData.containsKey("purchaseDebitNote_data") && rawData["purchaseDebitNote_data"] is List) {
        return rawData["purchaseDebitNote_data"];
      } else if (rawData.containsKey("purchase_debit_note_data") && rawData["purchase_debit_note_data"] is List) {
        return rawData["purchase_debit_note_data"];
      } else {
        for (var value in rawData.values) {
          if (value is List) {
            return value;
          }
        }
      }
    }
    return [];
  }

  void _extractPagination(dynamic rawData) {
    if (rawData is Map) {
      if (rawData['state'] != null) {
        totalPages.value =
            int.tryParse(rawData['state']['totalPages']?.toString() ?? '0') ??
            1;
      }
      totalItems.value =
          int.tryParse(
            rawData['totalData']?.toString() ??
                rawData['total']?.toString() ??
                '0',
          ) ??
          0;
    }
  }
}
