import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/role/role_model.dart';

class RoleRepository {
  final _api = ApiService.to;

  Future<PaginationModel<RoleModel>> getAllRoles({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllRole(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
      ),
    );
    if (res.status == 200) {
      final items = (res.data['role_data'] as List)
          .map((e) => RoleModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }
}
