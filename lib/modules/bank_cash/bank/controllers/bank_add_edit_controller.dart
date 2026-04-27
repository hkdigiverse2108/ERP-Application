import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/data/repositories/bank_repository.dart';
import 'package:ai_setu/data/repositories/branch_repository.dart';
import 'package:ai_setu/data/repositories/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAddEditController extends GetxController {
  final BankRepository _bankRepo = BankRepository();
  final BranchRepository _branchRepo = BranchRepository();
  final _locationRepo = LocationRepository();

  final formKey = GlobalKey<FormState>();
  BankModel? bank;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  // Form Controllers
  final nameController = TextEditingController();
  final ifscController = TextEditingController();
  final branchNameController = TextEditingController();
  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final swiftCodeController = TextEditingController();
  final upiIdController = TextEditingController();
  final creditBalanceController = TextEditingController(text: "0");
  final debitBalanceController = TextEditingController(text: "0");
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final zipCodeController = TextEditingController();

  // Address Selection
  final selectedCountry = ''.obs;
  final selectedState = ''.obs;
  final selectedCity = ''.obs;
  final countryId = ''.obs;
  final stateId = ''.obs;
  final cityId = ''.obs;

  final countryList = <LocationDropdown>[].obs;
  final stateList = <LocationDropdown>[].obs;
  final cityList = <LocationDropdown>[].obs;

  // Branch Selection
  final branchIds = <IdNameModel>[].obs;
  final branches = <IdNameModel>[].obs;
  final branchInputController = TextEditingController();

  final isActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();

    ever(countryId, (id) => _loadStates(id));
    ever(stateId, (id) => _loadCities(id));
  }

  Future<void> _initData() async {
    isLoading.value = true;
    try {
      await _loadDropdownData();
      await getCountries();

      if (Get.arguments is BankModel) {
        bank = Get.arguments as BankModel;
        isEdit.value = true;
        await _populateFields(bank!);
      } else if (Get.arguments is String &&
          (Get.arguments as String).isNotEmpty) {
        isEdit.value = true;
        bank = await _bankRepo.getBankById(Get.arguments as String);
        await _populateFields(bank!);
      } else {
        isEdit.value = false;
      }
    } catch (e) {
      Log.e("Bank Module Init Error", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadDropdownData() async {
    try {
      final res = await _branchRepo.getBranchesDropdown();
      branches.assignAll(
        res.map((e) => IdNameModel(id: e.id, name: e.name)).toList(),
      );
    } catch (e) {
      Log.e("Bank Module Error (BankAddEdit) - Branch data", e);
    }
  }

  Future<void> getCountries() async {
    try {
      final res = await _locationRepo.countryDropdown();
      countryList.assignAll(res);
    } catch (e) {
      Log.e("Bank Module Error - Country dropdown", e);
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

  Future<void> _loadStates(String id) async {
    if (id.isEmpty) {
      stateList.clear();
      return;
    }
    try {
      final res = await _locationRepo.stateDropdown(id);
      stateList.assignAll(res);
    } catch (e) {
      Log.e("Bank Module Error - State dropdown", e);
    }
  }

  Future<void> _loadCities(String id) async {
    if (id.isEmpty) {
      cityList.clear();
      return;
    }
    try {
      final res = await _locationRepo.cityDropdown(id);
      cityList.assignAll(res);
    } catch (e) {
      Log.e("Bank Module Error - City dropdown", e);
    }
  }

  Future<void> _populateFields(BankModel b) async {
    nameController.text = b.name;
    ifscController.text = b.ifscCode;
    branchNameController.text = b.branchName;
    accountHolderController.text = b.accountHolderName;
    accountNumberController.text = b.bankAccountNumber;
    swiftCodeController.text = b.swiftCode;
    upiIdController.text = b.upiId;
    creditBalanceController.text = b.openingBalance.creditBalance;
    debitBalanceController.text = b.openingBalance.debitBalance;
    addressLine1Controller.text = b.addressLine1;
    addressLine2Controller.text = b.addressLine2;
    zipCodeController.text = b.zipCode;

    // Handle Address Auto-fill
    // 1. Country
    if (b.country.isNotEmpty) {
      final country = countryList.firstWhere(
        (e) => e.id == b.country || e.name == b.country,
        orElse: () => LocationDropdown.empty(),
      );
      if (country.id.isNotEmpty) {
        countryId.value = country.id;
        selectedCountry.value = country.name;

        // Load States
        await _loadStates(country.id);

        // 2. State
        if (b.state.isNotEmpty) {
          final state = stateList.firstWhere(
            (e) => e.id == b.state || e.name == b.state,
            orElse: () => LocationDropdown.empty(),
          );
          if (state.id.isNotEmpty) {
            stateId.value = state.id;
            selectedState.value = state.name;

            // Load Cities
            await _loadCities(state.id);

            // 3. City
            if (b.city.isNotEmpty) {
              final city = cityList.firstWhere(
                (e) => e.id == b.city || e.name == b.city,
                orElse: () => LocationDropdown.empty(),
              );
              if (city.id.isNotEmpty) {
                cityId.value = city.id;
                selectedCity.value = city.name;
              }
            }
          }
        }
      }
    }

    branchIds.assignAll(b.branchIds);
    isActive.value = b.isActive;
  }

  Future<void> saveBank() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isSaving.value = true;
      final Map<String, dynamic> data = {
        "name": nameController.text,
        "ifscCode": ifscController.text,
        "branchName": branchNameController.text,
        "accountHolderName": accountHolderController.text,
        "bankAccountNumber": accountNumberController.text,
        "swiftCode": swiftCodeController.text,
        "upiId": upiIdController.text,
        "openingBalance": {
          "creditBalance": creditBalanceController.text,
          "debitBalance": debitBalanceController.text,
        },
        "address": {
          "addressLine1": addressLine1Controller.text,
          "addressLine2": addressLine2Controller.text,
          "country": countryId.value.isEmpty
              ? selectedCountry.value
              : countryId.value,
          "state": stateId.value.isEmpty ? selectedState.value : stateId.value,
          "city": cityId.value.isEmpty ? selectedCity.value : cityId.value,
          "pinCode": int.tryParse(zipCodeController.text) ?? 0,
        },
        "branchIds": branchIds.map((e) => e.id).toList(),
        "isActive": isActive.value,
        // "type": "bank",
      };

      if (isEdit.value && bank != null) {
        data["bankId"] = bank!.id;
        final res = await _bankRepo.updateBank(data);
        if (res) {
          Get.back(result: true);
          AppSnackbar.success("Bank updated successfully");
        } else {
          AppSnackbar.error("Failed to update bank");
        }
      } else {
        final res = await _bankRepo.addBank(data);
        if (res) {
          AppSnackbar.success("Bank added successfully");
          Get.back(result: true);
        } else {
          AppSnackbar.error("Failed to add bank");
        }
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    ifscController.dispose();
    branchNameController.dispose();
    accountHolderController.dispose();
    accountNumberController.dispose();
    swiftCodeController.dispose();
    upiIdController.dispose();
    creditBalanceController.dispose();
    debitBalanceController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    zipCodeController.dispose();
    branchInputController.dispose();
    super.onClose();
  }
}
