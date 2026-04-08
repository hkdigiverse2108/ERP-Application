import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class MaterialConsumptionRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<MaterialConsumptionModel>> getMaterialConsumptionList({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    Map<String, dynamic>? filter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllMaterialConsumption(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
        branchFilter: filter?['branchFilter'],
      ),
    );

    if (response.status == 200) {
      final items = (response.data['material_consumption_data'] as List)
          .map((x) => MaterialConsumptionModel.fromJson(x))
          .toList();
      return PaginationModel.fromJson(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load material consumptions');
  }

  Future<MaterialConsumptionModel> getMaterialConsumptionById(String id) async {
    final ResModel response = await _api.get(
      ApiConstants.getMaterialConsumptionById,
    );

    if (response.status == 200 && response.data != null) {
      return MaterialConsumptionModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    }

    throw Exception(
      response.message ?? 'Failed to load material consumption detail',
    );
  }
}
