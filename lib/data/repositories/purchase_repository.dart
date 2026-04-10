import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PurchaseRepository {
  final ApiService _api = ApiService.to;

  Future<ResModel> getAllPurchaseOrder({
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
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getAllSupplierBill({
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
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getAllPurchaseDebitNote({
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
      return res;
    } else {
      throw Exception(res.message);
    }
  }
}
