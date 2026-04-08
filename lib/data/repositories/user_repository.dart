import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/user_model.dart';

class UserRepository {
  final _api = ApiService.to;

  Future<PaginationModel<UserModel>> getAllUser({
    String? typeFilter,
    int? page,
    int? limit,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllUser(
        typeFilter: typeFilter,
        page: page,
        limit: limit,
        search: search,
      ),
    );
    if (res.status == 200) {
      final items = (res.data['user_data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();

      return PaginationModel.fromJson(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }
}
