import 'dart:isolate';

import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/category/category_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class CategoryRepository {
  final ApiService _api = ApiService.to;

  Future<List<CategoryDropdownModel>> getCategories({
    String? parentCategoryFilter,
    String? typeFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.categoryDropdown(
        parentCategoryFilter: parentCategoryFilter,
        typeFilter: typeFilter,
      ),
    );
    if (response.status == 200) {
      return await Isolate.run(() {
        return List<CategoryDropdownModel>.from(
          (response.data as List).map((x) => CategoryDropdownModel.fromMap(x)),
        );
      });
    }

    throw Exception(response.message ?? "Failed to load categories");
  }
}
