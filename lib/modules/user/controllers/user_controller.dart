import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final userDescriptionController = TextEditingController();
  final roleController = TextEditingController();
  final panController = TextEditingController();
  final branchController = TextEditingController();
  // Address Details
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  // Bank Details
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final bankBranchController = TextEditingController();
  // Salary Details
  final wagesController = TextEditingController();
  final commissionController = TextEditingController();
  final extraWagesController = TextEditingController();
  final targetController = TextEditingController();

  @override
  void onClose() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    userDescriptionController.dispose();
    roleController.dispose();
    panController.dispose();
    branchController.dispose();

    // Address Details
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    super.onClose();
    //Bank Detaila
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscCodeController.dispose();
    bankBranchController.dispose();
    // Salary Details
    wagesController.dispose();
    commissionController.dispose();
    extraWagesController.dispose();
    targetController.dispose();
  }

  // Image Picker
  final ImagePicker _picker = ImagePicker();
}
