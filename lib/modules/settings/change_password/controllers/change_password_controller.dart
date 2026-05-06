import 'dart:developer';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final _repo = AuthRepository();
  final isLoading = false.obs;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final showOldPassword = false.obs;
  final showNewPassword = false.obs;
  final showConfirmPassword = false.obs;

  void toggleOldPassword() => showOldPassword.toggle();
  void toggleNewPassword() => showNewPassword.toggle();
  void toggleConfirmPassword() => showConfirmPassword.toggle();

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final userDataMap = StorageService.instance.read<Map<String, dynamic>>(
        StorageKeys.userData,
      );
      if (userDataMap == null) {
        AppSnackbar.error('User data not found. Please login again.');
        return;
      }

      final user = UserModel.fromMap(userDataMap);

      await _repo.changePassword(
        email: user.email,
        loginSource: 'admin-panel',
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      AppSnackbar.success('Password changed successfully');
      Get.back();
    } catch (e) {
      log(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
