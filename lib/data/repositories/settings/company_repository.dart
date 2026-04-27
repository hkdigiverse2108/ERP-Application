import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/company_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class CompanyRepository {
  final _api = ApiService.to;

  Future<CompanyModel> getCompanyById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getCompanyById(id));
    if (res.status == 200) {
      if (res.data is Map && res.data['user_data'] != null) {
        // Some APIs wrap in user_data even for company, check logic
        return CompanyModel.fromMap(res.data['user_data']);
      }
      return CompanyModel.fromMap(res.data);
    }
    throw Exception(
      res.message ?? "Something went wrong while fetching company details",
    );
  }

  Future<ResModel> updateCompany(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateCompany, body: data);
  }
}
