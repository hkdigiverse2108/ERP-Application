import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:ai_setu/modules/settings/payment_terms/controllers/payment_terms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentTermsAddEditController extends GetxController {
  final _repo = PaymentTermsRepository();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dayController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isActive = true.obs;
  final isDefault = false.obs;

  late String? paymentTermId;
  late bool isEdit;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    paymentTermId = args?['paymentTermId'];
    isEdit = args?['isEdit'] ?? false;

    if (isEdit && paymentTermId != null) {
      _fetchPaymentTermById();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    dayController.dispose();
    super.onClose();
  }

  Future<void> _fetchPaymentTermById() async {
    try {
      isLoading.value = true;
      final term = await _repo.getPaymentTermById(paymentTermId!);
      nameController.text = term.name;
      dayController.text = term.day.toString();
      isActive.value = term.isActive;
      isDefault.value = term.isDefault;
    } catch (e) {
      LoggerService.e(e.toString());
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setIsActive(bool value) => isActive.value = value;
  void setIsDefault(bool value) => isDefault.value = value;

  Future<void> savePaymentTerm() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isSaving.value = true;
      final data = {
        if (isEdit) "paymentTermId": paymentTermId,
        "name": nameController.text.trim(),
        "day": int.tryParse(dayController.text.trim()) ?? 0,
        "isActive": isActive.value,
        "isDefault": isDefault.value,
      };

      if (isEdit) {
        await _repo.updatePaymentTerm(data);
        _refreshAndBack();
        AppSnackbar.success("Payment term updated successfully");
      } else {
        await _repo.createPaymentTerm(data);
        _refreshAndBack();
        AppSnackbar.success("Payment term added successfully");
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<PaymentTermsController>()) {
      PaymentTermsController.instance.refreshData();
    }
    Get.back();
  }
}
