import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/data/repositories/pos/credit_note_repository.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/data/repositories/bank_cash/bank_repository.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:get/get.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/pay_later_bottom_sheet.dart';

class PaymentMethod {
  final String name;
  final IconData icon;
  final Color color;

  PaymentMethod({required this.name, required this.icon, required this.color});
}

class PaymentLine {
  final Rx<PaymentMethod> method;
  final TextEditingController amountController;
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController transactionNoController = TextEditingController();
  final Rxn<IdNameModel> selectedAccount = Rxn<IdNameModel>();

  PaymentLine({required PaymentMethod method, required double amount})
    : amountController = TextEditingController(text: amount.toStringAsFixed(2)),
      method = method.obs;

  void dispose() {
    amountController.dispose();
    cardHolderController.dispose();
    transactionNoController.dispose();
  }
}

class PosMultiplePayController extends GetxController {
  final totalAmount = 0.0.obs;
  final paidAmount = 0.0.obs;
  final balanceAmount = 0.0.obs;
  final selectedCustomer = Rxn<ContactDropdownModel>();
  final appliedRedemption = Rxn<RedemptionItem>();
  final _creditNoteRepo = CreditNoteRepository();
  final _bankRepo = BankRepository();

  final paymentLines = <PaymentLine>[].obs;
  final bankAccounts = <IdNameModel>[].obs;
  final isBankLoading = false.obs;

  // Pay Later Integration
  final payLaterData = Rxn<Map<String, dynamic>>();

  final availableMethods = [
    PaymentMethod(
      name: "Cash",
      icon: Icons.payments_outlined,
      color: Colors.green,
    ),
    PaymentMethod(
      name: "Card",
      icon: Icons.credit_card_outlined,
      color: Colors.blue,
    ),
    PaymentMethod(
      name: "UPI",
      icon: Icons.qr_code_scanner_outlined,
      color: Colors.purple,
    ),
    PaymentMethod(
      name: "Bank",
      icon: Icons.account_balance_outlined,
      color: Colors.orange,
    ),
    PaymentMethod(
      name: "Cheque",
      icon: Icons.account_balance_wallet_outlined,
      color: Colors.teal,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      totalAmount.value = args['totalAmount'] ?? 0.0;
      selectedCustomer.value = args['customer'];
      appliedRedemption.value = args['redemption'];
    }

    fetchBankAccounts();
    balanceAmount.value = totalAmount.value;
    addPaymentLine();
  }

  Future<void> fetchBankAccounts() async {
    try {
      isBankLoading.value = true;
      final data = await _bankRepo.getBankDropdown();
      bankAccounts.assignAll(data);
    } catch (e) {
      debugPrint("Error fetching banks: $e");
    } finally {
      isBankLoading.value = false;
    }
  }

  void addPaymentLine() {
    if (paymentLines.isNotEmpty && balanceAmount.value <= 0) return;

    final double amount = balanceAmount.value > 0 ? balanceAmount.value : 0.0;
    final line = PaymentLine(method: availableMethods[0], amount: amount);
    paymentLines.add(line);
    calculateTotals();
  }

  void removePaymentLine(int index) {
    paymentLines[index].dispose();
    paymentLines.removeAt(index);
    calculateTotals();
  }

  void resetPayments() {
    for (var line in paymentLines) {
      line.dispose();
    }
    paymentLines.clear();
    addPaymentLine();
  }

  void calculateTotals() {
    double total = 0.0;
    for (var line in paymentLines) {
      total += double.tryParse(line.amountController.text) ?? 0.0;
    }
    paidAmount.value = total;
    balanceAmount.value = (totalAmount.value - paidAmount.value).toPrecision(2);
  }

  void openPayLaterSheet() {
    Get.bottomSheet(
      PayLaterBottomSheet(
        totalAmount: balanceAmount.value,
        onConfirm: (paymentTermsId, dueDate, sendReminder) {
          Get.back(); // Close sheet
          payLaterData.value = {
            "dueDate": dueDate.toIso8601String(),
            "sendReminder": sendReminder,
            "paymentTermsId": paymentTermsId,
          };
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void removePayLater() {
    payLaterData.value = null;
  }

  Future<void> processPayment({bool shouldPrint = false}) async {
    if (balanceAmount.value > 0 && payLaterData.value == null) {
      AppSnackbar.warning(
        "Please pay the full amount or configure 'Pay Later' for the balance",
      );
      return;
    }

    // Validate that non-cash methods have an account selected
    for (var line in paymentLines) {
      if (line.method.value.name != "Cash" &&
          line.selectedAccount.value == null) {
        AppSnackbar.error(
          "Please select a bank account for ${line.method.value.name} payment",
        );
        return;
      }
    }

    try {
      // 1. If redemption is applied, call redeem API first
      if (appliedRedemption.value != null) {
        final res = await _creditNoteRepo.redeemCreditNote(
          appliedRedemption.value!.toRedeemPayload(),
        );
        if (res.status != 200) {
          AppSnackbar.error(
            "Credit redemption failed: ${res.message ?? "Error"}",
          );
          return;
        }
      }

      // 2. Prepare multiple payments data for the order payload
      final multiPayData = paymentLines.map((line) {
        final data = {
          "method": line.method.value.name.toLowerCase(),
          "amount":
              double.tryParse(line.amountController.text)?.toStringAsFixed(2) ??
              "0.00",
        };

        if (line.method.value.name != "Cash") {
          data["paymentAccountId"] = line.selectedAccount.value?.id ?? "";

          if (line.method.value.name == "Card") {
            data["cardHolderName"] = line.cardHolderController.text;
            data["cardTransactionNo"] = line.transactionNoController.text;
          } else {
            data["transactionNo"] = line.transactionNoController.text;
          }
        }
        return data;
      }).toList();

      // Return the payment data and print flag to PosNewController
      Get.back(
        result: {
          'payments': multiPayData,
          'shouldPrint': shouldPrint,
          'payLater': payLaterData.value,
        },
      );
    } catch (e) {
      AppSnackbar.error("Payment processing error: $e");
    }
  }

  @override
  void onClose() {
    for (var line in paymentLines) {
      line.dispose();
    }
    super.onClose();
  }
}
