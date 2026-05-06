import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/modules/settings/taxes/controllers/taxes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxAddEditController extends GetxController {
  final TaxRepository _repo = TaxRepository();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final percentageController = TextEditingController();

  final RxString name = ''.obs;
  final RxDouble percentage = 0.0.obs;
  final RxBool isActive = true.obs;

  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final String? taxId = Get.arguments?['taxId'];
  final bool isEdit = Get.arguments?['isEdit'] ?? false;

  @override
  void onInit() {
    super.onInit();
    if (isEdit && taxId != null) {
      _fetchTaxById(taxId!);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    percentageController.dispose();
    super.onClose();
  }

  Future<void> _fetchTaxById(String id) async {
    try {
      isLoading.value = true;
      final tax = await _repo.getTaxById(id);
      name.value = tax.name;
      percentage.value = tax.percentage.toDouble();
      isActive.value = tax.isActive;

      nameController.text = tax.name;
      percentageController.text = tax.percentage.toString();
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setName(String value) => name.value = value;
  void setPercentage(String value) =>
      percentage.value = double.tryParse(value) ?? 0.0;
  void setIsActive(bool value) => isActive.value = value;

  Future<void> saveTax() async {
    if (!formKey.currentState!.validate()) return;

    // Update Rx variables from controllers before saving
    name.value = nameController.text;
    percentage.value = double.tryParse(percentageController.text) ?? 0.0;

    if (isEdit) {
      await updateTax();
    } else {
      await addTax();
    }
  }

  Future<void> addTax() async {
    final Map<String, dynamic> data = {
      'name': name.value,
      'percentage': percentage.value,
      'isActive': isActive.value,
    };

    try {
      isSaving.value = true;
      await _repo.addTax(data);
      _refreshAndBack();
      AppSnackbar.success("Tax added successfully");
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateTax() async {
    if (taxId == null) return;
    final Map<String, dynamic> data = {
      'taxId': taxId,
      'name': name.value,
      'percentage': percentage.value,
      'isActive': isActive.value,
    };

    try {
      isSaving.value = true;
      await _repo.updateTax(data);
      _refreshAndBack();
      AppSnackbar.success("Tax updated successfully");
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<TaxesController>()) {
      TaxesController.instance.refreshData();
    }
    Get.back();
  }
}
