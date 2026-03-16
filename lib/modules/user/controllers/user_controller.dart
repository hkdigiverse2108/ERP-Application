import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoaded = false.obs;

  final currentPage = 1.obs;

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  /// Personal Info
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final userDescriptionController = TextEditingController();
  final roleController = TextEditingController();
  final panController = TextEditingController();
  final branchController = TextEditingController();

  /// Address
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();

  /// Bank Details
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final bankBranchController = TextEditingController();

  /// Salary Details
  final wagesController = TextEditingController();
  final commissionController = TextEditingController();
  final extraWagesController = TextEditingController();
  final targetController = TextEditingController();

  /// =========================
  /// IMAGE PICKER
  /// =========================

  final ImagePicker _picker = ImagePicker();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = image;
    }
  }

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = image;
    }
  }

  /// Remove image
  void removeImage() {
    selectedImage.value = null;
  }

  /// =========================
  /// INIT
  /// =========================
  @override
  void onInit() {
    super.onInit();

    /// Delay heavy UI build
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoaded.value = true;
    });
  }

  /// =========================
  /// PASSWORD VISIBILITY
  /// =========================
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// =========================
  /// CLEAR FORM
  /// =========================
  void clearForm() {
    /// Personal
    fullNameController.clear();
    userNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    userDescriptionController.clear();
    roleController.clear();
    panController.clear();
    branchController.clear();

    /// Address
    addressController.clear();
    cityController.clear();
    stateController.clear();
    zipCodeController.clear();
    countryController.clear();

    /// Bank
    bankNameController.clear();
    accountNumberController.clear();
    ifscCodeController.clear();
    bankBranchController.clear();

    /// Salary
    wagesController.clear();
    commissionController.clear();
    extraWagesController.clear();
    targetController.clear();

    /// Image
    selectedImage.value = null;
  }

  /// =========================
  /// DISPOSE CONTROLLERS
  /// =========================
  @override
  void onClose() {
    /// Personal
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    userDescriptionController.dispose();
    roleController.dispose();
    panController.dispose();
    branchController.dispose();

    /// Address
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();

    /// Bank
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscCodeController.dispose();
    bankBranchController.dispose();

    /// Salary
    wagesController.dispose();
    commissionController.dispose();
    extraWagesController.dispose();
    targetController.dispose();

    super.onClose();
  }
}
