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
        branchId: filter?['branchFilter'],
        startDate: filter?['startDate'],
        endDate: filter?['endDate'],
      ),
    );

    if (response.status == 200) {
      final items = (response.data['material_consumption_data'] as List)
          .map(
            (x) => MaterialConsumptionModel.fromMap(x as Map<String, dynamic>),
          )
          .toList();
      return PaginationModel.fromMap(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load material consumptions');
  }

  Future<MaterialConsumptionModel> getMaterialConsumptionById(String id) async {
    final ResModel response = await _api.get(
      "${ApiConstants.getMaterialConsumptionById}?id=$id",
    );

    if (response.status == 200 && response.data != null) {
      return MaterialConsumptionModel.fromMap(
        response.data as Map<String, dynamic>,
      );
    }

    throw Exception(
      response.message ?? 'Failed to load material consumption detail',
    );
  }

  Future<bool> addMaterialConsumption(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(
      ApiConstants.addMaterialConsumption,
      body: data,
    );
    return response.status == 200 || response.status == 201;
  }

  Future<bool> updateMaterialConsumption(Map<String, dynamic> data) async {
    final ResModel response = await _api.put(
      ApiConstants.updateMaterialConsumption,
      body: data,
    );
    return response.status == 200;
  }

  Future<bool> deleteMaterialConsumption({required String id}) async {
    final ResModel response = await _api.delete(
      ApiConstants.deleteMaterialConsumption(id: id),
    );
    return response.status == 200;
  }
}
