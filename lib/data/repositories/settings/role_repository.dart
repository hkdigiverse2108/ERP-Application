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

  Future<ResModel> createRole(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(ApiConstants.addRole, body: data);
    if (response.status == 201) {
      return response;
    }
    throw Exception(response.message ?? "Failed to create role");
  }

  Future<ResModel> updateRole(Map<String, dynamic> data) async {
    final ResModel response = await _api.put(
      ApiConstants.updateRole,
      body: data,
    );
    if (response.status == 200) {
      return response;
    }
    throw Exception(response.message ?? "Failed to update role");
  }

  Future<RoleModel> getRoleById(String id) async {
    final ResModel response = await _api.get(ApiConstants.getRoleById(id));
    if (response.status == 200) {
      return RoleModel.fromMap(response.data);
    }
    throw Exception(response.message ?? "Failed to load role");
  }

  Future<ResModel> deleteRole(String id) async {
    final ResModel response = await _api.delete(ApiConstants.deleteRole(id));
    if (response.status == 200) {
      return response;
    }
    throw Exception(response.message ?? "Failed to delete role");
  }
}
