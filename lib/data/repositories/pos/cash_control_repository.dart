import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class CashControlRepository {
  final _api = ApiService.to;

  Future<ResModel> getAllCashControl({
    int? page,
    int? limit,
    String? activeFilter,
    String? registerFilter,
    String? branchId,
  }) async {
    return await _api.get(ApiConstants.getAllCashControl(
      page: page,
      limit: limit,
      activeFilter: activeFilter,
      registerFilter: registerFilter,
      branchId: branchId,
    ));
  }

  Future<ResModel> addCashControl(Map<String, dynamic> payload) async {
    return await _api.post(ApiConstants.addCashControl, body: payload);
  }

  Future<ResModel> getCashControlById(String id) async {
    return await _api.get(ApiConstants.getCashControlById(id));
  }

  Future<ResModel> updateCashControl(Map<String, dynamic> payload) async {
    return await _api.put(ApiConstants.updateCashControl, body: payload);
  }

  Future<ResModel> deleteCashControl(String id) async {
    return await _api.delete(ApiConstants.deleteCashControl(id));
  }
}
