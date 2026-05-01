import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/permission_model.dart';

class PermissionRepository {
  final _api = ApiService.to;

  Future<List<PermissionModel>> getPermissionTabs(String userId) async {
    final response = await _api.get(ApiConstants.getPermitionTabs(userId));
    if (response.data != null && response.data is List) {
      return List<PermissionModel>.from(
        (response.data as List).map((x) => PermissionModel.fromJson(x)),
      );
    }
    return [];
  }
}
