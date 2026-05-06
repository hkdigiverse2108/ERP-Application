import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/crm/loyalty_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class LoyaltyRepository {
  final _api = ApiService.to;

  Future<PaginationModel<LoyaltyModel>> getAllLoyalty({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllLoyalty(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['loyalty_data'] as List)
          .map((e) => LoyaltyModel.fromJson(e))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<LoyaltyModel> getLoyaltyById(String id) async {
    final res = await _api.get("/loyalty/$id");
    if (res.status == 200 && res.data != null) {
      return LoyaltyModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<void> addLoyalty(Map<String, dynamic> data) async {
    final res = await _api.post(ApiConstants.loyaltyAdd, body: data);
    if (res.status != 200) {
      throw Exception(res.message ?? "Something went wrong");
    }
  }

  Future<void> updateLoyalty(Map<String, dynamic> data) async {
    final res = await _api.put(ApiConstants.loyaltyEdit, body: data);
    if (res.status != 200) {
      throw Exception(res.message ?? "Something went wrong");
    }
  }

  Future<ResModel> deleteLoyalty(String id) async {
    return await _api.delete(ApiConstants.loyaltyDelete(id));
  }
}
