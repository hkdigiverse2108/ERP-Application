import 'dart:developer';

import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  static VerificationController get instance => Get.find();

  final _repo = AuthRepository();
  final otpController = TextEditingController();
  final otpKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  Future<void> verifyOtp() async {
    if (!(otpKey.currentState?.validate() ?? false)) return;

    final email = Get.arguments as String?;
    if (email == null) {
      AppSnackbar.error("Email not found. Please try again.");
      return;
    }

    try {
      isLoading.value = true;
      await _repo.verifyOtp(email, otpController.text.trim());

      AppSnackbar.success("OTP Verified successfully");
      Get.toNamed(Routes.setNewPassword, arguments: email);
    } catch (e) {
      log(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    final email = Get.arguments as String?;
    if (email == null) return;

    try {
      await _repo.resendOtp(email);
      AppSnackbar.success("OTP resent successfully to $email");
    } catch (e) {
      log(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  void onClose() {
    // Manual disposal removed to avoid race condition during navigation.
    super.onClose();
  }
}
