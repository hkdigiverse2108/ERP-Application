import 'dart:developer';

import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/data/repositories/auth/auth_repository.dart';
import 'package:ai_setu/data/repositories/settings/company_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  // Services
  final StorageService storageService = StorageService.instance;
  final ApiService apiService = ApiService.to;
  final _repo = AuthRepository();
  final _companyRepo = CompanyRepository();

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
        result.user.toMap(),
      );

      // Determine and save isMainBranch status
      final isHeadBranch = result.user.branchId != null && result.user.branchId?.isHeadBranch == true;
      await StorageService.instance.write(StorageKeys.isMainBranch, isHeadBranch);

      // Fetch permissions
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
          company.toMap(),
        );
        // Also keep financialYear for legacy/convenience if needed,
        // though we'll primarily use companyInfo now.
        await StorageService.instance.write(
          StorageKeys.financialYear,
          company.financialYear,
        );
        // Regenerate and load years in the controller
        FinancialYearController.to.init();
      } catch (e) {
        log("Failed to fetch company details: $e");
        // Non-blocking for login, but log it
      }

      Get.offAllNamed(PermissionService.to.defaultRoute);
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
    // Note: Manual disposal of TextEditingControllers removed to avoid
    // "used after disposed" crashes during GetX route transitions.
    super.onClose();
  }
}

