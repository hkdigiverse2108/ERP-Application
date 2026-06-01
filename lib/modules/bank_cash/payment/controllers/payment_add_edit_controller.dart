import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/contact_model/customer_pos_details_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/bank_cash/payment_repository.dart';
import 'package:ai_setu/modules/bank_cash/payment/controllers/payment_controller.dart';
import 'package:ai_setu/modules/bank_cash/receipt/controllers/receipt_controller.dart';
import 'package:ai_setu/data/model/bank_cash/payment_dropdown_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/repositories/bank_cash/bank_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentAddEditController extends GetxController {
  static PaymentAddEditController get instance => Get.find();

  final PaymentRepository _paymentRepository = PaymentRepository();
  final ContactRepository _contactRepository = ContactRepository();
  final BankRepository _bankRepository = BankRepository();

  final isEdit = false.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isBankLoading = false.obs;

  // Form Fields
  final voucherType = VoucherType.purchase.obs;
  final party = Rxn<ContactDropdownModel>();
  final customerDetails = Rxn<CustomerPosDetailsModel>();
  final paymentDate = DateTime.now().obs;
  final paymentType = 'advance'.obs; // 'advance' or 'against_bill'
  final amountController = TextEditingController(text: '0');
  final descriptionController = TextEditingController();
  final isActive = true.obs;
  final initialVoucherId = RxnString();
  final initialDocType = RxnString();
  final originalPartyId = RxnString();

  // Payment Mode
  final paymentModes = ['cash', 'bank', 'check', 'card', 'upi'].obs;
  final selectedPaymentMode = 'cash'.obs;
  final banks = <IdNameModel>[].obs;
  final selectedBank = Rxn<IdNameModel>();
  String? _originalRegisterId;

  String get label =>
      voucherType.value == VoucherType.purchase ? "Payment" : "Receipt";

  // Against Voucher Data
  final dueVouchers = <PendingPaymentDropdownModel>[].obs;
  final selectedVoucher = Rxn<PaymentItem>();
  final amountSettleController = TextEditingController();
  final kasarSettleController = TextEditingController();

  // Lists for dropdowns
  final parties = <ContactDropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    isLoading.value = true;
    await fetchBanks();
    final args = Get.arguments;
    String? includeId;
    if (args is PosPaymentModel) {
      includeId = args.partyId?.id;
    }
    await fetchParties(includeId: includeId);
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
    isLoading.value = false;
  }

  Future<void> fetchParties({String? includeId}) async {
    try {
      final typeFilter = voucherType.value == VoucherType.purchase
          ? "${ContactType.supplier.name},${ContactType.customer.name}"
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
          : 'against_bill';
      amountController.text = detail.amount.toString();
      descriptionController.text = detail.expenseType;
      isActive.value = detail.status.toLowerCase() == 'active';

      if (detail.partyId != null) {
        originalPartyId.value = detail.partyId?.id;
        party.value = parties.firstWhereOrNull(
          (e) => e.id == detail.partyId?.id,
        );

        if (paymentType.value == 'against_bill' && party.value != null) {
          final refId =
              detail.posOrderId?.id ??
              detail.invoiceId ??
              detail.purchaseBillId ??
              detail.posCreditNoteId ??
              detail.salesCreditNoteId;

          if (refId != null) {
            initialVoucherId.value = refId;
            if (detail.posOrderId != null) {
              initialDocType.value = 'POS_ORDER';
            } else if (detail.invoiceId != null) {
              initialDocType.value = 'INVOICE';
            } else if (detail.purchaseBillId != null) {
              initialDocType.value = 'SUPPLIER_BILL';
            } else if (detail.posCreditNoteId != null) {
              initialDocType.value = 'POS_CREDIT_NOTE';
            } else if (detail.salesCreditNoteId != null) {
              initialDocType.value = 'SALES_CREDIT_NOTE';
            }
          }

          await fetchDueVouchers();

          if (refId != null) {
            final voucher = dueVouchers.firstWhereOrNull((v) => v.id == refId);
            if (voucher != null) {
              selectVoucher(voucher, force: true);
              amountSettleController.text = detail.amount.toString();
              kasarSettleController.text = detail.kasar.toString();
              onAmountChanged(detail.amount.toString());
              onKasarChanged(detail.kasar.toString());
            }
          }
        }

        // Restore Payment Mode and Bank
        selectedPaymentMode.value = detail.paymentMode;
        _originalRegisterId = detail.posCashRegisterId;
        if (isBankRelated(detail.paymentMode)) {
          selectedBank.value = banks.firstWhereOrNull(
            (e) => e.id == detail.posCashRegisterId,
          );
        }
      }
    } catch (e) {
      AppSnackbar.error('Error loading payment detail: $e');
      LoggerService.error(e.toString());
    }
  }

  void onPartyChanged(ContactDropdownModel? value) {
    if (isEdit.value) return;
    party.value = value;
    selectedVoucher.value = null;
    if (value != null) {
      if (paymentType.value == 'against_bill') {
        fetchDueVouchers();
      }
    } else {
      dueVouchers.clear();
      customerDetails.value = null;
    }
  }

  void onPaymentTypeChanged(String? value) {
    if (isEdit.value) return;
    if (value != null) {
      paymentType.value = value;
      if (value == 'against_bill') {
        if (party.value != null) {
          fetchDueVouchers();
        }
      } else {
        selectedVoucher.value = null;
        dueVouchers.clear();
      }
    }
  }

  void onPaymentModeChanged(String? value) {
    if (isEdit.value) return;
    if (value != null) {
      selectedPaymentMode.value = value;
      if (!isBankRelated(value)) {
        selectedBank.value = null;
      }
    }
  }

  bool isBankRelated(String mode) {
    return ['bank', 'check', 'card', 'upi'].contains(mode.toLowerCase());
  }

  Future<void> fetchBanks() async {
    try {
      isBankLoading.value = true;
      final data = await _bankRepository.getBankDropdown();
      banks.assignAll(data);
    } catch (e) {
      LoggerService.error('Error fetching banks: $e');
    } finally {
      isBankLoading.value = false;
    }
  }

  Future<void> fetchDueVouchers() async {
    try {
      final p = party.value;
      if (p == null) {
        dueVouchers.clear();
        return;
      }

      final bool partyMatches = isEdit.value && p.id == originalPartyId.value;

      if (p.contactType == ContactType.customer) {
        if (voucherType.value == VoucherType.purchase) {
          final bool includeId =
              partyMatches &&
              (initialDocType.value == 'POS_CREDIT_NOTE' ||
                  initialDocType.value == 'SALES_CREDIT_NOTE');
          final credits = await _paymentRepository.getPendingCreditDropDown(
            customerId: p.id,
            includeId: includeId ? initialVoucherId.value : null,
          );
          final customerCredits = credits
              .map(
                (e) => PendingPaymentDropdownModel(
                  id: e.id,
                  name: e.name,
                  docNo: e.docNo,
                  docType: e.docType,
                  paidAmount: e.totalAmount - e.balanceAmount,
                  balanceAmount: e.balanceAmount,
                  customerId: e.customerId,
                ),
              )
              .toList();
          dueVouchers.assignAll(customerCredits);
        } else {
          final bool includeId =
              partyMatches &&
              (initialDocType.value == 'POS_ORDER' ||
                  initialDocType.value == 'INVOICE');
          final vouchers = await _paymentRepository.getPendingPaymentDropDown(
            customerId: p.id,
            includeId: includeId ? initialVoucherId.value : null,
          );
          dueVouchers.assignAll(vouchers);
        }
      } else if (p.contactType == ContactType.supplier) {
        final bool includeId =
            partyMatches && initialDocType.value == 'SUPPLIER_BILL';
        final vouchers = await _paymentRepository.getSupplierBillDropdown(
          supplierId: p.id,
          includeId: includeId ? initialVoucherId.value : null,
        );
        dueVouchers.assignAll(vouchers);
      } else {
        dueVouchers.clear();
      }
    } catch (e) {
      AppSnackbar.error('Error fetching vouchers: $e');
      LoggerService.error(e.toString());
    }
  }

  void selectVoucher(
    PendingPaymentDropdownModel voucher, {
    bool force = false,
  }) {
    if (isEdit.value && !force) return;
    double pending = voucher.balanceAmount;
    double paid = voucher.paidAmount;

    // If editing and this is the original voucher, restore its previous state
    if (isEdit.value && voucher.id == initialVoucherId.value) {
      final args = Get.arguments;
      if (args is PosPaymentModel) {
        pending += (args.amount + args.kasar);
        paid -= (args.amount + args.kasar);
      }
    }

    selectedVoucher.value = PaymentItem(
      voucherId: voucher.id,
      voucherNo: voucher.docNo,
      docType: voucher.docType,
      totalAmount: pending + paid,
      paidAmount: paid,
      pendingAmount: pending,
      amount: pending,
      kasarAmount: 0,
    );
    amountSettleController.text = pending.toString();
    kasarSettleController.text = "0";
    _calculateTotalAmount();
  }

  void removeSelectedVoucher() {
    selectedVoucher.value = null;
    _calculateTotalAmount();
  }

  void onAmountChanged(String value) {
    final amount = double.tryParse(value) ?? 0;
    if (selectedVoucher.value != null) {
      selectedVoucher.value = selectedVoucher.value!.copyWith(amount: amount);
      _calculateTotalAmount();
    }
  }

  void onKasarChanged(String value) {
    final kasar = double.tryParse(value) ?? 0;
    if (selectedVoucher.value != null) {
      selectedVoucher.value = selectedVoucher.value!.copyWith(
        kasarAmount: kasar,
      );
      _calculateTotalAmount();
    }
  }

  void _calculateTotalAmount() {
    if (paymentType.value == 'against_bill') {
      final amount = selectedVoucher.value?.amount ?? 0;
      amountController.text = amount.toStringAsFixed(2);
    }
  }

  double get remainingAmount {
    if (selectedVoucher.value == null) return 0;
    final pending = selectedVoucher.value!.pendingAmount;
    final settle = selectedVoucher.value!.amount;
    final kasar = selectedVoucher.value!.kasarAmount;
    return pending - settle - kasar;
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
        "remark": descriptionController.text,
        "isActive": isActive.value,
        "paymentMode": selectedPaymentMode.value,
        "posCashRegisterId": isBankRelated(selectedPaymentMode.value)
            ? selectedBank.value?.id ?? ""
            : (_originalRegisterId ?? ""),
        if (paymentType.value == 'against_bill' &&
            selectedVoucher.value != null) ...{
          if (selectedVoucher.value!.docType == 'POS_ORDER')
            "posOrderId": selectedVoucher.value!.voucherId
          else if (selectedVoucher.value!.docType == 'SUPPLIER_BILL')
            "purchaseBillId": selectedVoucher.value!.voucherId
          else if (selectedVoucher.value!.docType == 'POS_CREDIT_NOTE')
            "posCreditNoteId": selectedVoucher.value!.voucherId
          else if (selectedVoucher.value!.docType == 'INVOICE')
            "invoiceId": selectedVoucher.value!.voucherId
          else if (selectedVoucher.value!.docType == 'SALES_CREDIT_NOTE')
            "salesCreditNoteId": selectedVoucher.value!.voucherId,
          "totalAmount": selectedVoucher.value!.totalAmount,
          "paidAmount": selectedVoucher.value!.paidAmount,
          "pendingAmount": selectedVoucher.value!.pendingAmount,
          "kasar": selectedVoucher.value!.kasarAmount,
        },
      };

      if (isEdit.value) {
        await _paymentRepository.updatePosPayment(data);
      } else {
        await _paymentRepository.addPosPayment(data);
      }
      _refreshAndBack();
      AppSnackbar.success('$label saved successfully');
    } catch (e) {
      AppSnackbar.error('Error saving payment: $e');
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (voucherType.value == VoucherType.sales) {
      if (Get.isRegistered<ReceiptController>()) {
        ReceiptController.instance.refreshData();
      }
    } else {
      if (Get.isRegistered<PaymentController>()) {
        PaymentController.instance.refreshData();
      }
    }
    Get.back();
  }
}

class PaymentItem {
  final String voucherId;
  final String voucherNo;
  final String docType;
  final double totalAmount;
  final double paidAmount;
  final double pendingAmount;
  final double amount;
  final double kasarAmount;

  PaymentItem({
    required this.voucherId,
    required this.voucherNo,
    required this.docType,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    required this.amount,
    required this.kasarAmount,
  });

  PaymentItem copyWith({
    double? amount,
    double? kasarAmount,
    double? pendingAmount,
    double? paidAmount,
  }) {
    return PaymentItem(
      voucherId: voucherId,
      voucherNo: voucherNo,
      docType: docType,
      totalAmount: totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      pendingAmount: pendingAmount ?? this.pendingAmount,
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
