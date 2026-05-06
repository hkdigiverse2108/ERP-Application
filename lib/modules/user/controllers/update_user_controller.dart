import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/inventory/location_repository.dart';
import 'package:ai_setu/data/repositories/user/role_repository.dart';
import 'package:ai_setu/data/repositories/user/user_repository.dart';
import 'package:ai_setu/modules/user/controllers/user_controller.dart';
import 'package:ai_setu/shared/widgets/media_picker/views/media_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserController extends GetxController {
  final _repo = UserRepository();
  final formKey = GlobalKey<FormState>();
  final _roleRepo = RoleRepository();
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
  final countryCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final userDescriptionController = TextEditingController();
  final roleName = ''.obs;
  final roleId = ''.obs;
  final panController = TextEditingController();
  final branchController = TextEditingController();

  /// Address
  final addressController = TextEditingController();
  final countryId = ''.obs;
  final stateId = ''.obs;
  final cityId = ''.obs;
  final zipCodeController = TextEditingController();

  final selectedCountry = ''.obs;
  final selectedState = ''.obs;
  final selectedCity = ''.obs;

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
  final roleList = <CommonDropdownModel>[].obs;

  /// Pick image using MediaPickerDialog
  Future<void> pickImageFromGallery() async {
    await MediaPickerDialog.show(
      onMediaSelected: (selected) {
        if (selected.isNotEmpty) {
          // We can't directly set XFile from a URL, but we can store the URL
          // I'll update the controller to handle both local XFile and network URL
          selectedImageUrl.value = selected.first.url;
          selectedImage.value = null; // Clear local image if any
        }
      },
    );
  }

  final RxString selectedImageUrl = "".obs;

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
    selectedImageUrl.value = "";
  }

  /// =========================
  /// INIT
  /// =========================
  @override
  void onInit() {
    super.onInit();
    ever(countryId, (id) => _loadState(id));
    ever(stateId, (id) => _loadCity(id));
    getRole();
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
    countryCodeController.text = user.phoneNo.countryCode;
    phoneController.text = user.phoneNo.phoneNo.toString();
    userDescriptionController.text = user.designation ?? '';
    roleName.value = user.role?.name ?? '';
    roleId.value = user.role?.id ?? '';
    panController.text = user.panNumber ?? '';
    branchController.text = user.branchId?.name ?? '';
    passwordController.text = user.showPassword ?? '';

    // Address
    addressController.text = user.address.address;
    selectedCountry.value = user.address.country;
    countryId.value = user.address.countryId;
    selectedState.value = user.address.state;
    stateId.value = user.address.stateId;
    selectedCity.value = user.address.city;
    cityId.value = user.address.cityId;
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
      Log.e("User Module Error", e);
    }
  }

  Future<void> getRole() async {
    try {
      final res = await _roleRepo.roleDropdown();
      roleList.assignAll(res);
    } catch (e) {
      Log.e("User Module Error", e);
    }
  }

  void onCountryChanged(String name) {
    selectedCountry.value = name;
    final country = countryList.firstWhere(
      (e) => e.name == name,
      orElse: () => LocationDropdown.empty(),
    );
    countryId.value = country.id;

    // Reset dependents
    selectedState.value = "";
    stateId.value = "";
    selectedCity.value = "";
    cityId.value = "";
    stateList.clear();
    cityList.clear();
  }

  void onRoleChanged(String name) {
    roleName.value = name;
    final role = roleList.firstWhere(
      (e) => e.name == name,
      orElse: () => CommonDropdownModel.empty(),
    );
    roleId.value = role.id;
  }

  void onStateChanged(String name) {
    selectedState.value = name;
    final state = stateList.firstWhere(
      (e) => e.name == name,
      orElse: () => LocationDropdown.empty(),
    );
    stateId.value = state.id;

    // Reset dependents
    selectedCity.value = "";
    cityId.value = "";
    cityList.clear();
  }

  void onCityChanged(String name) {
    selectedCity.value = name;
    final city = cityList.firstWhere(
      (e) => e.name == name,
      orElse: () => LocationDropdown.empty(),
    );
    cityId.value = city.id;
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
      Log.e("User Module Error", e);
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
      Log.e("User Module Error", e);
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
        "userId": user!.id,
        "fullName": fullNameController.text,
        "username": userNameController.text,
        "email": emailController.text,
        "phoneNo": {
          "countryCode": countryCodeController.text,
          "phoneNo": phoneController.text,
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
        "password": passwordController.text,
        "role": roleId.value,
        "profileImage": selectedImageUrl.value.isNotEmpty
            ? selectedImageUrl.value
            : (selectedImage.value?.path ?? user!.profileImage),
      };

      final ResModel res = await _repo.updateUser(userData);

      if (res.status == 200) {
        AppSnackbar.success("User updated successfully");
        await _refreshAndBack();
      } else {
        AppSnackbar.error(res.message ?? "Failed to update user");
      }
    } catch (e) {
      Log.e("User Module Error", e);
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
    countryCodeController.clear();
    phoneController.clear();
    passwordController.clear();
    userDescriptionController.clear();
    roleName.value = '';
    roleId.value = '';
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
    selectedImageUrl.value = "";
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
    countryCodeController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    userDescriptionController.dispose();
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

  Future<void> _refreshAndBack() async {
    final userController = Get.isRegistered<UserController>()
        ? Get.find<UserController>()
        : null;

    if (userController != null) {
      await userController.refreshData();
    }
    Get.back();
  }
}
