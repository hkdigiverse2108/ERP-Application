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
                .map(
                  (e) => PurchaseOrderModel.fromMap(e as Map<String, dynamic>),
                )
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

  Future<ResModel> addPurchaseOrder(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addPurchaseOrder, body: data);
  }

  Future<ResModel> updatePurchaseOrder(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updatePurchaseOrder, body: data);
  }

  Future<PurchaseOrderModel> getPurchaseOrderById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getPurchaseOrderById(id));
    if (res.status == 200 && res.data != null) {
      return PurchaseOrderModel.fromMap(res.data as Map<String, dynamic>);
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> deletePurchaseOrder(String id) async {
    return await _api.delete(ApiConstants.deletePurchaseOrder(id));
  }

  // Supplier Bill
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
                .map(
                  (e) => SupplierBillModel.fromMap(e as Map<String, dynamic>),
                )
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

  Future<ResModel> addSupplierBill(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addSupplierBill, body: data);
  }

  Future<ResModel> updateSupplierBill(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateSupplierBill, body: data);
  }

  Future<SupplierBillModel> getSupplierBillById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getSupplierBillById(id));
    if (res.status == 200 && res.data != null) {
      return SupplierBillModel.fromMap(res.data as Map<String, dynamic>);
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> deleteSupplierBill(String id) async {
    return await _api.delete(ApiConstants.deleteSupplierBill(id));
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
                  (e) =>
                      PurchaseDebitNoteModel.fromMap(e as Map<String, dynamic>),
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

  Future<ResModel> addPurchaseDebitNote(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addPurchaseDebitNote, body: data);
  }

  Future<ResModel> updatePurchaseDebitNote(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updatePurchaseDebitNote, body: data);
  }

  Future<PurchaseDebitNoteModel> getPurchaseDebitNoteById(String id) async {
    final ResModel res =
        await _api.get(ApiConstants.getPurchaseDebitNoteById(id));
    if (res.status == 200 && res.data != null) {
      return PurchaseDebitNoteModel.fromMap(res.data as Map<String, dynamic>);
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> deletePurchaseDebitNote(String id) async {
    return await _api.delete(ApiConstants.deletePurchaseDebitNote(id));
  }
}
