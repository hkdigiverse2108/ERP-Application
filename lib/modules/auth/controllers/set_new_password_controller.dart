import 'dart:developer';

import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/auth/auth_repository.dart';
import 'package:ai_setu/data/repositories/settings/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNewPasswordController extends GetxController {
  static SetNewPasswordController get instance => Get.find();

  final _repo = AuthRepository();
  final _companyRepo = CompanyRepository();

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final showNewPassword = false.obs;
  final showConfirmPassword = false.obs;

  void toggleShowNewPassword() => showNewPassword.toggle();
  void toggleShowConfirmPassword() => showConfirmPassword.toggle();

  Future<void> saveAndLogin() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final email = Get.arguments as String?;
    if (email == null) {
      AppSnackbar.error("Email not found. Please try again.");
      return;
    }

    try {
      isLoading.value = true;

      // First update the password
      await _repo.updatePassword(
        email.trim(),
        newPasswordController.text.trim(),
        confirmPasswordController.text.trim(),
      );

      AppSnackbar.success("Password updated successfully. Logging in...");

      // Then attempt login
      final result = await _repo.login(
        email.trim(),
        newPasswordController.text.trim(),
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

      // Determine and save isMainBranch status
      final isHeadBranch = result.user.branchId != null && result.user.branchId?.isHeadBranch == true;
      await StorageService.instance.write(StorageKeys.isMainBranch, isHeadBranch);

      await PermissionService.to.fetchPermissions(result.user.id);

      // Load branch data
      if (Get.isRegistered<BranchController>()) {
        await BranchController.to.onUserLogin();
      }

      // Fetch Company Details for Financial Year
      try {
        final company = await _companyRepo.getCompanyById(
          result.user.companyId.id,
        );
        await StorageService.instance.write(
          StorageKeys.companyInfo,
          company.toJson(),
        );
        await StorageService.instance.write(
          StorageKeys.financialYear,
          company.financialYear,
        );
        FinancialYearController.to.init();
      } catch (e) {
        log("Failed to fetch company details: $e");
      }

      Get.offAllNamed(PermissionService.to.defaultRoute);
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

