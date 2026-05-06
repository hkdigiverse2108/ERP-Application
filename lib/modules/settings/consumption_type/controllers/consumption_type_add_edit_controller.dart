import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/consumption_type/consumption_type_model.dart';
import 'package:ai_setu/data/repositories/settings/consumption_type_repository.dart';
import 'package:ai_setu/modules/settings/consumption_type/controllers/consumption_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsumptionTypeAddEditController extends GetxController {
  final _repo = ConsumptionTypeRepository();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isActive = true.obs;

  late String? consumptionTypeId;
  late bool isEdit;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    consumptionTypeId = args?['consumptionTypeId'];
    isEdit = args?['isEdit'] ?? false;

    if (isEdit && consumptionTypeId != null) {
      _fetchConsumptionTypeById();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  ConsumptionTypeModel? _currentType;
  bool get isSystemGenerated => _currentType?.isSystemGenerated ?? false;

  Future<void> _fetchConsumptionTypeById() async {
    try {
      isLoading.value = true;
      _currentType = await _repo.getConsumptionTypeById(consumptionTypeId!);
      nameController.text = _currentType!.name;
      isActive.value = _currentType!.isActive;
    } catch (e) {
      Log.e("Error fetching consumption type by ID", e);
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setIsActive(bool value) {
    if (_currentType?.isSystemGenerated ?? false) {
      AppSnackbar.error("System-generated consumption type cannot be modified");
      return;
    }
    isActive.value = value;
  }

  Future<void> saveConsumptionType() async {
    if (!formKey.currentState!.validate()) return;

    if (isEdit && (_currentType?.isSystemGenerated ?? false)) {
      AppSnackbar.error("System-generated consumption type cannot be modified");
      return;
    }

    try {
      isSaving.value = true;
      final data = {
        if (isEdit) "consumptionTypeId": consumptionTypeId,
        "name": nameController.text.trim(),
        "isActive": isActive.value,
      };

      if (isEdit) {
        await _repo.updateConsumptionType(data);
        _refreshAndBack();
        AppSnackbar.success("Consumption type updated successfully");
      } else {
        await _repo.createConsumptionType(data);
        _refreshAndBack();
        AppSnackbar.success("Consumption type added successfully");
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<ConsumptionTypeController>()) {
      ConsumptionTypeController.instance.refreshData();
    }
    Get.back();
  }
}
