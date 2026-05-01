import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class RoleRepository {
  final _api = ApiService.to;

  Future<List<CommonDropdownModel>> roleDropdown({String? companyId}) async {
    final ResModel res = await _api.get(
      ApiConstants.roleDropdown(companyFilter: companyId),
    );

    if (res.status == 200) {
      return res.data
          .map<CommonDropdownModel>(
            (json) => CommonDropdownModel.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    }

    throw Exception(res.message ?? "can't get the countrys");
  }
}
