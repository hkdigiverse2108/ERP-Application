import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/contact_model/customer_pos_details_model.dart';
import 'package:ai_setu/data/repositories/contact_repository.dart';
import 'package:ai_setu/data/repositories/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentAddEditController extends GetxController {
  static PaymentAddEditController get instance => Get.find();

  final PaymentRepository _paymentRepository = PaymentRepository();
  final ContactRepository _contactRepository = ContactRepository();

  final isEdit = false.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  // Form Fields
  final voucherType = VoucherType.purchase.obs;
  final party = Rxn<ContactDropdownModel>();
  final customerDetails = Rxn<CustomerPosDetailsModel>();
  final paymentDate = DateTime.now().obs;
  final paymentType = 'advance'.obs; // 'advance' or 'against_voucher'
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final isActive = true.obs;

  String get label =>
      voucherType.value == VoucherType.purchase ? "Payment" : "Receipt";

  // Against Voucher Data
  final dueVouchers = <PosPaymentOrder>[].obs;
  final selectedVouchers = <PaymentItem>[].obs;

  // Lists for dropdowns
  final parties = <ContactDropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    isLoading.value = true;

    final args = Get.arguments;
    if (args is PosPaymentModel) {
      isEdit.value = true;
      voucherType.value =
          args.voucherType.toLowerCase() == VoucherType.sales.name
          ? VoucherType.sales
          : VoucherType.purchase;
      await _loadPaymentData(args);
    } else if (args is Map && args.containsKey('voucherType')) {
      voucherType.value = args['voucherType'];
    }

    await fetchParties();
    isLoading.value = false;
  }

  Future<void> fetchParties() async {
    try {
      final typeFilter = voucherType.value == VoucherType.purchase
          ? ContactType.supplier.name
          : ContactType.customer.name;

      final res = await _contactRepository.getContactDropdown(
        typeFilter: typeFilter,
      );
      parties.assignAll(res);
    } catch (e) {
      AppSnackbar.error('Error fetching parties: $e');
    }
  }

  Future<void> _loadPaymentData(PosPaymentModel payment) async {
    try {
      final detail = await _paymentRepository.getPosPaymentById(payment.id);

      paymentDate.value = detail.createdAt;
      paymentType.value = detail.paymentType.toLowerCase().contains('advance')
          ? 'advance'
          : 'against_voucher';
      amountController.text = detail.amount.toString();
      descriptionController.text = detail.expenseType;
      isActive.value = detail.status.toLowerCase() == 'active';

      if (detail.partyId != null) {
        party.value = parties.firstWhereOrNull(
          (e) => e.id == detail.partyId?.id,
        );
        if (paymentType.value == 'against_voucher' && party.value != null) {
          await fetchDueVouchers(party.value!.id);
          // Map existing vouchers if available in detail.posOrder or similar
        }
      }
    } catch (e) {
      AppSnackbar.error('Error loading payment detail: $e');
    }
  }

  void onPartyChanged(ContactDropdownModel? value) {
    party.value = value;
    selectedVouchers.clear();
    if (value != null) {
      fetchCustomerDetails(value.id);
      if (paymentType.value == 'against_voucher') {
        fetchDueVouchers(value.id);
      }
    } else {
      dueVouchers.clear();
      customerDetails.value = null;
    }
  }

  Future<void> fetchCustomerDetails(String partyId) async {
    try {
      final details = await _paymentRepository.getCustomerPosDetails(partyId);
      customerDetails.value = details;
    } catch (e) {
      debugPrint('Error fetching customer details: $e');
    }
  }

  void onPaymentTypeChanged(String? value) {
    if (value != null) {
      paymentType.value = value;
      if (value == 'against_voucher') {
        if (party.value != null) {
          fetchDueVouchers(party.value!.id);
        }
      } else {
        selectedVouchers.clear();
        dueVouchers.clear();
      }
    }
  }

  Future<void> fetchDueVouchers(String partyId) async {
    try {
      final vouchers = await _paymentRepository.getDueVouchers(partyId);
      dueVouchers.assignAll(vouchers);
    } catch (e) {
      AppSnackbar.error('Error fetching vouchers: $e');
    }
  }

  void addVoucherRow(PosPaymentOrder voucher) {
    if (selectedVouchers.any((e) => e.voucherId == voucher.id)) {
      AppSnackbar.warning('Voucher already added');
      return;
    }
    selectedVouchers.add(
      PaymentItem(
        voucherId: voucher.id,
        voucherNo: voucher.orderNo,
        totalAmount: voucher.totalAmount,
        paidAmount: voucher.paidAmount,
        pendingAmount: voucher.totalAmount - voucher.paidAmount,
        amount: 0,
        kasarAmount: 0,
      ),
    );
  }

  void removeVoucherRow(int index) {
    selectedVouchers.removeAt(index);
    _calculateTotalAmount();
  }

  void onAmountChanged(int index, String value) {
    final amount = double.tryParse(value) ?? 0;
    selectedVouchers[index] = selectedVouchers[index].copyWith(amount: amount);
    _calculateTotalAmount();
  }

  void onKasarChanged(int index, String value) {
    final kasar = double.tryParse(value) ?? 0;
    selectedVouchers[index] = selectedVouchers[index].copyWith(
      kasarAmount: kasar,
    );
    _calculateTotalAmount();
  }

  void _calculateTotalAmount() {
    if (paymentType.value == 'against_voucher') {
      double total = 0;
      for (var item in selectedVouchers) {
        total += item.amount;
      }
      amountController.text = total.toStringAsFixed(2);
    }
  }

  Future<void> save() async {
    if (party.value == null) {
      AppSnackbar.error('Please select a party');
      return;
    }
    if (amountController.text.isEmpty ||
        double.tryParse(amountController.text) == 0) {
      AppSnackbar.error('Please enter a valid amount');
      return;
    }

    isSaving.value = true;
    try {
      final data = {
        "partyId": party.value!.id,
        "amount": double.parse(amountController.text),
        "paymentType": paymentType.value,
        "date": paymentDate.value.toIso8601String(),
        "voucherType": voucherType.value.name,
        "remark":
            descriptionController.text, // Using expenseType as Note/Description
        "isActive": isActive.value,
        if (paymentType.value == 'against_voucher')
          "vouchers": selectedVouchers.map((e) => e.toMap()).toList(),
      };

      if (isEdit.value) {
        await _paymentRepository.updatePosPayment(data);
      } else {
        await _paymentRepository.addPosPayment(data);
      }
      Get.back(result: true);
      AppSnackbar.success('$label saved successfully');
    } catch (e) {
      AppSnackbar.error('Error saving payment: $e');
    } finally {
      isSaving.value = false;
    }
  }
}

class PaymentItem {
  final String voucherId;
  final String voucherNo;
  final double totalAmount;
  final double paidAmount;
  final double pendingAmount;
  final double amount;
  final double kasarAmount;

  PaymentItem({
    required this.voucherId,
    required this.voucherNo,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    required this.amount,
    required this.kasarAmount,
  });

  PaymentItem copyWith({double? amount, double? kasarAmount}) {
    return PaymentItem(
      voucherId: voucherId,
      voucherNo: voucherNo,
      totalAmount: totalAmount,
      paidAmount: paidAmount,
      pendingAmount: pendingAmount,
      amount: amount ?? this.amount,
      kasarAmount: kasarAmount ?? this.kasarAmount,
    );
  }

  Map<String, dynamic> toMap() => {
    "voucherId": voucherId,
    "amount": amount,
    "kasarAmount": kasarAmount,
  };
}
