import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/consumption_type/consumption_type_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class ConsumptionTypeRepository {
  final _api = ApiService.to;

  Future<PaginationModel<ConsumptionTypeModel>> getConsumptionTypes({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllConsumptionType(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
      ),
    );
    if (res.status == 200) {
      final items = (res.data['consumptionType_data'] as List)
          .map((e) => ConsumptionTypeModel.fromJson(e))
          .toList();

      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ConsumptionTypeModel> getConsumptionTypeById(String id) async {
    final ResModel res = await _api.get(
      ApiConstants.getConsumptionTypeById(id),
    );
    if (res.status == 200) {
      return ConsumptionTypeModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> createConsumptionType(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(
      ApiConstants.addConsumptionType,
      body: data,
    );
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> updateConsumptionType(Map<String, dynamic> data) async {
    final ResModel res = await _api.put(
      ApiConstants.updateConsumptionType,
      body: data,
    );
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> deleteConsumptionType(String id) async {
    final ResModel res = await _api.delete(
      ApiConstants.deleteConsumptionType(id),
    );
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Something went wrong");
  }
}
