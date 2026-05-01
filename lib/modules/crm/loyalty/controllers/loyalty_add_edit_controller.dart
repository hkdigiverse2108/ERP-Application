import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/crm/loyalty_model.dart';
import 'package:ai_setu/data/repositories/crm/loyalty_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoyaltyAddEditController extends GetxController {
  final _repository = LoyaltyRepository();

  final isEdit = false.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  // Form Fields
  final nameController = TextEditingController();
  final discountValueController = TextEditingController();
  final minPurchaseAmountController = TextEditingController();
  final redemptionPointsController = TextEditingController();
  final usageLimitController = TextEditingController();
  final descriptionController = TextEditingController();

  final type = 'discount'.obs;
  final launchDate = DateTime.now().obs;
  final expiryDate = DateTime.now().add(const Duration(days: 30)).obs;

  final singleTimeUse = false.obs;
  final isActive = true.obs;

  String? loyaltyId;

  final types = ['discount', 'free_product'];
  final typeDisplayNames = {
    'discount': 'Discount',
    'free_product': 'Free Product',
  };

  List<String> get displayTypes =>
      types.map((e) => typeDisplayNames[e]!).toList();

  String get currentTypeDisplay => typeDisplayNames[type.value] ?? type.value;

  void onTypeDisplayChanged(String displayValue) {
    type.value = typeDisplayNames.entries
        .firstWhere((e) => e.value == displayValue)
        .key;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is LoyaltyModel) {
      isEdit.value = true;
      loyaltyId = args.id;
      _populateData(args);
    }
  }

  void _populateData(LoyaltyModel item) {
    nameController.text = item.name;
    discountValueController.text = item.discountValue.toString();
    minPurchaseAmountController.text = item.minimumPurchaseAmount.toString();
    redemptionPointsController.text = item.redemptionPoints.toString();
    usageLimitController.text = item.usageLimit.toString();
    descriptionController.text = item.description;

    type.value = item.type;
    launchDate.value = item.campaignLaunchDate;
    expiryDate.value = item.campaignExpiryDate;

    singleTimeUse.value = item.singleTimeUse;
    isActive.value = item.isActive;
  }

  Future<void> save() async {
    if (nameController.text.isEmpty) {
      AppSnackbar.error('Please enter campaign name');
      return;
    }
    if (discountValueController.text.isEmpty) {
      AppSnackbar.error('Please enter discount value');
      return;
    }

    try {
      isSaving.value = true;
      final data = {
        if (isEdit.value) 'loyaltyId': loyaltyId,
        'name': nameController.text,
        'discountValue': int.tryParse(discountValueController.text) ?? 0,
        'type': type.value,
        'minimumPurchaseAmount':
            int.tryParse(minPurchaseAmountController.text) ?? 0,
        'redemptionPoints': int.tryParse(redemptionPointsController.text) ?? 0,
        'usageLimit': int.tryParse(usageLimitController.text) ?? 0,
        'campaignLaunchDate': DateFormat('yyyy-MM-dd').format(launchDate.value),
        'campaignExpiryDate': DateFormat('yyyy-MM-dd').format(expiryDate.value),
        'description': descriptionController.text,
        'singleTimeUse': singleTimeUse.value,
        'isActive': isActive.value,
      };

      if (isEdit.value) {
        await _repository.updateLoyalty(data);
      } else {
        await _repository.addLoyalty(data);
      }

      Get.back(result: true);
      AppSnackbar.success(
        'Loyalty campaign ${isEdit.value ? "updated" : "added"} successfully',
      );
    } catch (e) {
      AppSnackbar.error('Error saving loyalty campaign: $e');
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    discountValueController.dispose();
    minPurchaseAmountController.dispose();
    redemptionPointsController.dispose();
    usageLimitController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
