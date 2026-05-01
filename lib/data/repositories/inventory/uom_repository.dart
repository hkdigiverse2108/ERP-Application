import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class UomRepository {
  final ApiService _api = ApiService.to;

  Future<List<CommonDropdownModel>> getUomDropdown() async {
    final ResModel response = await _api.get(ApiConstants.uomDropdown);
    if (response.status == 200) {
      return List<CommonDropdownModel>.from(
        (response.data as List).map((x) => CommonDropdownModel.fromMap(x)),
      );
    }
    throw Exception(response.message ?? "Failed to load UOMs");
  }
}
