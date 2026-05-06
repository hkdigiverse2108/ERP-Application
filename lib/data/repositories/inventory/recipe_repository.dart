import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/recipe_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class RecipeRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<RecipeModel>> getRecipeList({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllRecipe(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
      ),
    );

    if (response.status == 200) {
      final items = (response.data['recipe_data'] as List)
          .map((x) => RecipeModel.fromMap(x as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load recipes');
  }

  Future<RecipeModel> getRecipeById(String id) async {
    final ResModel response = await _api.get(ApiConstants.getRecipeById(id));

    if (response.status == 200 && response.data != null) {
      return RecipeModel.fromMap(response.data as Map<String, dynamic>);
    }

    throw Exception(response.message ?? 'Failed to load recipe detail');
  }

  Future<bool> addRecipe(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(ApiConstants.addRecipe,body: data);
    return response.status == 200;
  }

  Future<bool> updateRecipe(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(ApiConstants.updateRecipe, body: data);
    return response.status == 200;
  }

  Future<bool> deleteRecipe(String id) async {
    final ResModel response = await _api.delete(ApiConstants.deleteRecipe(id));
    return response.status == 200;
  }
}
