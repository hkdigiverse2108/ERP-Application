import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:ai_setu/data/repositories/settings/terms_and_condition_repository.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/controllers/supplier_bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/purchase/purchase_repository.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class SupplierBillAddEditController extends GetxController {
  static SupplierBillAddEditController get instance => Get.find();

  final PurchaseRepository _purchaseRepository = PurchaseRepository();
  final ContactRepository _contactRepository = ContactRepository();
  final ProductRepository _productRepository = ProductRepository();
  final PaymentTermsRepository _paymentTermsRepository =
      PaymentTermsRepository();
  final TaxRepository _taxRepository = TaxRepository();
  final AdditionalChargeRepository _additionalChargeRepository =
      AdditionalChargeRepository();
  final TermsAndConditionRepository _termsAndConditionRepository =
      TermsAndConditionRepository();

  final formKey = GlobalKey<FormState>();

  // Reactive Variables
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isEdit = false.obs;
  final isAddingTerm = false.obs;
  final supplierBill = Rxn<SupplierBillModel>();

  // Dropdown Data
  final suppliers = <ContactDropdownModel>[].obs;
  final products = <ProductDropdownModel>[].obs;
  final paymentTerms = <PaymentTermsModel>[].obs;
  final taxes = <TaxDropdownModel>[].obs;
  final termsAndConditions = <TermsAndConditionModel>[].obs;
  final availableAdditionalCharges = <AdditionalChargeModel>[].obs;

  // Form Fields
  final selectedSupplier = Rxn<ContactDropdownModel>();
  final billDate = DateTime.now().obs;
  final dueDate = DateTime.now().obs;
  final shippingDate = Rxn<DateTime>();
  final selectedPaymentTerm = Rxn<PaymentTermsModel>();
  final selectedTerms = <TermsAndConditionModel>[].obs;
  final reverseCharge = "No".obs; // Yes/No
  final taxType = TaxType.defaultType.obs;
  final placeOfSupply = "".obs;
  final gstIn = "".obs;
  final billingAddressLine = "".obs;
  final selectedBillingAddress = Rxn<ContactAddress>();
  final selectedShippingAddress = Rxn<ContactAddress>();

  final billNoController = TextEditingController();
  final referenceBillNoController = TextEditingController();
  final notesController = TextEditingController();
  final invoiceAmountController = TextEditingController();
  final flatDiscountController = TextEditingController(text: "0");
  final roundOffController = TextEditingController(text: "0");

  // Item Tables
  final billItems = <SupplierBillItem>[].obs;
  final returnItems = <ReturnItem>[].obs;
  final additionalCharges = <AdditionalCharge>[].obs;

  // Summary Totals
  final grossAmount = 0.0.obs;
  final totalDiscount = 0.0.obs;
  final taxableAmount = 0.0.obs;
  final totalTaxAmount = 0.0.obs;
  final netAmount = 0.0.obs;

  // Return Summary
  final returnGrossAmount = 0.0.obs;
  final returnTaxableAmount = 0.0.obs;
  final returnTotalTaxAmount = 0.0.obs;
  final returnNetAmount = 0.0.obs;
  final flatDiscountValue = 0.0.obs;
  final roundOffValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    final args = Get.arguments;
    if (args is SupplierBillModel) {
      supplierBill.value = args;
      isEdit.value = true;
      _populateFields();
    } else if (args is String) {
      isEdit.value = true;
      _fetchSupplierBillDetails(args);
    }

    // Listener for supplier change to update address/GST info
    ever(selectedSupplier, (supplier) {
      if (supplier != null) {
        _fetchSupplierDetails(supplier.id);
        if (supplier.address.isNotEmpty) {
          selectedBillingAddress.value = supplier.address.first;
          selectedShippingAddress.value = supplier.address.first;
        } else {
          selectedBillingAddress.value = null;
          selectedShippingAddress.value = null;
        }
      }
    });
  }

  Future<void> _fetchSupplierDetails(String id) async {
    try {
      final contact = await _contactRepository.getContactById(id);
      gstIn.value = contact.address.isNotEmpty
          ? (contact.address.first.gstIn ?? "")
          : "";
      if (contact.address.isNotEmpty) {
        final addr = contact.address.first;
        billingAddressLine.value =
            "${addr.addressLine1}, ${addr.city?.name}, ${addr.state?.name}";
        placeOfSupply.value = addr.state?.name ?? "";
      }
    } catch (e) {
      debugPrint('Error fetching supplier details: $e');
    }
  }

  Future<void> _loadInitialData() async {
    try {
      isLoading.value = true;

      // Use individual try-catch for each call to prevent one failure from blocking all
      await Future.wait([
        _safeLoad(() async {
          final res = await _contactRepository.getContactDropdown(
            typeFilter: 'supplier',
          );
          suppliers.assignAll(res);
        }, "Suppliers"),
        _safeLoad(() async {
          final res = await _productRepository.getProductDropdown();
          products.assignAll(res);
        }, "Products"),
        _safeLoad(() async {
          final res = await _paymentTermsRepository.getPaymentTerms(limit: 100);
          paymentTerms.assignAll(res.items);
        }, "Payment Terms"),
        _safeLoad(() async {
          final res = await _taxRepository.getTaxes();
          taxes.assignAll(res);
        }, "Taxes"),
        _safeLoad(() async {
          final res = await _additionalChargeRepository.getAdditionalCharges(
            limit: 100,
          );
          availableAdditionalCharges.assignAll(res.items);
        }, "Additional Charges"),
        _safeLoad(() async {
          final res = await _termsAndConditionRepository.getTermsAndCondition();
          termsAndConditions.assignAll(res);
          if (!isEdit.value) {
            selectedTerms.assignAll(res.where((t) => t.isDefault).toList());
          }
        }, "Terms & Conditions"),
      ]);

      debugPrint(
        'Initial data load complete: ${suppliers.length} suppliers, ${products.length} products, ${termsAndConditions.length} T&Cs',
      );
    } catch (e) {
      debugPrint('Unexpected error in _loadInitialData: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _safeLoad(Future<void> Function() call, String label) async {
    try {
      await call();
    } catch (e) {
      debugPrint('Error loading $label: $e');
      // If it's a critical failure (Suppliers or Products), we notify the user more strongly
      if (label == "Suppliers" || label == "Products") {
        AppSnackbar.error(
          'Failed to load $label. You may not be able to save the bill.',
          position: SnackPosition.BOTTOM,
        );
      } else {
        // Non-critical failures just log and show a quiet notification
        debugPrint('Non-critical load failed for $label: $e');
      }
    }
  }

  Future<void> _fetchSupplierBillDetails(String id) async {
    try {
      isLoading.value = true;
      final bill = await _purchaseRepository.getSupplierBillById(id);
      supplierBill.value = bill;
      _populateFields();
    } catch (e) {
      debugPrint('Error fetching bill details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    final bill = supplierBill.value;
    if (bill == null) return;

    billNoController.text = bill.supplierBillNo ?? '';
    referenceBillNoController.text = bill.referenceBillNo ?? '';
    billDate.value = bill.supplierBillDate ?? DateTime.now();
    dueDate.value = bill.dueDate ?? DateTime.now();
    shippingDate.value = bill.shippingDate;
    notesController.text = bill.notes ?? '';
    reverseCharge.value = bill.reverseCharge ? "Yes" : "No";
    taxType.value = TaxType.values.firstWhere(
      (e) => e.label == (bill.taxType ?? "Tax Exclusive"),
      orElse: () => TaxType.exclusive,
    );
    placeOfSupply.value = bill.placeOfSupply ?? "";
    gstIn.value = bill.gstIn ?? "";
    invoiceAmountController.text = bill.invoiceAmount ?? "";
    flatDiscountController.text = bill.summary?.flatDiscount.toString() ?? "0";
    roundOffController.text = bill.summary?.roundOff.toString() ?? "0";

    ever(suppliers, (allSuppliers) {
      final supplier = allSuppliers.firstWhereOrNull(
        (s) => s.id == bill.supplierId?.id,
      );
      if (supplier != null) {
        selectedSupplier.value = supplier;
        final billingId = bill.billingAddress?.id;
        final shippingId = bill.shippingAddress?.id;

        if (billingId != null) {
          selectedBillingAddress.value = supplier.address.firstWhereOrNull(
            (a) => a.id == billingId,
          );
        }
        if (shippingId != null) {
          selectedShippingAddress.value = supplier.address.firstWhereOrNull(
            (a) => a.id == shippingId,
          );
        }
      }
    });

    // Wait for dropdowns to load before setting selected values
    ever(suppliers, (_) {
      if (bill.supplierId != null) {
        selectedSupplier.value = suppliers.firstWhereOrNull(
          (s) => s.id == bill.supplierId?.id,
        );
      }
    });

    ever(paymentTerms, (_) {
      if (bill.paymentTermsId != null) {
        selectedPaymentTerm.value = paymentTerms.firstWhereOrNull(
          (p) => p.id == bill.paymentTermsId?.id,
        );
      }
    });

    ever(termsAndConditions, (_) {
      if (bill.termsAndConditionIds.isNotEmpty) {
        final ids = bill.termsAndConditionIds.map((e) => e.id).toSet();
        selectedTerms.assignAll(
          termsAndConditions.where((t) => ids.contains(t.id.toString())),
        );
      }
    });

    // Populate Items
    if (bill.productDetails != null && bill.productDetails is List) {
      billItems.assignAll(
        (bill.productDetails as List).map((e) {
          final prodId = e['productId'] is Map
              ? (e['productId']['_id'] ?? '')
              : (e['productId'] ?? '');
          final prodName = e['productId'] is Map
              ? (e['productId']['name'] ?? '')
              : (e['productName'] ?? '');
          final variantId = e['variantId'];
          return SupplierBillItem(
            productId: prodId,
            productName: prodName,
            qty: (e['qty'] ?? e['quantity'] ?? 0).toDouble(),
            freeQty: (e['freeQty'] ?? 0).toDouble(),
            mrp: (e['mrp'] ?? 0).toDouble(),
            unitCost: (e['unitCost'] ?? 0).toDouble(),
            sellingPrice: (e['sellingPrice'] ?? 0).toDouble(),
            discountAmount: (e['discountAmount'] ?? 0).toDouble(),
            taxId: e['taxId'] is Map ? e['taxId']['_id'] : e['taxId'],
            taxPercent: (e['taxPercentage'] ?? 0).toDouble(),
            uomId: e['uomId'] is Map ? e['uomId']['_id'] : e['uomId'],
            unit: e['uomId'] is Map ? e['uomId']['name'] : e['unit'],
            variantId: variantId,
          );
        }).toList(),
      );
    }

    // Populate Returns
    if (bill.returnProductDetails != null &&
        bill.returnProductDetails!.item.isNotEmpty) {
      returnItems.assignAll(
        bill.returnProductDetails!.item.map((e) {
          return ReturnItem(
            productId: e.productId?.id ?? '',
            productName: e.productId?.name ?? '',
            qty: e.qty,
            unitCost: e.unitCost,
            discountAmount: e.discount1,
            taxId: e.taxId?.id,
            taxPercent: e.taxId?.percentage ?? 0,
            uomId: e.uomId?.id,
            unit: e.uomId?.name,
          );
        }).toList(),
      );
    }

    // Populate Additional Charges
    if (bill.additionalCharges != null && bill.additionalCharges is List) {
      additionalCharges.assignAll(
        (bill.additionalCharges as List).map((e) {
          return AdditionalCharge(
            id: e['id'] ?? '',
            name: e['name'] ?? '',
            amount: (e['amount'] ?? 0).toDouble(),
            taxId: e['taxId'],
            taxPercent: (e['taxPercentage'] ?? 0).toDouble(),
          );
        }).toList(),
      );
    }

    calculateTotals();
  }

  // Item Management
  Future<void> addBillItem(ProductDropdownModel product) async {
    // Prevent adding the same product multiple times if needed,
    // or just allow multiple entries of the same product.
    // For now, let's allow it as it's common in purchase bills.

    try {
      final productDetails = await _productRepository.getProductById(
        (product.hasVariant ? product.productId! : product.id),
        variantId: product.hasVariant ? product.id : null,
      );

      final newItem = SupplierBillItem(
        productId: product.hasVariant ? product.productId! : product.id,
        productName: productDetails.name,
        qty: 1.0,
        unitCost: productDetails.purchasePrice.toDouble(),
        mrp: productDetails.mrp.toDouble(),
        sellingPrice: productDetails.sellingPrice.toDouble(),
        taxId: productDetails.purchaseTaxId?.id,
        taxPercent: productDetails.purchaseTaxId?.percentage.toDouble() ?? 0.0,
        uomId: product.uomId?.id,
        unit: product.uomId?.name,
        variantId: product.hasVariant ? product.id : null,
      );

      billItems.add(newItem);
      calculateTotals();
    } catch (e) {
      debugPrint('Error adding item: $e');
      // Fallback if full details fail but we have dropdown info
      final newItem = SupplierBillItem(
        productId: product.hasVariant ? product.productId! : product.id,
        productName: product.name,
        qty: 1.0,
        unitCost: product.purchasePrice,
        mrp: product.mrp,
        sellingPrice: product.sellingPrice,
        taxId: product.purchaseTaxId?.id,
        taxPercent: product.purchaseTaxId?.percentage.toDouble() ?? 0.0,
        uomId: product.uomId?.id,
        unit: product.uomId?.name,
        variantId: product.hasVariant ? product.id : null,
      );
      billItems.add(newItem);
      calculateTotals();
    }
  }

  void removeBillItem(int index) {
    billItems.removeAt(index);
    calculateTotals();
  }

  // Return Item Management
  Future<void> addReturnItem(ProductDropdownModel product) async {
    try {
      final productDetails = await _productRepository.getProductById(
        product.id,
      );

      final newItem = ReturnItem(
        productId: product.id,
        productName: productDetails.name,
        qty: 1.0,
        unitCost: productDetails.purchasePrice.toDouble(),
        taxId: productDetails.purchaseTaxId?.id,
        taxPercent: productDetails.purchaseTaxId?.percentage.toDouble() ?? 0.0,
        uomId: productDetails.uomId?.id,
        unit: productDetails.uomId?.name,
      );

      returnItems.add(newItem);
      calculateTotals();
    } catch (e) {
      debugPrint('Error adding return item: $e');
      final newItem = ReturnItem(
        productId: product.id,
        productName: product.name,
        qty: 1.0,
        unitCost: product.purchasePrice,
        taxId: product.purchaseTaxId?.id,
        taxPercent: product.purchaseTaxId?.percentage.toDouble() ?? 0.0,
      );
      returnItems.add(newItem);
      calculateTotals();
    }
  }

  void removeReturnItem(int index) {
    returnItems.removeAt(index);
    calculateTotals();
  }

  void updateReturnItemQty(int index, double qty) {
    returnItems[index] = returnItems[index].copyWith(qty: qty);
    calculateTotals();
  }

  void updateReturnItemPrice(int index, double price) {
    returnItems[index] = returnItems[index].copyWith(unitCost: price);
    calculateTotals();
  }

  void updateReturnItemDiscount(int index, double discount) {
    returnItems[index] = returnItems[index].copyWith(discountAmount: discount);
    calculateTotals();
  }

  // Terms Management
  void toggleTerm(TermsAndConditionModel term) {
    if (selectedTerms.any((e) => e.id == term.id)) {
      selectedTerms.removeWhere((e) => e.id == term.id);
    } else {
      selectedTerms.add(term);
    }
  }

  bool isTermSelected(String id) {
    return selectedTerms.any((e) => e.id == id);
  }

  Future<void> addNewTerm(String text, bool isDefault) async {
    try {
      isAddingTerm.value = true;
      final branchId = BranchController.to.selectedBranch.value?.id;
      final res = await _termsAndConditionRepository.addTermsAndCondition({
        "termsCondition": text,
        "isDefault": isDefault,
        "branchId": branchId,
      });

      if (res.status == 200 || res.status == 201) {
        Get.back(); // close dialog
        AppSnackbar.success('Terms & Condition added successfully');
        // reload terms
        final updatedTerms = await _termsAndConditionRepository
            .getTermsAndCondition();
        termsAndConditions.assignAll(updatedTerms);

        // Auto-select the newly added term if it's default
        if (isDefault) {
          final newTerm = updatedTerms.firstWhereOrNull(
            (t) => t.termsCondition == text,
          );
          if (newTerm != null && !isTermSelected(newTerm.id)) {
            selectedTerms.add(newTerm);
          }
        }
      } else {
        AppSnackbar.error(res.message ?? 'Failed to add term');
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isAddingTerm.value = false;
    }
  }

  void updateItemQty(int index, double qty) {
    billItems[index] = billItems[index].copyWith(qty: qty);
    calculateTotals();
  }

  void updateItemPrice(int index, double price) {
    billItems[index] = billItems[index].copyWith(unitCost: price);
    calculateTotals();
  }

  void updateItemDiscount(int index, double discount) {
    billItems[index] = billItems[index].copyWith(discountAmount: discount);
    calculateTotals();
  }

  // Additional Charges Management
  void addAdditionalCharge() {
    additionalCharges.add(
      AdditionalCharge(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: "New Charge",
        amount: 0.0,
      ),
    );
    calculateTotals();
  }

  void removeAdditionalCharge(int index) {
    additionalCharges.removeAt(index);
    calculateTotals();
  }

  void updateAdditionalChargeSelection(
    int index,
    AdditionalChargeModel? charge,
  ) {
    if (charge == null) return;

    // Find matching tax model from controller.taxes
    final matchingTax = taxes.firstWhereOrNull((t) => t.id == charge.taxId.id);

    additionalCharges[index] = additionalCharges[index].copyWith(
      name: charge.name,
      amount: charge.defaultValue.toDouble(),
      taxId: matchingTax?.id,
      taxPercent: matchingTax?.percentage.toDouble() ?? 0.0,
    );
    calculateTotals();
  }

  void updateAdditionalChargeAmount(int index, double amount) {
    additionalCharges[index] = additionalCharges[index].copyWith(
      amount: amount,
    );
    calculateTotals();
  }

  void updateAdditionalChargeTax(int index, TaxDropdownModel? tax) {
    additionalCharges[index] = additionalCharges[index].copyWith(
      taxId: tax?.id,
      taxPercent: tax?.percentage.toDouble() ?? 0.0,
    );
    calculateTotals();
  }

  void calculateTotals() {
    double gross = 0;
    double tax = 0;
    double discount = 0;

    for (var item in billItems) {
      final lineTotal = item.qty * item.unitCost;
      final lineDiscount = item.discountAmount;
      final lineBase = lineTotal - lineDiscount;

      double lineTaxable = lineBase;
      double lineTax = 0;

      if (taxType.value == TaxType.inclusive) {
        // Amount = Taxable + (Taxable * Tax%)
        // Amount = Taxable * (1 + Tax%)
        // Taxable = Amount / (1 + Tax%)
        lineTaxable = lineBase / (1 + (item.taxPercent / 100));
        lineTax = lineBase - lineTaxable;
      } else if (taxType.value == TaxType.exclusive ||
          taxType.value == TaxType.defaultType) {
        lineTaxable = lineBase;
        lineTax = (lineTaxable * item.taxPercent) / 100;
      } else if (taxType.value == TaxType.outOfScope) {
        lineTaxable = lineBase;
        lineTax = 0;
      }

      gross += lineTotal;
      discount += lineDiscount;
      tax += lineTax;
    }

    // Returns (Subtract from totals)
    double retGross = 0;
    double retTaxable = 0;
    double retTax = 0;
    for (var item in returnItems) {
      retGross += item.qty * item.unitCost;
      retTaxable += item.taxable;
      retTax += item.tax;
    }
    returnGrossAmount.value = retGross;
    returnTaxableAmount.value = retTaxable;
    returnTotalTaxAmount.value = retTax;
    returnNetAmount.value = retTaxable + retTax;

    final double returnTaxable = retTaxable;
    final double returnTax = retTax;

    grossAmount.value = gross;
    totalDiscount.value = discount;

    // Additional Charges
    double extraChargeTax = 0;
    for (var charge in additionalCharges) {
      gross += charge.amount;
      extraChargeTax += (charge.amount * charge.taxPercent) / 100;
    }
    tax += extraChargeTax;

    taxableAmount.value = gross - discount;
    totalTaxAmount.value = tax;

    flatDiscountValue.value = double.tryParse(flatDiscountController.text) ?? 0;
    roundOffValue.value = double.tryParse(roundOffController.text) ?? 0;

    final rawNet =
        (taxableAmount.value + totalTaxAmount.value) -
        returnTaxable -
        returnTax -
        flatDiscountValue.value +
        roundOffValue.value;

    netAmount.value = rawNet < 0 ? 0 : rawNet;

    // Auto-update invoice amount if it's empty or zero
    if (invoiceAmountController.text.isEmpty ||
        invoiceAmountController.text == "0") {
      invoiceAmountController.text = netAmount.value.toStringAsFixed(2);
    }
  }

  Future<void> saveBill() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isSaving.value = true;
      final taxTypeMap = {
        TaxType.exclusive: "tax_exclusive",
        TaxType.inclusive: "tax_inclusive",
        TaxType.defaultType: "default",
        TaxType.outOfScope: "out_of_scope",
      };

      final data = {
        'branchId': BranchController.to.selectedBranch.value?.id,
        'supplierId': selectedSupplier.value?.id,
        // 'supplierBillNo': billNoController.text,
        'referenceBillNo': referenceBillNoController.text,
        'supplierBillDate': billDate.value.toIso8601String(),
        'dueDate': dueDate.value.toIso8601String(),
        if (shippingDate.value != null)
          'shippingDate': shippingDate.value!.toIso8601String(),
        'paymentTermsId': selectedPaymentTerm.value?.id,
        'billingAddress': selectedBillingAddress.value?.id,
        // 'shippingAddress': selectedShippingAddress.value?.id,
        'reverseCharge': (reverseCharge.value == "Yes").toString(),
        'taxType': taxTypeMap[taxType.value] ?? "tax_exclusive",
        'placeOfSupply': placeOfSupply.value,
        'invoiceAmount': invoiceAmountController.text,
        'notes': notesController.text,
        'productDetails': billItems.map((e) => e.toMap()).toList(),
        'returnProductDetails': {
          'item': returnItems.map((e) => e.toMap()).toList(),
          'summary': {
            'roundOff': 0.0,
            'grossAmount': returnGrossAmount.value,
            'taxAmount': returnTotalTaxAmount.value,
            'netAmount': returnNetAmount.value,
          },
        },
        'termsAndConditionIds': selectedTerms.map((e) => e.id).toList(),
        'additionalCharges': additionalCharges.map((e) => e.toMap()).toList(),
        'summary': {
          'flatDiscount': flatDiscountValue.value,
          'grossAmount': grossAmount.value,
          'discountAmount': totalDiscount.value,
          'taxableAmount': taxableAmount.value,
          'taxAmount': totalTaxAmount.value,
          'roundOff': roundOffValue.value,
          'netAmount': netAmount.value,
        },
        'paidAmount': 0,
        'balanceAmount': 0,
        'paymentStatus': "unpaid",
        'status': "active",
        'isActive': true,
      };

      dynamic result;
      if (supplierBill.value == null) {
        result = await _purchaseRepository.addSupplierBill(data);
      } else {
        data['supplierBillId'] = supplierBill.value!.id;
        result = await _purchaseRepository.updateSupplierBill(data);
      }

      if (result != null) {
        await _refreshAndBack();
        AppSnackbar.success('Supplier Bill saved successfully');
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> _refreshAndBack() async {
    final supplierBillController = Get.isRegistered<SupplierBillController>()
        ? Get.find<SupplierBillController>()
        : null;

    if (supplierBillController != null) {
      await supplierBillController.refreshData();
    }
    Get.back(result: true);
  }
}

class SupplierBillItem {
  final String productId;
  final String productName;
  final double qty;
  final double freeQty;
  final double mrp;
  final double unitCost;
  final double sellingPrice;
  final double discountAmount;
  final String? taxId;
  final double taxPercent;
  final String? uomId;
  final String? unit;
  final String? variantId;

  SupplierBillItem({
    required this.productId,
    required this.productName,
    required this.qty,
    this.freeQty = 0,
    this.mrp = 0,
    required this.unitCost,
    this.sellingPrice = 0,
    this.discountAmount = 0,
    this.taxId,
    this.taxPercent = 0,
    this.uomId,
    this.unit,
    this.variantId,
  });

  double get taxable => (qty * unitCost) - discountAmount;
  double get tax => taxable * (taxPercent / 100);
  double get landingPrice => (taxable + tax) / (qty > 0 ? qty : 1);
  double get margin => sellingPrice - landingPrice;
  double get total => taxable + tax;
  bool get isVarient => variantId != null;

  SupplierBillItem copyWith({
    double? qty,
    double? freeQty,
    double? mrp,
    double? unitCost,
    double? sellingPrice,
    double? discountAmount,
    String? uomId,
    String? unit,
    String? variantId,
  }) {
    return SupplierBillItem(
      productId: productId,
      productName: productName,
      qty: qty ?? this.qty,
      freeQty: freeQty ?? this.freeQty,
      mrp: mrp ?? this.mrp,
      unitCost: unitCost ?? this.unitCost,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      taxId: taxId,
      taxPercent: taxPercent,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
      variantId: variantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'qty': qty,
      'freeQty': freeQty,
      'mrp': mrp,
      'unitCost': unitCost,
      'sellingPrice': sellingPrice,
      'discount1': discountAmount,
      'taxId': taxId,
      'uomId': uomId,
      'unit': unit,
      'taxable': taxable,
      'tax': tax % 1 == 0 ? tax.toInt().toString() : tax.toStringAsFixed(2),
      'landingCost': landingPrice,
      'margin': margin,
      'total': total,
      'variantId': variantId,
    };
  }
}

class AdditionalCharge {
  final String id;
  final String name;
  final double amount;
  final String? taxId;
  final double taxPercent;

  AdditionalCharge({
    required this.id,
    required this.name,
    required this.amount,
    this.taxId,
    this.taxPercent = 0,
  });

  AdditionalCharge copyWith({
    String? id,
    String? name,
    double? amount,
    String? taxId,
    double? taxPercent,
  }) {
    return AdditionalCharge(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      taxId: taxId ?? this.taxId,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'amount': amount,
    'taxId': taxId,
    'total': amount + (amount * taxPercent / 100),
  };
}

class ReturnItem {
  final String productId;
  final String productName;
  final double qty;
  final double unitCost;
  final double discountAmount;
  final String? taxId;
  final double taxPercent;
  final String? uomId;
  final String? unit;

  ReturnItem({
    required this.productId,
    required this.productName,
    required this.qty,
    required this.unitCost,
    this.discountAmount = 0,
    this.taxId,
    this.taxPercent = 0,
    this.uomId,
    this.unit,
  });

  double get taxable => (qty * unitCost) - discountAmount;
  double get tax => taxable * (taxPercent / 100);
  double get total => taxable + tax;

  ReturnItem copyWith({
    double? qty,
    double? unitCost,
    double? discountAmount,
    String? uomId,
    String? unit,
  }) {
    return ReturnItem(
      productId: productId,
      productName: productName,
      qty: qty ?? this.qty,
      unitCost: unitCost ?? this.unitCost,
      discountAmount: discountAmount ?? this.discountAmount,
      taxId: taxId,
      taxPercent: taxPercent,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() => {
    'productId': productId,
    'qty': qty,
    'unitCost': unitCost,
    'discount1': discountAmount,
    'taxId': taxId ?? "",
    'uomId': uomId,
    'unit': unit,
    'taxable': taxable,
    'tax': taxId == null || taxId!.isEmpty
        ? ""
        : (tax % 1 == 0 ? tax.toInt().toString() : tax.toStringAsFixed(2)),
    'landingCost': taxable + tax,
    'total': total,
  };
}
