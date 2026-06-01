import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/pos/cash_control_model.dart';
import 'package:ai_setu/data/repositories/pos/cash_control_repository.dart';
import 'package:ai_setu/data/repositories/pos/cash_register_repository.dart';

class CashControlController extends GetxController {
  final CashControlRepository repository;
  final CashRegisterRepository registerRepository;

  CashControlController({
    required this.repository,
    required this.registerRepository,
  });

  final cashControlList = <CashControlModel>[].obs;
  final isLoading = false.obs;
  final totalOpeningBalance = 0.0.obs;
  final registerDetails = Rxn<Map<String, dynamic>>();
  final isRegisterOpen = false.obs;

  // Controllers for the add entry form
  final amountController = TextEditingController();
  final remarkController = TextEditingController();
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkRegisterStatus().then((_) => fetchCashControl());
  }

  Future<void> checkRegisterStatus() async {
    try {
      final res = await registerRepository.getRegisterDetails();
      if (res.status == 200 && res.data != null) {
        registerDetails.value = res.data;
        isRegisterOpen.value = true;
      } else {
        isRegisterOpen.value = false;
      }
    } catch (e) {
      isRegisterOpen.value = false;
    }
  }

  Future<void> fetchCashControl() async {
    isLoading.value = true;
    try {
      final res = await repository.getAllCashControl(
        page: 1,
        limit: 100, // Fetch enough to show in cards
        activeFilter: 'true',
        registerFilter: 'true',
      );

      if (res.status == 200) {
        final dataList = res.data['cashControl_data'] as List?;
        if (dataList != null) {
          cashControlList.assignAll(
            dataList.map((e) => CashControlModel.fromJson(e)).toList(),
          );
        }
        totalOpeningBalance.value = (res.data['totalAmount'] as num? ?? 0.0).toDouble();
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCashControl() async {
    if (amountController.text.isEmpty) {
      AppSnackbar.warning("Please enter amount");
      return;
    }

    isSaving.value = true;
    try {
      final payload = {
        "type": "opening",
        "amount": amountController.text,
        "remark": remarkController.text,
      };

      final res = await repository.addCashControl(payload);
      if (res.status == 200) {
        AppSnackbar.success("Cash control entry added!");
        amountController.clear();
        remarkController.clear();
        fetchCashControl(); // Refresh list
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    remarkController.dispose();
    super.onClose();
  }
}
