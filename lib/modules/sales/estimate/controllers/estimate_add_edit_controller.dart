import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:ai_setu/data/repositories/settings/terms_and_condition_repository.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/sales/sales_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class EstimateAddEditController extends GetxController {
  static EstimateAddEditController get instance => Get.find();

  final SalesRepository _salesRepository = SalesRepository();
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
  final estimate = Rxn<EstimateModel>();

  // Dropdown Data
  final customers = <ContactDropdownModel>[].obs;
  final products = <ProductDropdownModel>[].obs;
  final taxes = <TaxDropdownModel>[].obs;
  final paymentTerms = <PaymentTermsModel>[].obs;
  final termsAndConditions = <TermsAndConditionModel>[].obs;
  final availableAdditionalCharges = <AdditionalChargeModel>[].obs;

  // Form Fields
  final selectedCustomer = Rxn<ContactDropdownModel>();
  final estimateDate = DateTime.now().obs;
  final dueDate = DateTime.now().obs;
  final shippingDate = Rxn<DateTime>();
  final selectedPaymentTerm = Rxn<PaymentTermsModel>();
  final selectedTerms = <TermsAndConditionModel>[].obs;
  final taxType = TaxType.defaultType.obs;
  final placeOfSupply = "".obs;
  final billingAddressLine = "".obs;
  final selectedBillingAddress = Rxn<ContactAddress>();
  final selectedShippingAddress = Rxn<ContactAddress>();
  final estimateNoController = TextEditingController();
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
  final items = <EstimateItemState>[].obs;
  final additionalCharges = <EstimateAdditionalChargeState>[].obs;

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
    if (args is EstimateModel) {
      estimate.value = args;
      isEdit.value = true;
      _populateFields();
    }

    // Listener for customer change
    ever(selectedCustomer, (customer) {
      if (customer != null) {
        _fetchCustomerDetails(customer.id);
        if (customer.address.isNotEmpty) {
          selectedBillingAddress.value = customer.address.first;
          selectedShippingAddress.value = customer.address.first;
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
    ever(customers, (_) {
      if (estimate.value?.customerId != null) {
        selectedCustomer.value = customers.firstWhereOrNull(
          (c) => c.id == estimate.value!.customerId?.id,
        );
      }
    });

    ever(paymentTerms, (_) {
      if (estimate.value?.paymentTermsId != null) {
        selectedPaymentTerm.value = paymentTerms.firstWhereOrNull(
          (p) => p.id == estimate.value!.paymentTermsId?.id,
        );
      }
    });
  }

  Future<void> _loadInitialData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _contactRepository.getContactDropdown(
          typeFilter: ContactType.customer.name,
        ),
        _productRepository.getProductDropdown(),
        _taxRepository.getTaxes(),
        _paymentTermsRepository.getPaymentTerms(limit: 100),
        _termsAndConditionRepository.getTermsAndCondition(),
        _additionalChargeRepository.getAdditionalCharges(limit: 100),
        _contactRepository.getContactDropdown(typeFilter: 'transporter'),
      ]);

      customers.value = results[0] as List<ContactDropdownModel>;
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
    final est = estimate.value!;
    estimateNoController.text = est.estimateNo ?? '';
    estimateDate.value = est.date ?? DateTime.now();
    dueDate.value = est.dueDate ?? DateTime.now();
    placeOfSupply.value = est.placeOfSupply ?? '';
    notesController.text = est.notes ?? '';
    taxType.value = est.taxType == "exclusive"
        ? TaxType.exclusive
        : TaxType.defaultType;

    final billingId = est.billingAddress?.id;
    final shippingId = est.shippingAddress?.id;

    ever(customers, (allCustomers) {
      final customer = allCustomers.firstWhereOrNull(
        (c) => c.id == est.customerId?.id,
      );
      if (customer != null) {
        selectedCustomer.value = customer;
        if (billingId != null) {
          selectedBillingAddress.value = customer.address.firstWhereOrNull(
            (a) => a.id == billingId,
          );
        }
        if (shippingId != null) {
          selectedShippingAddress.value = customer.address.firstWhereOrNull(
            (a) => a.id == shippingId,
          );
        }
      }
    });

    // Items
    items.value = est.items.map((e) {
      return EstimateItemState(
        productId: e.productId?.id ?? "",
        productName: e.productId?.name ?? "Unknown",
        qty: e.qty,
        freeQty: e.freeQty,
        price: e.price,
        discount1: e.discount1,
        taxId: e.taxId?.id,
        taxPercent: e.taxId?.percentage ?? 0,
        uomId: e.uomId?.id,
        unit: e.unit,
      );
    }).toList();

    // Additional Charges
    additionalCharges.value = est.additionalCharges.map((e) {
      final charge = availableAdditionalCharges.firstWhereOrNull(
        (c) => c.id == e.chargeId,
      );
      final tax = taxes.firstWhereOrNull((t) => t.id == e.taxId);
      return EstimateAdditionalChargeState(
        id: e.chargeId ?? "",
        name: charge?.name ?? "Charge",
        amount: e.amount,
        taxId: e.taxId,
        taxPercent: tax?.percentage.toDouble() ?? 0.0,
      );
    }).toList();

    // Terms
    ever(termsAndConditions, (allTerms) {
      if (allTerms.isNotEmpty && est.termsAndConditionIds.isNotEmpty) {
        final ids = est.termsAndConditionIds.map((e) => e.id).toSet();
        selectedTerms.value = allTerms
            .where((t) => ids.contains(t.id))
            .toList();
      }
    });

    // Shipping Details
    if (est.shippingDetails != null) {
      final shipping = est.shippingDetails!;
      shippingType.value = shipping.shippingType;
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

    if (est.transactionSummary != null) {
      flatDiscountController.text = est.transactionSummary!.flatDiscount
          .toString();
      roundOffController.text = est.transactionSummary!.roundOff.toString();
    }

    calculateTotals();
  }

  Future<void> _fetchCustomerDetails(String customerId) async {
    try {
      final customer = await _contactRepository.getContactById(customerId);
      if (customer.address.isNotEmpty) {
        final addr = customer.address.first;
        selectedBillingAddress.value = addr;
        billingAddressLine.value = addr.addressLine1 ?? '';
      }
      placeOfSupply.value = customer.address.isNotEmpty
          ? customer.address.first.state?.name ?? ''
          : '';
    } catch (e) {
      debugPrint('Error fetching customer details: $e');
    }
  }

  // Item Management
  void addItem(ProductDropdownModel product) async {
    try {
      final productDetails = await _productRepository.getProductById(
        product.id,
      );

      final newItem = EstimateItemState(
        productId: product.id,
        productName: productDetails.name,
        qty: 1.0,
        freeQty: 0,
        price: productDetails.sellingPrice.toDouble(),
        discount1: 0,
        taxId: productDetails.salesTaxId?.id,
        taxPercent: productDetails.salesTaxId?.percentage.toDouble() ?? 0.0,
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

  void updateItemFreeQty(int index, double freeQty) {
    items[index] = items[index].copyWith(freeQty: freeQty);
    calculateTotals();
  }

  void updateItemPrice(int index, double price) {
    items[index] = items[index].copyWith(price: price);
    calculateTotals();
  }

  void updateItemDiscount(int index, double discount) {
    items[index] = items[index].copyWith(discount1: discount);
    calculateTotals();
  }

  // Additional Charges Management
  void addAdditionalCharge() {
    additionalCharges.add(
      EstimateAdditionalChargeState(id: '', name: '', amount: 0),
    );
    calculateTotals();
  }

  void removeAdditionalCharge(int index) {
    additionalCharges.removeAt(index);
    calculateTotals();
  }

  void updateAdditionalCharge(int index, EstimateAdditionalChargeState charge) {
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
      gross += item.qty * item.price;
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

  Future<void> saveEstimate() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedCustomer.value == null) {
      AppSnackbar.error('Please select a customer');
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
        "weight": shippingWeightController
            .text, // Backend might expect string as per payload "2"
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
        'customerId': selectedCustomer.value?.id,
        'date': estimateDate.value.toIso8601String(),
        'dueDate': dueDate.value.toIso8601String(),
        'paymentTermsId': selectedPaymentTerm.value?.id,
        'billingAddress': selectedBillingAddress.value?.id,
        'shippingAddress': selectedShippingAddress.value?.id,
        'placeOfSupply': placeOfSupply.value,
        'taxType': taxType.value == TaxType.exclusive ? "exclusive" : "default",
        'reverseCharge': "false", // As per user payload
        'items': items.map((e) => e.toMap()).toList(),
        'additionalCharges': additionalCharges.map((e) => e.toMap()).toList(),
        'shippingDetails': shippingDetails,
        'transactionSummary': {
          'flatDiscount': flatDiscountValue.value,
          'grossAmount': grossAmount.value,
          'discountAmount': totalDiscount.value + flatDiscountValue.value,
          'taxableAmount': taxableAmount.value,
          'taxAmount': totalTaxAmount.value,
          'roundOff': roundOffValue.value,
          'netAmount': netAmount.value,
        },
        'termsAndConditionIds': selectedTerms.map((e) => e.id).toList(),
        'notes': notesController.text,
        'branchId': BranchController.to.selectedBranch.value?.id,
        'isActive': true,
      };

      dynamic result;
      if (estimate.value == null) {
        result = await _salesRepository.addEstimate(data);
      } else {
        data['estimateId'] = estimate.value!.id;
        result = await _salesRepository.updateEstimate(data);
      }

      if (result != null) {
        Get.back(result: true);
        AppSnackbar.success('Estimate saved successfully');
      }
    } catch (e) {
      debugPrint('Error saving estimate: $e');
      AppSnackbar.error('Failed to save estimate');
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
}

class EstimateItemState {
  final String productId;
  final String productName;
  final double qty;
  final double freeQty;
  final double price;
  final double discount1;
  final String? taxId;
  final double taxPercent;
  final String? uomId;
  final String? unit;

  EstimateItemState({
    required this.productId,
    required this.productName,
    required this.qty,
    this.freeQty = 0,
    required this.price,
    this.discount1 = 0,
    this.taxId,
    this.taxPercent = 0,
    this.uomId,
    this.unit,
  });

  double get taxable => (qty * price) - discount1;
  double get tax => taxable * (taxPercent / 100);
  double get total => taxable + tax;

  EstimateItemState copyWith({
    double? qty,
    double? freeQty,
    double? price,
    double? discount1,
    String? uomId,
    String? unit,
  }) {
    return EstimateItemState(
      productId: productId,
      productName: productName,
      qty: qty ?? this.qty,
      freeQty: freeQty ?? this.freeQty,
      price: price ?? this.price,
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
      'freeQty': freeQty,
      'unit': unit,
      'uomId': uomId,
      'price': price,
      'discount1': discount1,
      'tax': tax,
      'taxId': taxId ?? "",
      'taxableAmount': taxable,
      'totalAmount': total,
    };
  }
}

class EstimateAdditionalChargeState {
  final String id;
  final String name;
  final double amount;
  final String? taxId;
  final double taxPercent;

  EstimateAdditionalChargeState({
    required this.id,
    required this.name,
    required this.amount,
    this.taxId,
    this.taxPercent = 0,
  });

  EstimateAdditionalChargeState copyWith({
    String? id,
    String? name,
    double? amount,
    String? taxId,
    double? taxPercent,
  }) {
    return EstimateAdditionalChargeState(
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
