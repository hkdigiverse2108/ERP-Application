import 'dart:developer';

import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final _repo = AuthRepository();
  final RxBool isLoading = false.obs;
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  Future<void> forgotPassword() async {
    if (!forgetPasswordFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final email = emailController.text.trim();
      await _repo.forgotPassword(email);

      AppSnackbar.success("Verification code sent to $email");
      Get.toNamed(Routes.verification, arguments: email);
    } catch (e) {
      log(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Manual disposal removed to avoid race condition during navigation.
    super.onClose();
  }
}

