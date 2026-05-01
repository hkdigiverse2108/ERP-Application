import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:ai_setu/data/repositories/settings/terms_and_condition_repository.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/purchase/purchase_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:get/get.dart';

class PurchaseOrderAddEditController extends GetxController {
  static PurchaseOrderAddEditController get instance => Get.find();

  final PurchaseRepository _purchaseRepository = PurchaseRepository();
  final ContactRepository _contactRepository = ContactRepository();
  final ProductRepository _productRepository = ProductRepository();
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
  final purchaseOrder = Rxn<PurchaseOrderModel>();

  // Dropdown Data
  final suppliers = <ContactDropdownModel>[].obs;
  final products = <ProductDropdownModel>[].obs;
  final taxes = <TaxDropdownModel>[].obs;
  final termsAndConditions = <TermsAndConditionModel>[].obs;
  final availableAdditionalCharges = <AdditionalChargeModel>[].obs;

  // Form Fields
  final selectedSupplier = Rxn<ContactDropdownModel>();
  final orderDate = DateTime.now().obs;
  final shippingDate = Rxn<DateTime>();
  final selectedTerms = <TermsAndConditionModel>[].obs;
  final taxType = TaxType.defaultType.obs;
  final placeOfSupply = "".obs;
  final gstIn = "".obs;
  final billingAddressLine = "".obs;
  final selectedBillingAddress = Rxn<ContactAddress>();
  final selectedShippingAddress = Rxn<ContactAddress>();

  final orderNoController = TextEditingController();
  final referenceNoController =
      TextEditingController(); // Sometimes called shippingNote or similar
  final notesController = TextEditingController();
  final shippingNoteController = TextEditingController();
  final flatDiscountController = TextEditingController(text: "0");
  final roundOffController = TextEditingController(text: "0");

  // Item Tables
  final orderItems = <POItem>[].obs;
  final additionalCharges = <POAdditionalCharge>[].obs;

  // Summary Totals
  final grossAmount = 0.0.obs;
  final totalDiscount = 0.0.obs;
  final taxableAmount = 0.0.obs;
  final totalTaxAmount = 0.0.obs;
  final netAmount = 0.0.obs;
  final flatDiscountValue = 0.0.obs;
  final roundOffValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    final args = Get.arguments;
    if (args is PurchaseOrderModel) {
      purchaseOrder.value = args;
      isEdit.value = true;
      _populateFields();
    } else if (args is String) {
      isEdit.value = true;
      _fetchPurchaseOrderDetails(args);
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

    // Listeners for summary updates
    flatDiscountController.addListener(calculateTotals);
    roundOffController.addListener(calculateTotals);
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
        selectedBillingAddress.value = addr;
      }
    } catch (e) {
      debugPrint('Error fetching supplier details: $e');
    }
  }

  Future<void> _loadInitialData() async {
    try {
      isLoading.value = true;

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
    }
  }

  Future<void> _fetchPurchaseOrderDetails(String id) async {
    try {
      isLoading.value = true;
      final order = await _purchaseRepository.getPurchaseOrderById(id);
      purchaseOrder.value = order;
      _populateFields();
    } catch (e) {
      debugPrint('Error fetching PO details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    final order = purchaseOrder.value;
    if (order == null) return;

    orderNoController.text = order.orderNo ?? '';
    orderDate.value = order.orderDate ?? DateTime.now();
    shippingDate.value = order.shippingDate;
    notesController.text = order.notes ?? '';
    shippingNoteController.text = order.shippingNote ?? '';

    taxType.value = TaxType.values.firstWhere(
      (e) => e.label == (order.taxType ?? "Tax Exclusive"),
      orElse: () => TaxType.exclusive,
    );
    placeOfSupply.value = order.placeOfSupply ?? "";
    gstIn.value = order.gstIn ?? "";
    flatDiscountController.text = order.summary?.flatDiscount.toString() ?? "0";
    roundOffController.text = order.summary?.roundOff.toString() ?? "0";

    ever(suppliers, (allSuppliers) {
      final supplier =
          allSuppliers.firstWhereOrNull((s) => s.id == order.supplierId?.id);
      if (supplier != null) {
        selectedSupplier.value = supplier;
        final billingId = order.billingAddress?.id;
        final shippingId = order.shippingAddress?.id;

        if (billingId != null) {
          selectedBillingAddress.value =
              supplier.address.firstWhereOrNull((a) => a.id == billingId);
        }
        if (shippingId != null) {
          selectedShippingAddress.value =
              supplier.address.firstWhereOrNull((a) => a.id == shippingId);
        }
      }
    });

    // Wait for dropdowns to load before setting selected values
    ever(suppliers, (_) {
      if (order.supplierId != null) {
        selectedSupplier.value = suppliers.firstWhereOrNull(
          (s) => s.id == order.supplierId?.id,
        );
      }
    });

    ever(termsAndConditions, (_) {
      if (order.termsAndConditionIds.isNotEmpty) {
        final ids = order.termsAndConditionIds.map((e) => e.id).toSet();
        selectedTerms.assignAll(
          termsAndConditions.where((t) => ids.contains(t.id.toString())),
        );
      }
    });

    // Populate Items
    orderItems.assignAll(
      order.items.map((e) {
        return POItem(
          productId: e.productId?.id ?? '',
          productName: e.productId?.name ?? '',
          qty: e.qty,
          unitCost: e.unitCost,
          taxId: e.taxId?.id,
          taxPercent: e.taxId?.percentage ?? 0,
          uomId: e.uomId is Map ? e.uomId['_id'] : e.uomId?.toString(),
          unit: e.unit,
          mrp: e.mrp ?? 0.0,
          sellingPrice: e.sellingPrice ?? 0.0,
          landingCost: double.tryParse(e.landingCost ?? '0') ?? 0.0,
          margin: double.tryParse(e.margin ?? '0') ?? 0.0,
        );
      }).toList(),
    );

    calculateTotals();
  }

  // Item Management
  void addOrderItem(ProductDropdownModel product) async {
    try {
      final productDetails = await _productRepository.getProductById(
        product.id,
      );

      final newItem = POItem(
        productId: product.id,
        productName: productDetails.name,
        qty: 1.0,
        unitCost: productDetails.purchasePrice.toDouble(),
        taxId: productDetails.purchaseTaxId?.id,
        taxPercent: productDetails.purchaseTaxId?.percentage.toDouble() ?? 0.0,
        uomId: productDetails.uomId?.id,
        unit: productDetails.uomId?.name,
        mrp: productDetails.mrp.toDouble(),
        sellingPrice: productDetails.sellingPrice.toDouble(),
        landingCost: productDetails.landingCost.toDouble(),
        margin: productDetails.sellingMargin.toDouble(),
      );

      orderItems.add(newItem);
      calculateTotals();
    } catch (e) {
      debugPrint('Error adding PO item: $e');
    }
  }

  void removeOrderItem(int index) {
    orderItems.removeAt(index);
    calculateTotals();
  }

  void updateItemQty(int index, double qty) {
    orderItems[index] = orderItems[index].copyWith(qty: qty);
    calculateTotals();
  }

  void updateItemPrice(int index, double price) {
    orderItems[index] = orderItems[index].copyWith(unitCost: price);
    calculateTotals();
  }

  // Additional Charges Management
  void addAdditionalCharge() {
    additionalCharges.add(
      POAdditionalCharge(
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

  Future<void> addNewTerm(String termsCondition, bool isDefault) async {
    try {
      final res = await _termsAndConditionRepository.addTermsAndCondition({
        'termsCondition': termsCondition,
        'isDefault': isDefault,
        'isActive': true,
      });
      if (res.status == 200 && res.data != null) {
        final term = TermsAndConditionModel.fromMap(res.data);
        termsAndConditions.add(term);
        selectedTerms.add(term);
      }
    } catch (e) {
      debugPrint('Error adding new term: $e');
    }
  }

  void calculateTotals() {
    double gross = 0;
    double tax = 0;
    double discount = 0;

    for (var item in orderItems) {
      final lineTotal = item.qty * item.unitCost;
      final lineBase =
          lineTotal; // PO usually doesn't have per-line discount in the same way as bill, but we can add it if needed

      double lineTaxable = lineBase;
      double lineTax = 0;

      if (taxType.value == TaxType.inclusive) {
        lineTaxable = lineBase / (1 + (item.taxPercent / 100));
        lineTax = lineBase - lineTaxable;
      } else if (taxType.value == TaxType.exclusive ||
          taxType.value == TaxType.defaultType) {
        lineTaxable = lineBase;
        lineTax = (lineTaxable * item.taxPercent) / 100;
      }

      gross += lineTotal;
      tax += lineTax;
    }

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
        flatDiscountValue.value +
        roundOffValue.value;

    netAmount.value = rawNet < 0 ? 0 : rawNet;
  }

  Future<void> saveOrder() async {
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
        // 'orderNo': orderNoController.text,
        'orderDate': orderDate.value.toIso8601String(),
        if (shippingDate.value != null)
          'shippingDate': shippingDate.value!.toIso8601String(),
        'shippingNote': shippingNoteController.text,
        'taxType': taxTypeMap[taxType.value] ?? "tax_exclusive",
        'placeOfSupply': placeOfSupply.value,
        'billingAddress': selectedBillingAddress.value?.id,
        'shippingAddress': selectedShippingAddress.value?.id,
        'notes': notesController.text,
        'items': orderItems.map((e) => e.toMap()).toList(),
        'termsAndConditionIds': selectedTerms.map((e) => e.id).toList(),
        // 'additionalCharges': additionalCharges.map((e) => e.toMap()).toList(),
        'summary': {
          'flatDiscount': flatDiscountValue.value,
          'grossAmount': grossAmount.value,
          'discountAmount': totalDiscount.value,
          'taxableAmount': taxableAmount.value,
          'taxAmount': totalTaxAmount.value,
          'roundOff': roundOffValue.value,
          'netAmount': netAmount.value,
        },
        'status': "in_progress",
        'isActive': true,
      };

      dynamic result;
      if (purchaseOrder.value == null) {
        result = await _purchaseRepository.addPurchaseOrder(data);
      } else {
        data['id'] = purchaseOrder.value!.id;
        result = await _purchaseRepository.updatePurchaseOrder(data);
      }

      if (result != null) {
        Get.back(result: true);
        Get.snackbar('Success', 'Purchase Order saved successfully');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    orderNoController.dispose();
    referenceNoController.dispose();
    notesController.dispose();
    shippingNoteController.dispose();
    flatDiscountController.dispose();
    roundOffController.dispose();
    super.onClose();
  }
}

class POItem {
  final String productId;
  final String productName;
  final double qty;
  final double unitCost;
  final String? taxId;
  final double taxPercent;
  final String? uomId;
  final String? unit;
  final double mrp;
  final double sellingPrice;
  final double landingCost;
  final double margin;

  POItem({
    required this.productId,
    required this.productName,
    required this.qty,
    required this.unitCost,
    this.taxId,
    this.taxPercent = 0,
    this.uomId,
    this.unit,
    this.mrp = 0,
    this.sellingPrice = 0,
    this.landingCost = 0,
    this.margin = 0,
  });

  double get taxable => qty * unitCost;
  double get tax => taxable * (taxPercent / 100);
  double get total => taxable + tax;

  POItem copyWith({
    double? qty,
    double? unitCost,
    String? uomId,
    String? unit,
  }) {
    return POItem(
      productId: productId,
      productName: productName,
      qty: qty ?? this.qty,
      unitCost: unitCost ?? this.unitCost,
      taxId: taxId,
      taxPercent: taxPercent,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
      mrp: mrp,
      sellingPrice: sellingPrice,
      landingCost: landingCost,
      margin: margin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'qty': qty,
      'uomId': uomId,
      'unit': unit,
      // 'mrp': mrp,
      // 'sellingPrice': sellingPrice,
      'unitCost': unitCost,
      // 'discount1': 0, // Payload showed discount1: 0
      // 'taxable': taxable,
      'taxId': taxId ?? "",
      'tax': tax % 1 == 0 ? tax.toInt().toString() : tax.toStringAsFixed(2),
      'landingCost': landingCost % 1 == 0
          ? landingCost.toInt().toString()
          : landingCost.toStringAsFixed(2),
      'margin': margin % 1 == 0
          ? margin.toInt().toString()
          : margin.toStringAsFixed(2),
      'total': total,
    };
  }
}

class POAdditionalCharge {
  final String id;
  final String name;
  final double amount;
  final String? taxId;
  final double taxPercent;

  POAdditionalCharge({
    required this.id,
    required this.name,
    required this.amount,
    this.taxId,
    this.taxPercent = 0,
  });

  POAdditionalCharge copyWith({
    String? name,
    double? amount,
    String? taxId,
    double? taxPercent,
  }) {
    return POAdditionalCharge(
      id: id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      taxId: taxId ?? this.taxId,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'taxId': taxId,
      'total': amount + (amount * taxPercent / 100),
    };
  }
}
