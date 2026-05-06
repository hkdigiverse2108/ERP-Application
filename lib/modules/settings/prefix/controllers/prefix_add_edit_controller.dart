import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/repositories/settings/prefix_repository.dart';
import 'package:ai_setu/modules/settings/prefix/controllers/prefix_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrefixAddEditController extends GetxController {
  final _repo = PrefixRepository();

  final formKey = GlobalKey<FormState>();
  final prefixController = TextEditingController();
  final sequenceController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isActive = true.obs;

  late String? prefixId;
  late bool isEdit;
  String? prefixType;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    prefixId = args?['prefixId'];
    isEdit = args?['isEdit'] ?? false;

    if (isEdit && prefixId != null) {
      _fetchPrefixById();
    }
  }

  @override
  void onClose() {
    prefixController.dispose();
    sequenceController.dispose();
    super.onClose();
  }

  Future<void> _fetchPrefixById() async {
    try {
      isLoading.value = true;
      final prefix = await _repo.getPrefixById(prefixId!);
      prefixController.text = prefix.prefix;
      sequenceController.text = prefix.sequenceNumber.toString();
      isActive.value = prefix.isActive;
      prefixType = prefix.prefixType;
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setIsActive(bool value) => isActive.value = value;

  Future<void> savePrefix() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isSaving.value = true;
      final data = {
        if (isEdit) "prefixId": prefixId,
        "prefix": prefixController.text.trim(),
        "sequenceNumber": int.tryParse(sequenceController.text.trim()) ?? 1,
        "isActive": isActive.value,
        if (!isEdit) "prefixType": prefixType ?? "Manual",
      };

      if (isEdit) {
        await _repo.updatePrefix(data);
        _refreshAndBack();
        AppSnackbar.success("Prefix updated successfully");
      } else {
        await _repo.createPrefix(data);
        _refreshAndBack();
        AppSnackbar.success("Prefix added successfully");
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<PrefixController>()) {
      PrefixController.instance.refreshData();
    }
    Get.back();
  }
}
