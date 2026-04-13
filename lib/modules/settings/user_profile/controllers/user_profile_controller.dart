import 'dart:developer';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  static UserProfileController get instance => Get.find();

  final _userRepo = UserRepository();
  final _storageService = StorageService.instance;

  final user = Rxn<UserModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      // Try to get ID from stored user data first
      final userData = _storageService.read<Map<String, dynamic>>(
        StorageKeys.userData,
      );
      final userId = userData?['_id'] ?? userData?['id'];

      if (userId == null) {
        throw Exception("User ID not found in storage");
      }

      final profile = await _userRepo.getUserById(userId);
      user.value = profile;
    } catch (e) {
      log("Error fetching profile: $e");
      AppSnackbar.error("Failed to load profile details");
    } finally {
      isLoading.value = false;
    }
  }

  double get completionPercentage {
    if (user.value == null) return 0;

    final u = user.value!;
    int totalFields = 15;
    int completedFields = 0;

    // Basic
    if (u.fullName.isNotEmpty) completedFields++;
    if (u.email.isNotEmpty) completedFields++;
    if (u.phoneNo.phoneNo > 0) completedFields++;
    if (u.designation != null && u.designation!.isNotEmpty) completedFields++;
    if (u.panNumber != null && u.panNumber!.isNotEmpty) completedFields++;
    if (u.role != null) completedFields++;

    // Address
    if (u.address.address.isNotEmpty) completedFields++;
    if (u.address.city.isNotEmpty) completedFields++;
    if (u.address.state.isNotEmpty) completedFields++;

    // Bank
    if (u.bankDetails != null) {
      if (u.bankDetails!.name.isNotEmpty) completedFields++;
      if (u.bankDetails!.accountNumber.isNotEmpty) completedFields++;
      if (u.bankDetails!.ifscCode.isNotEmpty) completedFields++;
    }

    // Salary/Extra
    if (u.wages != null) completedFields++;
    if (u.commission != null) completedFields++;
    if (u.profileImage != null && u.profileImage!.isNotEmpty) completedFields++;

    return (completedFields / totalFields) * 100;
  }

  void goToEdit() {
    if (user.value != null) {
      Get.toNamed(Routes.editUser, arguments: user.value);
    }
  }
}
