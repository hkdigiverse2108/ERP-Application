import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';

class TaxRepository {
  final ApiService _api = ApiService.to;

  Future<List<TaxDropdownModel>> getTaxes() async {
    final ResModel response = await _api.get(ApiConstants.taxDropdown);
    if (response.status == 200) {
      return List<TaxDropdownModel>.from(
        (response.data as List).map((x) => TaxDropdownModel.fromJson(x)),
      );
    }
    throw Exception(response.message ?? "Failed to load taxes");
  }
}
