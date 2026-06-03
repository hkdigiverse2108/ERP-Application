import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/repositories/bank_cash/bank_repository.dart';
import 'package:ai_setu/modules/bank_cash/bank_transaction/controllers/bank_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BankTransactionAddEditController extends GetxController {
  final _bankRepo = BankRepository();

  final isEdit = false.obs;
  final isSaving = false.obs;
  final isLoading = false.obs;
  BankTransactionModel? transaction;

  final formKey = GlobalKey<FormState>();

  // Controllers
  final voucherNoController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  // Reactive variables
  final transactionDate = DateTime.now().obs;
  final transactionType = 'Transfer'.obs;
  final fromAccount = Rxn<IdNameModel>();
  final toAccount = Rxn<IdNameModel>();
  final branchId = ''.obs;

  final bankList = <IdNameModel>[].obs;

  final transactionTypes = ['Transfer', 'Deposit', 'Withdrawal'];

  @override
  void onInit() {
    super.onInit();
    dateController.text = DateFormat(
      'dd-MM-yyyy',
    ).format(transactionDate.value);
    final args = Get.arguments;
    if (args is BankTransactionModel) {
      isEdit.value = true;
      transaction = args;
      _populateFields();
    }
    fetchBanks();
  }

  Future<void> fetchBanks() async {
    try {
      isLoading.value = true;
      final list = await _bankRepo.getBankDropdown();
      bankList.value = list;
    } catch (e) {
      Log.e("BankTransactionAddEditController Error (fetchBanks)", e);
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    if (transaction != null) {
      voucherNoController.text = transaction!.voucherNo;
      amountController.text = transaction!.amount.toString();
      descriptionController.text = transaction!.description;
      transactionDate.value = transaction!.transactionDate;
      dateController.text = DateFormat(
        'dd-MM-yyyy',
      ).format(transactionDate.value);
      transactionType.value =
          transaction!.transactionType.capitalizeFirst ??
          transaction!.transactionType;
      fromAccount.value = transaction!.fromAccount;
      toAccount.value = transaction!.toAccount;
      branchId.value = transaction!.branchId?.toString() ?? '';
    }
  }

  void onBankChanged(String? val, bool isFrom) {
    if (val == null) return;
    final bank = bankList.firstWhere((e) => e.name == val);
    if (isFrom) {
      fromAccount.value = bank;
    } else {
      toAccount.value = bank;
    }
  }

  Future<void> saveTransaction() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isSaving.value = true;

      final data = {
        "transactionDate": transactionDate.value.toIso8601String(),
        "transactionType": transactionType.value.toLowerCase(),
        "fromAccount": fromAccount.value?.id,
        "toAccount": toAccount.value?.id,
        "amount": double.tryParse(amountController.text) ?? 0.0,
        "description": descriptionController.text,
        "branchId": branchId.value.isEmpty ? null : branchId.value,
      };

      if (isEdit.value && transaction != null) {
        data["bankTransactionId"] = transaction!.id;
        final res = await _bankRepo.updateBankTransaction(data);
        if (res) {
          _refreshAndBack();
          AppSnackbar.success("Transaction updated successfully");
        } else {
          AppSnackbar.error("Failed to update transaction");
        }
      } else {
        final res = await _bankRepo.addBankTransaction(data);
        if (res) {
          _refreshAndBack();
          AppSnackbar.success("Transaction added successfully");
        } else {
          AppSnackbar.error("Failed to add transaction");
        }
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (Get.isRegistered<BankTransactionController>()) {
      BankTransactionController.instance.refreshData();
    }
    Get.back();
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: transactionDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      transactionDate.value = picked;
      dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  void onClose() {
    voucherNoController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
