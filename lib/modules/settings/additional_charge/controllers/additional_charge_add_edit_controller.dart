import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/modules/settings/additional_charge/controllers/additional_charge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalChargeAddEditController extends GetxController {
  final _repo = AdditionalChargeRepository();
  final _taxRepo = TaxRepository();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final defaultValueController = TextEditingController();
  final hsnSacController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isActive = true.obs;
  final isTaxIncluding = false.obs;

  // Dropdown states
  final types = ["Purchase", "Sales"].obs;
  final selectedType = "Sales".obs;

  final taxes = <TaxDropdownModel>[].obs;
  final selectedTaxId = RxnString();

  late String? chargeId;
  late bool isEdit;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    chargeId = args?['chargeId'];
    isEdit = args?['isEdit'] ?? false;

    _loadDropdownData();
  }

  @override
  void onClose() {
    nameController.dispose();
    defaultValueController.dispose();
    hsnSacController.dispose();
    super.onClose();
  }

  Future<void> _loadDropdownData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([_taxRepo.getTaxes()]);

      taxes.value = results[0];

      if (isEdit && chargeId != null) {
        await _fetchChargeById();
      }
    } catch (e) {
      Log.e("Error loading dropdown data", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchChargeById() async {
    try {
      final charge = await _repo.getAdditionalChargeById(chargeId!);
      nameController.text = charge.name;
      defaultValueController.text = charge.defaultValue.toString();
      hsnSacController.text = charge.hsnSac ?? "";
      selectedType.value = charge.type;
      selectedTaxId.value = charge.taxId.id;
      isActive.value = charge.isActive;
      isTaxIncluding.value = charge.isTaxIncluding;
    } catch (e) {
      Log.e("Error fetching charge by ID", e);
      AppSnackbar.error(e.toString());
    }
  }

  void setIsActive(bool value) => isActive.value = value;
  void setIsTaxIncluding(bool value) => isTaxIncluding.value = value;

  Future<void> saveCharge() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedTaxId.value == null) {
      AppSnackbar.warning("Please select a tax");
      return;
    }

    try {
      isSaving.value = true;
      final data = {
        if (isEdit) "additionalChargeId": chargeId,
        "name": nameController.text.trim(),
        "type": selectedType.value,
        "defaultValue": int.tryParse(defaultValueController.text.trim()) ?? 0,
        "taxId": selectedTaxId.value,
        "isTaxIncluding": isTaxIncluding.value,
        "hsnSac": hsnSacController.text.trim(),
        "isActive": isActive.value,
      };

      if (isEdit) {
        await _repo.updateAdditionalCharge(data);
        _refreshAndBack();
        AppSnackbar.success("Additional charge updated successfully");
      } else {
        await _repo.createAdditionalCharge(data);
        _refreshAndBack();
        AppSnackbar.success("Additional charge added successfully");
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<AdditionalChargeController>()) {
      AdditionalChargeController.instance.refreshData();
    }
    Get.back();
  }
}
