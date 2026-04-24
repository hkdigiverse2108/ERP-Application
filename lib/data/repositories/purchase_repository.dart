import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/purchase/purchase_debit_note_model.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PurchaseRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<PurchaseOrderModel>> getAllPurchaseOrder({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? supplierFilter,
    String? statusFilter,
    String? activeFilter,
  }) async {
    final String url = ApiConstants.getAllPurchaseOrder(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      supplierFilter: supplierFilter,
      statusFilter: statusFilter,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data["purchaseOrder_data"];
      final items = dataList != null
          ? dataList
                .map((e) => PurchaseOrderModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <PurchaseOrderModel>[];
      return PaginationModel<PurchaseOrderModel>.fromMap(
        res.data as Map<String, dynamic>,
        items,
      );
    } else {
      throw Exception(res.message);
    }
  }

  Future<PaginationModel<SupplierBillModel>> getAllSupplierBill({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? supplierFilter,
    String? paymentStatus,
    String? activeFilter,
  }) async {
    final String url = ApiConstants.getAllSupplierBill(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      supplierFilter: supplierFilter,
      paymentStatus: paymentStatus,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final List? dataList =
          res.data["supplierBill_data"] ?? res.data["supplier_bill_data"];
      final items = dataList != null
          ? dataList
                .map((e) => SupplierBillModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <SupplierBillModel>[];
      return PaginationModel<SupplierBillModel>.fromMap(
        res.data as Map<String, dynamic>,
        items,
      );
    } else {
      throw Exception(res.message);
    }
  }

  Future<PaginationModel<PurchaseDebitNoteModel>> getAllPurchaseDebitNote({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? supplierFilter,
    String? statusFilter,
    String? activeFilter,
  }) async {
    final String url = ApiConstants.getAllPurchaseDebitNote(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      supplierFilter: supplierFilter,
      statusFilter: statusFilter,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final List? dataList =
          res.data["purchaseDebitNote_data"] ??
          res.data["purchase_debit_note_data"];
      final items = dataList != null
          ? dataList
                .map(
                  (e) => PurchaseDebitNoteModel.fromMap(e as Map<String, dynamic>),
                )
                .toList()
          : <PurchaseDebitNoteModel>[];
      return PaginationModel<PurchaseDebitNoteModel>.fromMap(
        res.data as Map<String, dynamic>,
        items,
      );
    } else {
      throw Exception(res.message);
    }
  }
}
