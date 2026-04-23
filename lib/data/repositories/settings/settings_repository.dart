import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/settings_model.dart';

class SettingsRepository {
  final _api = ApiService.to;

  Future<SettingsModel> getAllSettings() async {
    final ResModel res = await _api.get(ApiConstants.getAllSetting());
    if (res.status == 200) {
      return SettingsModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Failed to fetch settings");
  }
}
