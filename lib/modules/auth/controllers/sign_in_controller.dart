import 'dart:developer';

import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/repositories/auth_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  // Services
  final StorageService storageService = StorageService.instance;
  final ApiService apiService = ApiService.to;
  final _repo = AuthRepository();

  final isLoading = false.obs;
  final showPassword = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    try {
      isLoading.value = true;
      final result = await _repo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await StorageService.instance.write(
        StorageKeys.accessToken,
        result.user.token,
      );
      await StorageService.instance.write(StorageKeys.isLoggedIn, true);
      await StorageService.instance.write(
        StorageKeys.userData,
        result.user.toJson(),
      );
      Get.offAllNamed(Routes.home);
    } catch (e) {
      log(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void toggleShowPass() {
    showPassword.toggle();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
