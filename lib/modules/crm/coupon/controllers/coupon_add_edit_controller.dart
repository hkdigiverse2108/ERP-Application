import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/data/repositories/crm/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponAddEditController extends GetxController {
  final _repository = CouponRepository();

  final isEdit = false.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  // Form Fields
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final redeemValueController = TextEditingController();
  final usageLimitController = TextEditingController();
  final expiryDaysController = TextEditingController();
  
  final redemptionType = 'percentage'.obs;
  final status = 'active'.obs;
  
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(const Duration(days: 30)).obs;
  
  final singleTimeUse = false.obs;
  final isActive = true.obs;

  bool _isInternalChange = false;

  String? couponId;

  final redemptionTypes = ['percentage', 'flat'];
  final statusOptions = ['active', 'inactive'];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is CouponModel) {
      isEdit.value = true;
      couponId = args.id;
      _populateData(args);
    }

    expiryDaysController.addListener(_onExpiryDaysChanged);
  }

  void _onExpiryDaysChanged() {
    if (_isInternalChange) return;
    _calculateEndDate();
  }

  void updateStartDate(DateTime date) {
    startDate.value = date;
    _calculateEndDate();
  }

  void updateEndDate(DateTime date) {
    endDate.value = date;
    _calculateExpiryDays();
  }

  void _calculateEndDate() {
    final days = int.tryParse(expiryDaysController.text);
    if (days != null) {
      _isInternalChange = true;
      endDate.value = startDate.value.add(Duration(days: days));
      _isInternalChange = false;
    }
  }

  void _calculateExpiryDays() {
    final diff = endDate.value.difference(startDate.value).inDays;
    _isInternalChange = true;
    expiryDaysController.text = diff < 0 ? "0" : diff.toString();
    _isInternalChange = false;
  }

  void _populateData(CouponModel item) {
    nameController.text = item.name;
    priceController.text = item.couponPrice?.toString() ?? '';
    redeemValueController.text = item.redeemValue.toString();
    usageLimitController.text = item.usageLimit?.toString() ?? '';
    expiryDaysController.text = item.expiryDays?.toString() ?? '';
    
    redemptionType.value = item.redemptionType;
    status.value = item.status;
    
    if (item.startDate != null) startDate.value = item.startDate!;
    if (item.endDate != null) endDate.value = item.endDate!;
    
    singleTimeUse.value = item.singleTimeUse;
    isActive.value = item.isActive;
  }

  Future<void> save() async {
    if (nameController.text.isEmpty) {
      AppSnackbar.error('Please enter coupon name');
      return;
    }
    if (redeemValueController.text.isEmpty) {
      AppSnackbar.error('Please enter redeem value');
      return;
    }

    try {
      isSaving.value = true;
      final data = {
        if (isEdit.value) 'id': couponId,
        'name': nameController.text,
        'couponPrice': int.tryParse(priceController.text),
        'redemptionType': redemptionType.value,
        'redeemValue': int.tryParse(redeemValueController.text) ?? 0,
        'usageLimit': int.tryParse(usageLimitController.text),
        'expiryDays': int.tryParse(expiryDaysController.text),
        'startDate': DateFormat('yyyy-MM-dd').format(startDate.value),
        'endDate': DateFormat('yyyy-MM-dd').format(endDate.value),
        'status': status.value,
        'singleTimeUse': singleTimeUse.value,
        'isActive': isActive.value,
      };

      if (isEdit.value) {
        await _repository.updateCoupon(data);
      } else {
        await _repository.addCoupon(data);
      }

      Get.back(result: true);
      AppSnackbar.success('Coupon ${isEdit.value ? "updated" : "added"} successfully');
    } catch (e) {
      AppSnackbar.error('Error saving coupon: $e');
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    redeemValueController.dispose();
    usageLimitController.dispose();
    expiryDaysController.dispose();
    super.onClose();
  }
}
