import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class CashRegisterRepository {
  final ApiService _api = ApiService.to;

  Future<ResModel> getRegisterDetails() async {
    return await _api.get(ApiConstants.getCashRegisterDetails);
  }

  Future<ResModel> openRegister(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addPosCashRegister, body: data);
  }

  Future<ResModel> closeRegister(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updatePosCashRegister, body: data);
  }
}
