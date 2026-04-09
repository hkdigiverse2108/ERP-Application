import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PosRepositories {
  final ApiService _api = ApiService.to;

  Future<ResModel> getAllPosOrder(Map<String, dynamic> params) async {
    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllPosOrder,
      params,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getAllSalesRegister(Map<String, dynamic> params) async {
    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllPosCashRegister,
      params,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getAllPosCreditNote(Map<String, dynamic> params) async {
    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllPosCreditNote,
      params,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }
}
