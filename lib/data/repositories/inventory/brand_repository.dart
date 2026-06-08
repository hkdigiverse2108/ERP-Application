import 'dart:isolate';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/brand/brand_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class BrandRepository {
  final ApiService _api = ApiService.to;

  Future<List<BrandDropdownModel>> getBrands({
    String? parentBrandFilter,
    String? typeFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.brandDropdown(
        parentBrandFilter: parentBrandFilter,
        typeFilter: typeFilter,
      ),
    );
    if (response.status == 200) {
      return await Isolate.run(() {
        return List<BrandDropdownModel>.from(
          (response.data as List).map((x) => BrandDropdownModel.fromMap(x)),
        );
      });
    }

    throw Exception(response.message ?? "Failed to load brands");
  }
}
