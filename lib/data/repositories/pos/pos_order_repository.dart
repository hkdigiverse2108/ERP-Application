import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PosOrderRepository {
  final _api = ApiService.to;

  Future<ResModel> addPosOrder(Map<String, dynamic> payload) async {
    return await _api.post(ApiConstants.addPosOrder, body: payload);
  }

  Future<ResModel> getCustomerPosDetails(String id) async {
    return await _api.get(ApiConstants.posOrderCustomer(id));
  }

  Future<ResModel> getHoldOrders() async {
    return await _api.get(ApiConstants.posOrderHold);
  }

  Future<ResModel> getPosOrderDetails(String id) async {
    return await _api.get(ApiConstants.posOrderById(id));
  }

  Future<ResModel> deletePosOrder(String id) async {
    return await _api.delete(ApiConstants.posOrderById(id));
  }

  Future<ResModel> editPosOrder(Map<String, dynamic> payload) async {
    return await _api.put(ApiConstants.editPosOrder, body: payload);
  }
}
