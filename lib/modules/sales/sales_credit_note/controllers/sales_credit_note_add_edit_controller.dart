import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';
import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/sales/sales_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/uom_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/repositories/settings/terms_and_condition_repository.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:ai_setu/data/repositories/user/user_repository.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesCreditNoteAddEditController extends GetxController {
  final SalesRepository _salesRepository = SalesRepository();
  final ContactRepository _contactRepository = ContactRepository();
  final ProductRepository _productRepository = ProductRepository();
  final UomRepository _uomRepository = UomRepository();
  final TaxRepository _taxRepository = TaxRepository();
  final TermsAndConditionRepository _termsAndConditionRepository =
      TermsAndConditionRepository();
  final AdditionalChargeRepository _additionalChargeRepository =
      AdditionalChargeRepository();
  final UserRepository _userRepository = UserRepository();

  // Observable States
  final formKey = GlobalKey<FormState>();

  final isEdit = false.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  // Form Fields
  final selectedCustomer = Rxn<ContactDropdownModel>();
  final selectedDate = Rxn<DateTime>(DateTime.now());
  final selectedDueDate = Rxn<DateTime>(
    DateTime.now().add(const Duration(days: 1)),
  );
  final placeOfSupply = "".obs;
  final selectedBillingAddress = Rxn<SalesCreditNoteAddress>();
  final selectedShippingAddress = Rxn<SalesCreditNoteAddress>();
  final productType = "all".obs;
  final reverseCharge = false.obs;
  final paymentReminder = true.obs;
  final reason = "".obs;
  final sez = "".obs;
  final notes = "".obs;

  // Shipping Details
  final shippingType = "".obs;
  final referenceNo = "".obs;
  final shippingDate = Rxn<DateTime>();
  final transportDate = Rxn<DateTime>();
  final selectedTransporter = Rxn<ContactDropdownModel>();
  final modeOfTransport = "".obs;
  final vehicleNo = "".obs;
  final weight = 0.0.obs;

  // Controllers
  final dateController = TextEditingController();
  final dueDateController = TextEditingController();
  final reasonController = TextEditingController();
  final sezController = TextEditingController();
  final notesController = TextEditingController();

  final shippingDateController = TextEditingController();
  final transportDateController = TextEditingController();
  final shippingTypeController = TextEditingController();
  final referenceNoController = TextEditingController();
  final modeOfTransportController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final weightController = TextEditingController();
  final flatDiscountController = TextEditingController(text: "0");
  final roundOffController = TextEditingController(text: "0");
  final placeOfSupplyController = TextEditingController();

  // Dropdown Lists
  final availableCustomers = <ContactDropdownModel>[].obs;
  final availableTaxes = <TaxDropdownModel>[].obs;
  final availableProducts = <ProductDropdownModel>[].obs;
  final availableUoms = <dynamic>[].obs;
  final availableCharges = <AdditionalChargeModel>[].obs;
  final availableTermsAndConditions = <TermsAndConditionModel>[].obs;
  final availableSalesMen = <UserDropDownModel>[].obs;
  final availableTransporters = <ContactDropdownModel>[].obs;
  final selectedTermsAndConditionIds = <String>[].obs;

  // Items and Charges
  final items = <SalesCreditNoteItemState>[].obs;
  final additionalCharges = <SalesCreditNoteAdditionalChargeState>[].obs;

  // Summary
  final grossAmount = 0.0.obs;
  final discountAmount = 0.0.obs;
  final flatDiscount = 0.0.obs;
  final taxableAmount = 0.0.obs;
  final taxAmount = 0.0.obs;
  final roundOff = 0.0.obs;
  final netAmount = 0.0.obs;

  List<ContactDropdownModel> get customers => availableCustomers;
  List<TaxDropdownModel> get taxes => availableTaxes;
  List<UserDropDownModel> get salesmen => availableSalesMen;
  final selectedSalesman = Rxn<UserDropDownModel>();

  List<ContactAddress> get billingAddresses =>
      selectedCustomer.value?.address ?? [];
  List<ContactAddress> get shippingAddresses =>
      selectedCustomer.value?.address ?? [];

  List<TermsAndConditionModel> get termsAndConditions =>
      availableTermsAndConditions;
  List<TermsAndConditionModel> get selectedTerms => availableTermsAndConditions
      .where((t) => selectedTermsAndConditionIds.contains(t.id))
      .toList();

  bool isTermSelected(String id) => selectedTermsAndConditionIds.contains(id);

  void toggleTerm(TermsAndConditionModel term) {
    if (selectedTermsAndConditionIds.contains(term.id)) {
      selectedTermsAndConditionIds.remove(term.id);
    } else {
      selectedTermsAndConditionIds.add(term.id);
    }
  }

  late String creditNoteId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as SalesCreditNoteModel?;
    if (args != null) {
      isEdit.value = true;
      creditNoteId = args.id;
    }

    _loadInitialData();
    _setupListeners();
  }

  void _setupListeners() {
    _updateDateControllers();

    // Summary calculations
    calculateSummary();

    ever(selectedCustomer, (customer) {
      if (customer != null) {
        if (customer.address.isNotEmpty) {
          final firstAddr = customer.address.first;
          selectedBillingAddress.value = SalesCreditNoteAddress(
            id: firstAddr.id,
            addressLine1: firstAddr.addressLine1 ?? "",
            addressLine2: firstAddr.addressLine2,
            pinCode: firstAddr.pinCode ?? 0,
            city: firstAddr.city != null
                ? IdNameModel(
                    id: firstAddr.city!.id,
                    name: firstAddr.city!.name,
                  )
                : null,
            state: firstAddr.state != null
                ? IdNameModel(
                    id: firstAddr.state!.id,
                    name: firstAddr.state!.name,
                  )
                : null,
            country: firstAddr.country != null
                ? IdNameModel(
                    id: firstAddr.country!.id,
                    name: firstAddr.country!.name,
                  )
                : null,
          );
          selectedShippingAddress.value = selectedBillingAddress.value;
          placeOfSupply.value = firstAddr.state?.name ?? "";
        }
      }
    });

    reasonController.addListener(() => reason.value = reasonController.text);
    sezController.addListener(() => sez.value = sezController.text);
    notesController.addListener(() => notes.value = notesController.text);

    shippingTypeController.addListener(
      () => shippingType.value = shippingTypeController.text,
    );
    referenceNoController.addListener(
      () => referenceNo.value = referenceNoController.text,
    );
    modeOfTransportController.addListener(
      () => modeOfTransport.value = modeOfTransportController.text,
    );
    vehicleNoController.addListener(
      () => vehicleNo.value = vehicleNoController.text,
    );
    weightController.addListener(() {
      weight.value = double.tryParse(weightController.text) ?? 0.0;
    });
    flatDiscountController.addListener(() {
      flatDiscount.value = double.tryParse(flatDiscountController.text) ?? 0.0;
      calculateSummary();
    });
    roundOffController.addListener(() {
      roundOff.value = double.tryParse(roundOffController.text) ?? 0.0;
      calculateSummary();
    });
    placeOfSupplyController.addListener(() {
      placeOfSupply.value = placeOfSupplyController.text;
    });
    ever(placeOfSupply, (v) {
      if (placeOfSupplyController.text != v) {
        placeOfSupplyController.text = v;
      }
    });
  }

  void _updateDateControllers() {
    if (selectedDate.value != null) {
      dateController.text = DateFormat(
        'dd/MM/yyyy',
      ).format(selectedDate.value!);
    }
    if (selectedDueDate.value != null) {
      dueDateController.text = DateFormat(
        'dd/MM/yyyy',
      ).format(selectedDueDate.value!);
    }
    if (shippingDate.value != null) {
      shippingDateController.text = DateFormat(
        'dd/MM/yyyy',
      ).format(shippingDate.value!);
    }
    if (transportDate.value != null) {
      transportDateController.text = DateFormat(
        'dd/MM/yyyy',
      ).format(transportDate.value!);
    }
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    dateController.text = DateFormat('dd/MM/yyyy').format(date);
  }

  void onDueDateSelected(DateTime date) {
    selectedDueDate.value = date;
    dueDateController.text = DateFormat('dd/MM/yyyy').format(date);
  }

  void onShippingDateSelected(DateTime date) {
    shippingDate.value = date;
    shippingDateController.text = DateFormat('dd/MM/yyyy').format(date);
  }

  void onTransportDateSelected(DateTime date) {
    transportDate.value = date;
    transportDateController.text = DateFormat('dd/MM/yyyy').format(date);
  }

  Future<void> _loadInitialData() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        _contactRepository.getContactDropdown(typeFilter: 'customer'),
        _taxRepository.getTaxes(),
        _productRepository.getProductDropdown(),
        _uomRepository.getUomDropdown(),
        _additionalChargeRepository.getAdditionalCharges(limit: 100),
        _termsAndConditionRepository.getTermsAndCondition(),
        _userRepository.getUserDropDown(),
        _contactRepository.getContactDropdown(typeFilter: 'transporter'),
      ]);

      availableCustomers.assignAll(results[0] as List<ContactDropdownModel>);
      availableTaxes.assignAll(results[1] as List<TaxDropdownModel>);
      availableProducts.assignAll(results[2] as List<ProductDropdownModel>);
      availableUoms.assignAll(results[3] as List<dynamic>);
      availableCharges.assignAll(
        (results[4] as PaginationModel<AdditionalChargeModel>).items,
      );
      availableTermsAndConditions.assignAll(
        results[5] as List<TermsAndConditionModel>,
      );
      availableSalesMen.assignAll(results[6] as List<UserDropDownModel>);
      availableTransporters.assignAll(results[7] as List<ContactDropdownModel>);

      if (isEdit.value) {
        await _fetchCreditNoteDetails();
      }
    } catch (e) {
      debugPrint("Error loading initial data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchCreditNoteDetails() async {
    try {
      final model = await _salesRepository.getSalesCreditNoteById(creditNoteId);
      _populateFields(model);
    } catch (e) {
      AppSnackbar.error(
        "Failed to fetch details: $e",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void _populateFields(SalesCreditNoteModel model) {
    selectedDate.value = model.creditNoteDate;
    selectedDueDate.value = model.dueDate;
    placeOfSupply.value = model.placeOfSupply ?? "";
    selectedBillingAddress.value = model.billingAddress;
    selectedShippingAddress.value = model.shippingAddress;
    productType.value = model.productType ?? "all";
    reverseCharge.value = model.reverseCharge;
    paymentReminder.value = model.paymentReminder;
    reason.value = model.reason ?? "";
    reasonController.text = model.reason ?? "";
    sez.value = model.sez ?? "";
    sezController.text = model.sez ?? "";
    if (model.salesManId != null) {
      selectedSalesman.value = availableSalesMen.firstWhereOrNull(
        (e) => e.id == model.salesManId,
      );
    }
    notes.value = model.notes ?? "";
    notesController.text = model.notes ?? "";
    placeOfSupplyController.text = model.placeOfSupply ?? "";

    if (model.summary != null) {
      flatDiscount.value = model.summary!.flatDiscount;
      flatDiscountController.text = model.summary!.flatDiscount.toString();
      roundOff.value = model.summary!.roundOff;
      roundOffController.text = model.summary!.roundOff.toString();
    }

    if (model.shippingDetails != null) {
      shippingType.value = model.shippingDetails!.shippingType;
      shippingTypeController.text = model.shippingDetails!.shippingType;
      referenceNo.value = model.shippingDetails!.referenceNo ?? "";
      referenceNoController.text = model.shippingDetails!.referenceNo ?? "";
      shippingDate.value = model.shippingDetails!.shippingDate;
      transportDate.value = model.shippingDetails!.transportDate;
      modeOfTransport.value = model.shippingDetails!.modeOfTransport ?? "";
      modeOfTransportController.text =
          model.shippingDetails!.modeOfTransport ?? "";
      if (model.shippingDetails!.transporterId != null) {
        selectedTransporter.value = availableTransporters.firstWhereOrNull(
          (e) => e.id == model.shippingDetails!.transporterId,
        );
      }
      vehicleNo.value = model.shippingDetails!.vehicleNo ?? "";
      vehicleNoController.text = model.shippingDetails!.vehicleNo ?? "";
      weight.value = model.shippingDetails!.weight;
      weightController.text = model.shippingDetails!.weight.toString();
    }

    if (model.customerId != null) {
      selectedCustomer.value = availableCustomers.firstWhereOrNull(
        (e) => e.id == model.customerId!.id,
      );
    }

    items.assignAll(
      model.productDetails.map((e) {
        return SalesCreditNoteItemState(
          productId: e.productId?.id ?? "",
          productName: e.productId?.name ?? "Unknown",
          qty: e.qty,
          freeQty: e.freeQty,
          price: e.price,
          discount1: e.discount1,
          taxId: e.taxId?.id,
          taxPercent: e.taxId?.percentage.toDouble() ?? 0.0,
          uomId: e.uomId?.id,
          unit: e.unit,
        );
      }).toList(),
    );

    additionalCharges.assignAll(
      model.additionalCharges.map((e) {
        final charge = availableCharges.firstWhereOrNull(
          (c) => c.id == e.chargeId,
        );
        final tax = availableTaxes.firstWhereOrNull((t) => t.id == e.taxId);
        return SalesCreditNoteAdditionalChargeState(
          id: e.chargeId ?? "",
          name: charge?.name ?? "Charge",
          amount: e.amount,
          taxId: e.taxId,
          taxPercent: tax?.percentage.toDouble() ?? 0.0,
        );
      }).toList(),
    );

    selectedTermsAndConditionIds.assignAll(
      model.termsAndConditionIds.map((e) => e.id),
    );

    _updateDateControllers();
    calculateSummary();
  }

  void onCustomerSelected(ContactDropdownModel customer) {
    selectedCustomer.value = customer;
    if (customer.address.isNotEmpty) {
      final firstAddr = customer.address.first;
      selectedBillingAddress.value = SalesCreditNoteAddress(
        id: firstAddr.id,
        addressLine1: firstAddr.addressLine1 ?? "",
        addressLine2: firstAddr.addressLine2,
        pinCode: firstAddr.pinCode ?? 0,
        city: firstAddr.city != null
            ? IdNameModel(id: firstAddr.city!.id, name: firstAddr.city!.name)
            : null,
        state: firstAddr.state != null
            ? IdNameModel(id: firstAddr.state!.id, name: firstAddr.state!.name)
            : null,
        country: firstAddr.country != null
            ? IdNameModel(
                id: firstAddr.country!.id,
                name: firstAddr.country!.name,
              )
            : null,
      );
      selectedShippingAddress.value = selectedBillingAddress.value;
      placeOfSupply.value = firstAddr.state?.name ?? "";
      placeOfSupplyController.text = firstAddr.state?.name ?? "";
    } else {
      selectedBillingAddress.value = null;
      selectedShippingAddress.value = null;
      placeOfSupply.value = "";
      placeOfSupplyController.text = "";
    }
  }

  void addItem(ProductDropdownModel product) async {
    try {
      final productDetails = await _productRepository.getProductById(
        product.id,
      );
      items.add(
        SalesCreditNoteItemState(
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
        ),
      );
      calculateSummary();
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  void removeItem(int index) {
    items.removeAt(index);
    calculateSummary();
  }

  void updateItemQty(int index, double qty) {
    items[index] = items[index].copyWith(qty: qty);
    calculateSummary();
  }

  void updateItemPrice(int index, double price) {
    items[index] = items[index].copyWith(price: price);
    calculateSummary();
  }

  void updateItemDiscount(int index, double discount) {
    items[index] = items[index].copyWith(discount1: discount);
    calculateSummary();
  }

  void updateItemFreeQty(int index, double freeQty) {
    items[index] = items[index].copyWith(freeQty: freeQty);
    calculateSummary();
  }

  void addAdditionalCharge() {
    additionalCharges.add(
      SalesCreditNoteAdditionalChargeState(id: '', name: '', amount: 0),
    );
    calculateSummary();
  }

  void removeAdditionalCharge(int index) {
    additionalCharges.removeAt(index);
    calculateSummary();
  }

  void updateAdditionalCharge(
    int index,
    SalesCreditNoteAdditionalChargeState charge,
  ) {
    additionalCharges[index] = charge;
    calculateSummary();
  }

  void calculateSummary() {
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
    discountAmount.value = itemsDiscount;
    taxableAmount.value =
        (gross - itemsDiscount - flatDiscount.value) + chargesTotal;
    taxAmount.value = itemsTax + chargesTax;
    netAmount.value = taxableAmount.value + taxAmount.value + roundOff.value;
  }

  Future<void> saveSalesCreditNote() async {
    if (selectedCustomer.value == null) {
      AppSnackbar.error(
        "Please select a customer",
        position: SnackPosition.BOTTOM,
      );
      return;
    }

    isSaving.value = true;
    try {
      final Map<String, dynamic> payload = {
        "creditNoteDate": selectedDate.value?.toIso8601String(),
        "dueDate": selectedDueDate.value?.toIso8601String(),
        "customerId": selectedCustomer.value!.id,
        "placeOfSupply": placeOfSupply.value,
        "billingAddress": selectedBillingAddress.value?.id,
        "shippingAddress": selectedShippingAddress.value?.id,
        "productType": productType.value,
        "reverseCharge": reverseCharge.value,
        "reason": reason.value,
        "sez": sez.value,
        "paymentReminder": paymentReminder.value,
        if (selectedSalesman.value != null)
          "salesManId": selectedSalesman.value!.id,
        "termsAndConditionIds": selectedTermsAndConditionIds,
        "productDetails": items.map((e) => e.toMap()).toList(),
        "additionalCharges": additionalCharges.map((e) => e.toMap()).toList(),
        "shippingDetails": {
          "shippingType": shippingType.value.isNotEmpty
              ? shippingType.value
              : "delivery",
          if (shippingDate.value != null)
            "shippingDate": shippingDate.value!.toIso8601String(),
          if (referenceNo.value.isNotEmpty) "referenceNo": referenceNo.value,
          if (transportDate.value != null)
            "transportDate": transportDate.value!.toIso8601String(),
          if (modeOfTransport.value.isNotEmpty)
            "modeOfTransport": modeOfTransport.value,
          if (selectedTransporter.value != null)
            "transporterId": selectedTransporter.value!.id,
          if (vehicleNo.value.isNotEmpty) "vehicleNo": vehicleNo.value,
          "weight": weight.value,
        },
        "summary": {
          "flatDiscount": flatDiscount.value,
          "grossAmount": grossAmount.value,
          "discountAmount": discountAmount.value,
          "taxableAmount": taxableAmount.value,
          "taxAmount": taxAmount.value,
          "roundOff": roundOff.value,
          "netAmount": netAmount.value,
        },
        "notes": notes.value,
        "status": "open",
      };

      if (isEdit.value) {
        payload["salesCreditNoteId"] = creditNoteId;
      }

      final res = isEdit.value
          ? await _salesRepository.updateSalesCreditNote(payload)
          : await _salesRepository.addSalesCreditNote(payload);

      if (res.status == 200 || res.status == 201) {
        Get.back(result: true);
        AppSnackbar.success(
          isEdit.value ? "Credit Note updated" : "Credit Note created",
          position: SnackPosition.BOTTOM,
        );
      } else {
        AppSnackbar.error(
          res.message ?? "Failed to save",
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      AppSnackbar.error(
        "An unexpected error occurred: $e",
        position: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    dueDateController.dispose();
    reasonController.dispose();
    sezController.dispose();
    notesController.dispose();
    shippingDateController.dispose();
    transportDateController.dispose();
    shippingTypeController.dispose();
    referenceNoController.dispose();
    modeOfTransportController.dispose();
    vehicleNoController.dispose();
    weightController.dispose();
    flatDiscountController.dispose();
    roundOffController.dispose();
    super.onClose();
  }
}

class SalesCreditNoteItemState {
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

  SalesCreditNoteItemState({
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

  SalesCreditNoteItemState copyWith({
    String? productId,
    String? productName,
    double? qty,
    double? freeQty,
    double? price,
    double? discount1,
    String? taxId,
    double? taxPercent,
    String? uomId,
    String? unit,
  }) {
    return SalesCreditNoteItemState(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      qty: qty ?? this.qty,
      freeQty: freeQty ?? this.freeQty,
      price: price ?? this.price,
      discount1: discount1 ?? this.discount1,
      taxId: taxId ?? this.taxId,
      taxPercent: taxPercent ?? this.taxPercent,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "qty": qty,
      "freeQty": freeQty,
      "price": price,
      "discount1": discount1,
      "tax": tax,
      "total": total,
      "uomId": uomId,
      "taxId": taxId ?? "",
      "unit": unit,
    };
  }
}

class SalesCreditNoteAdditionalChargeState {
  final String id;
  final String name;
  final double amount;
  final String? taxId;
  final double taxPercent;

  SalesCreditNoteAdditionalChargeState({
    required this.id,
    required this.name,
    required this.amount,
    this.taxId,
    this.taxPercent = 0,
  });

  SalesCreditNoteAdditionalChargeState copyWith({
    String? id,
    String? name,
    double? amount,
    String? taxId,
    double? taxPercent,
  }) {
    return SalesCreditNoteAdditionalChargeState(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      taxId: taxId ?? this.taxId,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "chargeId": id,
      "taxId": taxId ?? "",
      "amount": amount,
      "totalAmount": amount + (amount * taxPercent / 100),
    };
  }
}
