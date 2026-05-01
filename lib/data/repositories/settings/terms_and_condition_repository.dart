import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';

class TermsAndConditionRepository {
  final ApiService _api = ApiService.to;

  Future<List<TermsAndConditionModel>> getTermsAndCondition({
    int? page,
    int? limit,
    String? search,
    String? branchId,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllTermsAndCondition(
        page: page,
        limit: limit,
        search: search,
        branchId: branchId,
        all: true,
      ),
    );
    if (res.status == 200 && res.data != null) {
      List listData = [];
      if (res.data is Map) {
        listData = res.data['termsCondition_data'] ?? res.data['data'] ?? [];
      } else if (res.data is List) {
        listData = res.data;
      }
      return listData.map((e) => TermsAndConditionModel.fromMap(e)).toList();
    } else {
      throw Exception(res.message ?? 'Failed to load terms and conditions');
    }
  }

  Future<ResModel> addTermsAndCondition(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addTermsAndCondition, body: data);
  }

  Future<ResModel> updateTermsAndCondition(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateTermsAndCondition, body: data);
  }
}
