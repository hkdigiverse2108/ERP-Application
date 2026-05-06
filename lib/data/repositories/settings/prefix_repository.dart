import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/prefix/prefix_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PrefixRepository {
  final _api = ApiService.to;

  Future<PaginationModel<PrefixModel>> getAllPrefixes({
    int? page,
    int? limit,
    String? search,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllPrefix(page: page, limit: limit, search: search),
    );
    if (res.status == 200) {
      final items = (res.data['prefix_data'] as List)
          .map((e) => PrefixModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<PrefixModel> getPrefixById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getPrefixById(id));
    if (res.status == 200) {
      return PrefixModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> createPrefix(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(ApiConstants.addPrefix, body: data);
    if (res.status == 201) {
      return res;
    }
    throw Exception(res.message ?? "Failed to create prefix");
  }

  Future<ResModel> updatePrefix(Map<String, dynamic> data) async {
    final ResModel res = await _api.put(ApiConstants.updatePrefix, body: data);
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Failed to update prefix");
  }

  Future<ResModel> deletePrefix(String id) async {
    final ResModel res = await _api.delete(ApiConstants.deletePrefix(id));
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Failed to delete prefix");
  }
}
