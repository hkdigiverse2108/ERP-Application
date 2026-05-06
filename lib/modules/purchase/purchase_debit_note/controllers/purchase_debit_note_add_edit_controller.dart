import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:ai_setu/data/repositories/settings/terms_and_condition_repository.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_controller.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/purchase/purchase_debit_note_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/purchase/purchase_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class PurchaseDebitNoteAddEditController extends GetxController {
  static PurchaseDebitNoteAddEditController get instance => Get.find();

  final PurchaseRepository _purchaseRepository = PurchaseRepository();
  final ContactRepository _contactRepository = ContactRepository();
  final ProductRepository _productRepository = ProductRepository();
  final TaxRepository _taxRepository = TaxRepository();
  final AdditionalChargeRepository _additionalChargeRepository =
      AdditionalChargeRepository();
  final TermsAndConditionRepository _termsAndConditionRepository =
      TermsAndConditionRepository();
  final PaymentTermsRepository _paymentTermsRepository =
      PaymentTermsRepository();

  final formKey = GlobalKey<FormState>();

  // Reactive Variables
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isEdit = false.obs;
  final isAddingTerm = false.obs;
  final debitNote = Rxn<PurchaseDebitNoteModel>();

  // Dropdown Data
  final suppliers = <ContactDropdownModel>[].obs;
  final products = <ProductDropdownModel>[].obs;
  final taxes = <TaxDropdownModel>[].obs;
  final paymentTerms = <PaymentTermsModel>[].obs;
  final termsAndConditions = <TermsAndConditionModel>[].obs;
  final availableAdditionalCharges = <AdditionalChargeModel>[].obs;

  // Form Fields
  final selectedSupplier = Rxn<ContactDropdownModel>();
  final debitNoteDate = DateTime.now().obs;
  final dueDate = DateTime.now().obs;
  final shippingDate = Rxn<DateTime>();
  final selectedPaymentTerm = Rxn<PaymentTermsModel>();
  final selectedTerms = <TermsAndConditionModel>[].obs;
  final taxType = TaxType.defaultType.obs;
  final placeOfSupply = "".obs;
  final billingAddressLine = "".obs;
  final rxExportSez = "".obs;
  final rxPurchaseId = "".obs;
  final selectedBillingAddress = Rxn<ContactAddress>();
  final selectedShippingAddress = Rxn<ContactAddress>();
  final debitNoteNoController = TextEditingController();
  final referenceBillNoController = TextEditingController();
  final reasonController = TextEditingController();
  final notesController = TextEditingController();
  final flatDiscountController = TextEditingController(text: "0");
  final roundOffController = TextEditingController(text: "0");

  // Shipping Details Fields
  final transporters = <ContactDropdownModel>[].obs;
  final selectedTransporter = Rxn<ContactDropdownModel>();
  final shippingType = "delivery".obs;
  final transportDate = DateTime.now().obs;
  final shippingReferenceNoController = TextEditingController();
  final modeOfTransportController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final shippingWeightController = TextEditingController(text: "0");

  // Item Tables
  final items = <DebitNoteItem>[].obs;
  final additionalCharges = <DebitNoteAdditionalCharge>[].obs;

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
    if (args is PurchaseDebitNoteModel) {
      debitNote.value = args;
      isEdit.value = true;
      _populateFields();
    }

    // Listener for supplier change
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

    // Listeners for dropdown selections when editing
    ever(suppliers, (_) {
      if (debitNote.value?.supplierId != null) {
        selectedSupplier.value = suppliers.firstWhereOrNull(
          (s) => s.id == debitNote.value!.supplierId?.id,
        );
      }
    });

    ever(paymentTerms, (_) {
      if (debitNote.value?.paymentTermsId != null) {
        selectedPaymentTerm.value = paymentTerms.firstWhereOrNull(
          (p) => p.id == debitNote.value!.paymentTermsId?.id,
        );
      }
    });
  }

  Future<void> _loadInitialData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _contactRepository.getContactDropdown(
          typeFilter: ContactType.supplier.name,
        ),
        _productRepository.getProductDropdown(),
        _taxRepository.getTaxes(),
        _paymentTermsRepository.getPaymentTerms(limit: 100),
        _termsAndConditionRepository.getTermsAndCondition(),
        _additionalChargeRepository.getAdditionalCharges(limit: 100),
        _contactRepository.getContactDropdown(typeFilter: 'transporter'),
      ]);

      suppliers.value = results[0] as List<ContactDropdownModel>;
      products.value = results[1] as List<ProductDropdownModel>;
      taxes.value = results[2] as List<TaxDropdownModel>;
      paymentTerms.value =
          (results[3] as PaginationModel<PaymentTermsModel>).items;

      termsAndConditions.value = results[4] as List<TermsAndConditionModel>;

      final chargesRes = results[5] as PaginationModel<AdditionalChargeModel>;
      availableAdditionalCharges.value = chargesRes.items;
      transporters.value = results[6] as List<ContactDropdownModel>;
    } catch (e) {
      debugPrint('Error loading initial data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    final note = debitNote.value!;
    debitNoteNoController.text = note.debitNoteNo ?? '';
    debitNoteDate.value = note.debitNoteDate ?? DateTime.now();
    referenceBillNoController.text = note.referenceBillNo ?? '';
    reasonController.text = note.reason ?? '';
    notesController.text = note.notes ?? '';
    shippingDate.value = note.shippingDate;
    dueDate.value = note.dueDate ?? DateTime.now();
    placeOfSupply.value = note.placeOfSupply ?? '';
    rxExportSez.value = note.exportSez ?? '';
    rxPurchaseId.value = note.purchaseId ?? '';

    final billingId = note.billingAddress is String
        ? note.billingAddress
        : note.billingAddress?.id;
    final shippingId = note.shippingAddress is String
        ? note.shippingAddress
        : note.shippingAddress?.id;

    ever(suppliers, (allSuppliers) {
      final supplier = allSuppliers.firstWhereOrNull(
        (s) => s.id == note.supplierId?.id,
      );
      if (supplier != null) {
        selectedSupplier.value = supplier;
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

    // Items
    if (note.productDetails != null && note.productDetails is List) {
      items.value = (note.productDetails as List).map((e) {
        final prodId = e['productId'] is Map
            ? (e['productId']['_id']?.toString() ?? '')
            : (e['productId']?.toString() ?? '');
        final prodName = e['productId'] is Map
            ? (e['productId']['name']?.toString() ??
                  e['name']?.toString() ??
                  'Unknown')
            : (e['productName']?.toString() ??
                  e['name']?.toString() ??
                  e['productNameId']?.toString() ??
                  'Unknown');
        final taxId = e['taxId'] is Map
            ? (e['taxId']['_id']?.toString())
            : e['taxId']?.toString();
        final uomId = e['uomId'] is Map
            ? (e['uomId']['_id']?.toString())
            : e['uomId']?.toString();
        final unitName = e['uomId'] is Map
            ? (e['uomId']['name']?.toString())
            : e['unit']?.toString();

        return DebitNoteItem(
          productId: prodId,
          productName: prodName,
          qty: (e['qty'] as num?)?.toDouble() ?? 0,
          unitCost: (e['unitCost'] as num?)?.toDouble() ?? 0,
          mrp: (e['mrp'] as num?)?.toDouble() ?? 0,
          sellingPrice: (e['sellingPrice'] as num?)?.toDouble() ?? 0,
          discount1: (e['discount1'] as num?)?.toDouble() ?? 0,
          taxId: taxId,
          taxPercent: (e['taxPercent'] as num?)?.toDouble() ?? 0,
          uomId: uomId,
          unit: unitName,
        );
      }).toList();
    }

    // Additional Charges
    if (note.additionalCharges != null && note.additionalCharges is List) {
      additionalCharges.value = (note.additionalCharges as List).map((e) {
        final chargeId = e['chargeId'] is Map
            ? (e['chargeId']['_id']?.toString() ?? '')
            : (e['chargeId']?.toString() ?? '');
        final chargeName = e['chargeId'] is Map
            ? (e['chargeId']['name']?.toString() ?? 'Charge')
            : (e['chargeName']?.toString() ?? 'Charge');
        final taxId = e['taxId'] is Map
            ? (e['taxId']['_id']?.toString())
            : e['taxId']?.toString();

        return DebitNoteAdditionalCharge(
          id: chargeId,
          name: chargeName,
          amount: (e['amount'] as num?)?.toDouble() ?? 0,
          taxId: taxId,
          taxPercent: (e['taxPercent'] as num?)?.toDouble() ?? 0,
        );
      }).toList();
    }

    // Terms
    ever(termsAndConditions, (allTerms) {
      if (allTerms.isNotEmpty && note.termsAndConditionIds.isNotEmpty) {
        final ids = note.termsAndConditionIds.map((e) => e).toSet();
        selectedTerms.value = allTerms
            .where((t) => ids.contains(t.id))
            .toList();
      }
    });

    // Shipping Details
    if (note.shippingDetails != null) {
      final shipping = note.shippingDetails!;
      shippingType.value = shipping.shippingType ?? 'delivery';
      shippingDate.value = shipping.shippingDate;
      transportDate.value = shipping.transportDate ?? DateTime.now();
      shippingReferenceNoController.text = shipping.referenceNo ?? '';
      modeOfTransportController.text = shipping.modeOfTransport ?? '';
      vehicleNoController.text = shipping.vehicleNo ?? '';
      shippingWeightController.text = shipping.weight.toString();

      ever(transporters, (allTransporters) {
        if (shipping.transporterId != null) {
          selectedTransporter.value = allTransporters.firstWhereOrNull(
            (t) => t.id == shipping.transporterId,
          );
        }
      });
    }

    calculateTotals();
  }

  Future<void> _fetchSupplierDetails(String supplierId) async {
    try {
      final supplier = await _contactRepository.getContactById(supplierId);
      if (supplier.address.isNotEmpty) {
        final addr = supplier.address.first;
        selectedBillingAddress.value = addr;
        billingAddressLine.value = addr.addressLine1 ?? '';
      }
      placeOfSupply.value = supplier.address.isNotEmpty
          ? supplier.address.first.state?.name ?? ''
          : '';
    } catch (e) {
      debugPrint('Error fetching supplier details: $e');
    }
  }

  // Item Management
  void addItem(ProductDropdownModel product) async {
    try {
      final productDetails = await _productRepository.getProductById(
        product.id,
      );

      final newItem = DebitNoteItem(
        productId: product.id,
        productName: productDetails.name,
        qty: 1.0,
        unitCost: productDetails.purchasePrice.toDouble(),
        mrp: productDetails.mrp.toDouble(),
        sellingPrice: productDetails.sellingPrice.toDouble(),
        discount1: 0,
        taxId: productDetails.purchaseTaxId?.id,
        taxPercent: productDetails.purchaseTaxId?.percentage.toDouble() ?? 0.0,
        uomId: productDetails.uomId?.id,
        unit: productDetails.uomId?.name,
      );

      items.add(newItem);
      calculateTotals();
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  void removeItem(int index) {
    items.removeAt(index);
    calculateTotals();
  }

  void updateItemQty(int index, double qty) {
    items[index] = items[index].copyWith(qty: qty);
    calculateTotals();
  }

  void updateItemPrice(int index, double price) {
    items[index] = items[index].copyWith(unitCost: price);
    calculateTotals();
  }

  void updateItemMRP(int index, double mrp) {
    items[index] = items[index].copyWith(mrp: mrp);
    calculateTotals();
  }

  void updateItemSellingPrice(int index, double price) {
    items[index] = items[index].copyWith(sellingPrice: price);
    calculateTotals();
  }

  void updateItemDiscount(int index, double discount) {
    items[index] = items[index].copyWith(discount1: discount);
    calculateTotals();
  }

  // Additional Charges Management
  void addAdditionalCharge() {
    additionalCharges.add(
      DebitNoteAdditionalCharge(id: '', name: '', amount: 0),
    );
    calculateTotals();
  }

  void removeAdditionalCharge(int index) {
    additionalCharges.removeAt(index);
    calculateTotals();
  }

  void updateAdditionalCharge(int index, DebitNoteAdditionalCharge charge) {
    additionalCharges[index] = charge;
    calculateTotals();
  }

  // Totals Calculation
  void calculateTotals() {
    double gross = 0;
    double itemsTax = 0;
    double itemsDiscount = 0;
    double chargesTotal = 0;
    double chargesTax = 0;

    for (var item in items) {
      gross += item.qty * item.unitCost;
      itemsDiscount += item.discount1;
      itemsTax += item.tax;
    }

    for (var charge in additionalCharges) {
      chargesTotal += charge.amount;
      chargesTax += (charge.amount * charge.taxPercent) / 100;
    }

    grossAmount.value = gross;
    totalDiscount.value = itemsDiscount;
    taxableAmount.value = (gross - itemsDiscount) + chargesTotal;
    totalTaxAmount.value = itemsTax + chargesTax;

    flatDiscountValue.value = double.tryParse(flatDiscountController.text) ?? 0;
    roundOffValue.value = double.tryParse(roundOffController.text) ?? 0;

    final rawNet =
        (taxableAmount.value + totalTaxAmount.value) -
        flatDiscountValue.value +
        roundOffValue.value;

    netAmount.value = rawNet < 0 ? 0 : rawNet;
  }

  Future<void> saveDebitNote() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedSupplier.value == null) {
      AppSnackbar.error('Please select a supplier');
      return;
    }
    if (items.isEmpty) {
      AppSnackbar.error('Please add at least one item');
      return;
    }

    try {
      isSaving.value = true;
      final shippingDetails = {
        "shippingType": shippingType.value,
        "weight": double.tryParse(shippingWeightController.text) ?? 0,
        "referenceNo": shippingReferenceNoController.text,
        "transportDate": transportDate.value.toIso8601String(),
        "modeOfTransport": modeOfTransportController.text,
        "transporterId": selectedTransporter.value?.id,
        "vehicleNo": vehicleNoController.text,
      };

      if (shippingDate.value != null) {
        shippingDetails["shippingDate"] = shippingDate.value!.toIso8601String();
      }

      final data = {
        'supplierId': selectedSupplier.value?.id,
        'purchaseId': rxPurchaseId.value.isEmpty ? null : rxPurchaseId.value,
        'debitNoteDate': debitNoteDate.value.toIso8601String(),
        'dueDate': dueDate.value.toIso8601String(),
        'referenceBillNo': referenceBillNoController.text,
        'paymentTermsId': selectedPaymentTerm.value?.id,
        'billingAddress': selectedBillingAddress.value?.id,
        'shippingAddress': selectedShippingAddress.value?.id,
        'reverseCharge': false,
        'reason': reasonController.text,
        'exportSez': rxExportSez.value,
        'productDetails': items.map((e) => e.toMap()).toList(),
        'additionalCharges': additionalCharges.map((e) => e.toMap()).toList(),
        'shippingDetails': shippingDetails,
        'summary': {
          'flatDiscount': flatDiscountValue.value,
          'grossAmount': grossAmount.value,
          'discountAmount': totalDiscount.value,
          'taxableAmount': taxableAmount.value,
          'taxAmount': totalTaxAmount.value,
          'roundOff': roundOffValue.value,
          'netAmount': netAmount.value,
        },
        'termsAndConditionIds': selectedTerms.map((e) => e.id).toList(),
        // Internal/Extra fields
        'branchId': BranchController.to.selectedBranch.value?.id,
        'notes': notesController.text,
        'status': "open",
        'isActive': true,
      };

      if (shippingDate.value != null) {
        data['shippingDate'] = shippingDate.value!.toIso8601String();
      }

      dynamic result;
      if (debitNote.value == null) {
        result = await _purchaseRepository.addPurchaseDebitNote(data);
      } else {
        data['purchaseDebitNoteId'] = debitNote.value!.id;
        result = await _purchaseRepository.updatePurchaseDebitNote(data);
      }

      if (result != null) {
        await _refreshAndBack();
        AppSnackbar.success('Debit Note saved successfully');
      }
    } catch (e) {
      debugPrint('Error saving debit note: $e');
      AppSnackbar.error('Failed to save debit note');
    } finally {
      isSaving.value = false;
    }
  }

  bool isTermSelected(String id) => selectedTerms.any((t) => t.id == id);

  void toggleTerm(TermsAndConditionModel term) {
    if (isTermSelected(term.id)) {
      selectedTerms.removeWhere((t) => t.id == term.id);
    } else {
      selectedTerms.add(term);
    }
  }

  Future<void> addNewTerm(String title, String content) async {
    try {
      isAddingTerm.value = true;
      final res = await _termsAndConditionRepository.addTermsAndCondition({
        'termsCondition': content,
        'isActive': true,
      });

      if (res.status == 200 && res.data != null) {
        final newTerm = TermsAndConditionModel.fromMap(
          res.data as Map<String, dynamic>,
        );
        termsAndConditions.add(newTerm);
        selectedTerms.add(newTerm);
      }
    } catch (e) {
      debugPrint('Error adding new term: $e');
    } finally {
      isAddingTerm.value = false;
    }
  }

  Future<void> _refreshAndBack() async {
    final purchaseDebitNoteController =
        Get.isRegistered<PurchaseDebitNoteController>()
        ? Get.find<PurchaseDebitNoteController>()
        : null;

    if (purchaseDebitNoteController != null) {
      await purchaseDebitNoteController.refreshData();
    }
    Get.back(result: true);
  }
}

class DebitNoteItem {
  final String productId;
  final String productName;
  final double qty;
  final double unitCost;
  final double mrp;
  final double sellingPrice;
  final double discount1;
  final String? taxId;
  final double taxPercent;
  final String? uomId;
  final String? unit;

  DebitNoteItem({
    required this.productId,
    required this.productName,
    required this.qty,
    required this.unitCost,
    this.mrp = 0,
    this.sellingPrice = 0,
    this.discount1 = 0,
    this.taxId,
    this.taxPercent = 0,
    this.uomId,
    this.unit,
  });

  double get taxable => (qty * unitCost) - discount1;
  double get tax => taxable * (taxPercent / 100);
  double get total => taxable + tax;
  double get landingPrice => unitCost + (tax / (qty != 0 ? qty : 1));
  double get margin => sellingPrice - landingPrice;

  DebitNoteItem copyWith({
    double? qty,
    double? unitCost,
    double? mrp,
    double? sellingPrice,
    double? discount1,
    String? uomId,
    String? unit,
  }) {
    return DebitNoteItem(
      productId: productId,
      productName: productName,
      qty: qty ?? this.qty,
      unitCost: unitCost ?? this.unitCost,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      discount1: discount1 ?? this.discount1,
      taxId: taxId,
      taxPercent: taxPercent,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'qty': qty,
      'unit': unit,
      'uomId': uomId,
      'unitCost': unitCost,
      'mrp': mrp,
      'sellingPrice': sellingPrice,
      'discount1': discount1,
      'tax': tax,
      'taxId': taxId ?? "",
      'landingCost': unitCost + tax,
      'margin': mrp - (unitCost + tax),
      'total': total,
    };
  }
}

class DebitNoteAdditionalCharge {
  final String id;
  final String name;
  final double amount;
  final String? taxId;
  final double taxPercent;

  DebitNoteAdditionalCharge({
    required this.id,
    required this.name,
    required this.amount,
    this.taxId,
    this.taxPercent = 0,
  });

  DebitNoteAdditionalCharge copyWith({
    String? id,
    String? name,
    double? amount,
    String? taxId,
    double? taxPercent,
  }) {
    return DebitNoteAdditionalCharge(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      taxId: taxId ?? this.taxId,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chargeId': id,
      'taxId': taxId ?? "",
      'amount': amount,
      'totalAmount': amount + (amount * taxPercent / 100),
    };
  }
}
