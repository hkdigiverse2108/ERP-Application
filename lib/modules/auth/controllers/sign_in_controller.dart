import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/res_model/res_model.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  // Services
  final StorageService storageService = StorageService.instance;
  final ApiService apiService = ApiService.to;

  // Form
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // UI State
  final showPassword = false.obs;
  final isLoading = false.obs;

  // ================= LOGIN =================
  Future<void> login() async {
    try {
      isLoading.value = true;

      if (!(loginFormKey.currentState?.validate() ?? false)) {
        return;
      }

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final ResModel response = await apiService.postRequest(
        ApiConstants.login,
        {"email": email, "password": password},
        isAuth: false,
      );

      log("Login Response: ${response.toJson()}");
      log("Token: ${response.data['token']}");
      if (response.status == 200) {
        final data = response.data;

        if (data != null && data is Map<String, dynamic>) {
          final token = data['token'];

          if (token != null) {
            await storageService.write(StorageKeys.accessToken, token);
            Get.offAllNamed(Routes.home);
          } else {
            _showError("Token not found");
          }
        } else {
          _showError("Invalid response data");
        }
      } else {
        _showError(response.message ?? "Login failed");
      }
    } catch (e) {
      log("Login Failed: $e");
      _showError("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= UI HELPERS =================

  void togglePassword() {
    showPassword.toggle();
  }

  void _showError(String message) {
    Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
  }

  // ================= CLEANUP =================
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
