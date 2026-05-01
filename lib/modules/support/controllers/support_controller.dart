import 'package:ai_setu/data/repositories/support/support_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  static SupportController get instance => Get.find();

  final SupportRepository _repository = SupportRepository();

  final formKey = GlobalKey<FormState>();
  final businessNameController = TextEditingController();
  final contactNameController = TextEditingController();
  final phoneController = TextEditingController();
  final notesController = TextEditingController();

  final countryCode = '91'.obs;
  final isLoading = false.obs;

  void updateCountryCode(String code) {
    countryCode.value = code;
  }

  Future<void> submitCallRequest() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      final payload = {
        "businessName": businessNameController.text.trim(),
        "contactName": contactNameController.text.trim(),
        "contactNo": {
          "countryCode": countryCode.value,
          "phoneNo": phoneController.text.trim(),
        },
        "note": notesController.text.trim(),
      };

      await _repository.submitCallRequest(payload);
      
      Get.back(); // Close the dialog
      Get.snackbar(
        'Success',
        'Call back request submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green,
      );

      // Clear the form
      businessNameController.clear();
      contactNameController.clear();
      phoneController.clear();
      notesController.clear();
      countryCode.value = '91';

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    businessNameController.dispose();
    contactNameController.dispose();
    phoneController.dispose();
    notesController.dispose();
    super.onClose();
  }
}

