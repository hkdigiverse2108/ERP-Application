import 'dart:isolate';

import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PermissionRepository {
  final _api = ApiService.to;

  Future<List<PermissionModel>> getPermissionTabs(String userId) async {
    final ResModel response = await _api.get(
      ApiConstants.getPermitionTabs(userId),
    );
    if (response.data != null && response.data is List) {
      return await Isolate.run(() {
        return (response.data as List)
            .map((e) => PermissionModel.fromJson(e))
            .toList();
      });
    }
    return [];
  }

  Future<List<PermissionModel>> getPermissionsByUserId(String userId) async {
    final ResModel response = await _api.get(
      ApiConstants.getPermitionById(userId),
    );
    if (response.data != null && response.data is List) {
      return await Isolate.run(() {
        return (response.data as List)
            .map((e) => PermissionModel.fromJson(e))
            .toList();
      });
    }
    return [];
  }

  Future<void> updatePermissions(
    String userId,
    List<PermissionModel> permissions,
  ) async {
    final data = {
      "userId": userId,
      "modules": permissions
          .map(
            (e) => {
              "_id": e.id,
              "view": e.view,
              "add": e.add,
              "edit": e.edit,
              "delete": e.delete,
            },
          )
          .toList(),
    };
    await _api.put(ApiConstants.updatePermition, body: data);
  }
}
