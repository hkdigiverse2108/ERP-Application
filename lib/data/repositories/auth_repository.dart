import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/auth/login_response_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class AuthRepository {
  final ApiService _api = ApiService.to;

  Future<LoginResponseModel> login(String email, String password) async {
    final ResModel res = await _api.post(
      ApiConstants.login,
      body: {
        "email": email,
        "password": password,
        "loginSource": "admin-panel",
      },
    );

    if (res.status == 200 && res.data != null) {
      return LoginResponseModel.fromJson(res.data);
    }

    throw Exception(res.message ?? 'Login failed');
  }
}
