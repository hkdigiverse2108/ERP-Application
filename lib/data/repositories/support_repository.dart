import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class SupportRepository {
  final ApiService _api = ApiService.to;

  Future<ResModel> submitCallRequest(Map<String, dynamic> data) async {
    final ResModel res = await _api.post('call-request/add', body: data);
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? 'Failed to submit call request');
  }
}
