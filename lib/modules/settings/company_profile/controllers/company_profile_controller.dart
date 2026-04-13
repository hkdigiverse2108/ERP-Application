import 'dart:developer';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/company_model.dart';
import 'package:ai_setu/data/repositories/settings/company_repository.dart';
import 'package:get/get.dart';

class CompanyProfileController extends GetxController {
  static CompanyProfileController get instance => Get.find();

  final _companyRepo = CompanyRepository();
  final _storage = StorageService.instance;

  final company = Rxn<CompanyModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanyProfile();
  }

  Future<void> fetchCompanyProfile() async {
    try {
      isLoading.value = true;

      final userData = _storage.read<Map<String, dynamic>>(
        StorageKeys.userData,
      );
      final dynamic companyData = userData?['companyId'];
      String? companyId;

      if (companyData is Map) {
        companyId = companyData['_id']?.toString();
      } else {
        companyId = companyData?.toString();
      }

      if (companyId == null) {
        throw Exception("Company ID not found in storage");
      }

      final profile = await _companyRepo.getCompanyById(companyId);
      company.value = profile;
    } catch (e) {
      log("Error fetching company profile: $e");
      AppSnackbar.error("Failed to load company details");
    } finally {
      isLoading.value = false;
    }
  }

  void goToEdit() {
    // Placeholder as requested
    AppSnackbar.info("Company edit functionality coming soon!");
  }
}
