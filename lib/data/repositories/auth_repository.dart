import 'dart:developer';

import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/data/model/auth/login_response_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:get/get.dart';

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

  Future<ResModel> forgotPassword(String email) async {
    final ResModel res = await _api.post(
      ApiConstants.forgotPassword,
      body: {"email": email},
    );

    if (res.status == 200) {
      return res;
    }

    throw Exception(res.message ?? 'Failed to send OTP');
  }

  Future<ResModel> verifyOtp(String email, String otp) async {
    final ResModel res = await _api.post(
      ApiConstants.verifyOtp,
      body: {"email": email, "otp": otp},
    );

    if (res.status == 200) {
      return res;
    }

    throw Exception(res.message ?? 'Invalid OTP');
  }

  Future<ResModel> resendOtp(String email) async {
    final ResModel res = await _api.post(
      ApiConstants.resendOtp,
      body: {"email": email},
    );

    if (res.status == 200) {
      return res;
    }

    throw Exception(res.message ?? 'Failed to resend OTP');
  }

  Future<ResModel> updatePassword(
    String email,
    String newPassword,
    String confirmPassword,
  ) async {
    final ResModel res = await _api.post(
      ApiConstants.updatePassword,
      body: {
        "email": email,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );

    if (res.status == 200) {
      return res;
    }

    throw Exception(res.message ?? 'Failed to update password');
  }

  Future<void> logout() async {
    try {
      await _api.storageService.clearSession();
      PermissionService.to.clearPermissions();
      Get.offAllNamed(Routes.signIn);
    } catch (e) {
      log(e.toString());
      throw Exception('Logout failed');
    }
  }
}


