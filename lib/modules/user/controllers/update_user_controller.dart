import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/location_repository.dart';
import 'package:ai_setu/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserController extends GetxController {
  final _repo = UserRepository();
  final formKey = GlobalKey<FormState>();
  UserModel? user;

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoaded = false.obs;
  final RxBool isUpdating = false.obs;

  final currentPage = 1.obs;

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  final _locationRepo = LocationRepository();

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
  final countryId = ''.obs;
  final stateId = ''.obs;
  final cityId = ''.obs;
  final zipCodeController = TextEditingController();

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

  // dropdown
  final countryList = <LocationDropdown>[].obs;
  final stateList = <LocationDropdown>[].obs;
  final cityList = <LocationDropdown>[].obs;

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
    ever(countryId, (id) => _loadState(id));
    ever(stateId, (id) => _loadCity(id));
    getCountry();

    // Check for user data in arguments
    if (Get.arguments is UserModel) {
      user = Get.arguments as UserModel;
      populateFields(user!);
    }

    /// Delay heavy UI build
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoaded.value = true;
    });
  }

  /// =========================
  /// POPULATE FIELDS
  /// =========================
  void populateFields(UserModel user) {
    fullNameController.text = user.fullName;
    userNameController.text = user.username;
    emailController.text = user.email;
    phoneController.text = user.phoneNo.phoneNo.toString();
    userDescriptionController.text = user.designation ?? '';
    roleController.text = user.role?.name ?? '';
    panController.text = user.panNumber ?? '';
    branchController.text = user.branchId?.name ?? '';
    passwordController.text = user.showPassword ?? '';

    // Address
    addressController.text = user.address.address;
    cityId.value = user.address.city;
    stateId.value = user.address.state;
    countryId.value = user.address.country;
    zipCodeController.text = user.address.pinCode.toString();

    // Bank
    bankNameController.text = user.bankDetails?.name ?? '';
    accountNumberController.text = user.bankDetails?.accountNumber ?? '';
    ifscCodeController.text = user.bankDetails?.ifscCode ?? '';
    bankBranchController.text = user.bankDetails?.branchName ?? '';

    // Salary
    wagesController.text = user.wages?.toString() ?? '';
    commissionController.text = user.commission?.toString() ?? '';
    extraWagesController.text = user.extraWages?.toString() ?? '';
    targetController.text = user.target?.toString() ?? '';
  }

  Future<void> getCountry() async {
    try {
      final res = await _locationRepo.countryDropdown();
      countryList.assignAll(res);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _loadState(String id) async {
    if (id.isEmpty) {
      stateList.clear();
      return;
    }
    try {
      final res = await _locationRepo.stateDropdown(id);
      stateList.assignAll(res);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _loadCity(String id) async {
    if (id.isEmpty) {
      cityList.clear();
      return;
    }
    try {
      final res = await _locationRepo.cityDropdown(id);
      cityList.assignAll(res);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// =========================
  /// UPDATE USER
  /// =========================
  Future<void> updateUser() async {
    if (user == null) return;
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isUpdating.value = true;

      final userData = {
        "_id": user!.id,
        "fullName": fullNameController.text,
        "username": userNameController.text,
        "email": emailController.text,
        "phoneNo": {
          "countryCode": user!.phoneNo.countryCode,
          "phoneNo": int.tryParse(phoneController.text) ?? 0,
        },
        "designation": userDescriptionController.text,
        "panNumber": panController.text,
        "address": {
          "address": addressController.text,
          "city": cityId.value,
          "state": stateId.value,
          "pinCode": int.tryParse(zipCodeController.text) ?? 0,
          "country": countryId.value,
        },
        "bankDetails": {
          "name": bankNameController.text,
          "accountNumber": accountNumberController.text,
          "IFSCCode": ifscCodeController.text,
          "branchName": bankBranchController.text,
          "bankHolderName": user!.bankDetails?.bankHolderName ?? '',
          "swiftCode": user!.bankDetails?.swiftCode ?? '',
        },
        "wages": int.tryParse(wagesController.text),
        "commission": int.tryParse(commissionController.text),
        "extraWages": int.tryParse(extraWagesController.text),
        "target": int.tryParse(targetController.text),
        "showPassword": passwordController.text,
      };

      final res = await _repo.updateUser(userData);

      if (res.status == 200) {
        Get.back();
        Get.snackbar(
          "Success",
          "User updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          res.message ?? "Failed to update user",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
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
    cityId.value = '';
    stateId.value = '';
    countryId.value = '';
    zipCodeController.clear();

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
    zipCodeController.dispose();

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
