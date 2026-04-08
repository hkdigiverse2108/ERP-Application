import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PurchaseRepository {
  final ApiService _api = ApiService.to;

  Future<ResModel> getAllPurchaseOrder(Map<String, dynamic> params) async {
    final String url =
        ApiConstants.buildUrl(ApiConstants.getAllPurchaseOrder, params);

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getAllSupplierBill(Map<String, dynamic> params) async {
    final String url =
        ApiConstants.buildUrl(ApiConstants.getAllSupplierBill, params);

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getAllPurchaseDebitNote(Map<String, dynamic> params) async {
    final String url =
        ApiConstants.buildUrl(ApiConstants.getAllPurchaseDebitNote, params);

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }
}
