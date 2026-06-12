import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/selas/delivery_challan_model.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/data/model/selas/invoice_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/model/terms_and_condition/terms_and_condition_model.dart';
import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/sales/sales_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/uom_repository.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/repositories/settings/terms_and_condition_repository.dart';
import 'package:ai_setu/data/repositories/settings/additional_charge_repository.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/modules/sales/delivery_challan/controllers/delivery_challan_controller.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:intl/intl.dart';

class DeliveryChallanAddEditController extends GetxController {
  final SalesRepository _salesRepository = SalesRepository();
  final ContactRepository _contactRepository = ContactRepository();
  final ProductRepository _productRepository = ProductRepository();
  final UomRepository _uomRepository = UomRepository();
  final TaxRepository _taxRepository = TaxRepository();
  final PaymentTermsRepository _paymentTermsRepository =
      PaymentTermsRepository();
  final TermsAndConditionRepository _termsAndConditionRepository =
      TermsAndConditionRepository();
  final AdditionalChargeRepository _additionalChargeRepository =
      AdditionalChargeRepository();

  // Observable States
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isEdit = false.obs;

  // Form Fields
  final createdFrom = Rxn<String>();
  final selectedCustomer = Rxn<ContactDropdownModel>();
  final selectedDate = Rxn<DateTime>(DateTime.now());
  final selectedDueDate = Rxn<DateTime>(
    DateTime.now().add(const Duration(days: 10)),
  );
  final placeOfSupply = "".obs;
  final selectedBillingAddress = Rxn<ContactAddress>();
  final selectedShippingAddress = Rxn<ContactAddress>();
  final selectedPaymentTermsId = "".obs;
  final taxType = "default".obs;
  final notes = "".obs;

  // Shipping Details
  final shippingType = "".obs;
  final referenceNo = "".obs;
  final shippingDate = Rxn<DateTime>();
  final weight = 0.0.obs;

  // Controllers
  final dateController = TextEditingController();
  final dueDateController = TextEditingController();
  final shippingDateController = TextEditingController();
  final shippingTypeController = TextEditingController();
  final referenceNoController = TextEditingController();
  final weightController = TextEditingController();
  final notesController = TextEditingController();
  final flatDiscountController = TextEditingController(text: "0");
  final roundOffController = TextEditingController(text: "0");
  final placeOfSupplyController = TextEditingController();

  // Dropdown Lists
  final availableCustomers = <ContactDropdownModel>[].obs;
  final availableSalesOrders = <IdNameModel>[].obs;
  final selectedSalesOrders = <IdNameModel>[].obs;
  final availableInvoices = <IdNameModel>[].obs;
  final selectedInvoices = <IdNameModel>[].obs;
  final availableTaxes = <TaxDropdownModel>[].obs;
  final availableProducts = <ProductDropdownModel>[].obs;
  final availableUoms = <dynamic>[].obs;
  final availableCharges = <AdditionalChargeModel>[].obs;
  final availableTermsAndConditions = <TermsAndConditionModel>[].obs;
  final availablePaymentTerms = <PaymentTermsModel>[].obs;
  final selectedTermsAndConditionIds = <String>[].obs;

  // Items and Charges
  final items = <DeliveryChallanItemState>[].obs;
  final additionalCharges = <DeliveryChallanAdditionalChargeState>[].obs;

  // Summary
  final grossAmount = 0.0.obs;
  final discountAmount = 0.0.obs;
  final taxableAmount = 0.0.obs;
  final taxAmount = 0.0.obs;
  final netAmount = 0.0.obs;
  final flatDiscount = 0.0.obs;
  final roundOff = 0.0.obs;

  late String challanId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as DeliveryChallanModel?;
    if (args != null) {
      isEdit.value = true;
      challanId = args.id;
    }

    _loadInitialData();
    _setupListeners();
  }

  void _setupListeners() {
    _updateDateControllers();

    debounce(
      items,
      (_) => calculateSummary(),
      time: const Duration(milliseconds: 100),
    );
    debounce(
      additionalCharges,
      (_) => calculateSummary(),
      time: const Duration(milliseconds: 100),
    );

    flatDiscountController.addListener(calculateSummary);
    roundOffController.addListener(calculateSummary);

    ever(selectedCustomer, (customer) {
      if (customer != null) {
        if (!isEdit.value) {
          selectedSalesOrders.clear();
          selectedInvoices.clear();
          fetchSalesOrders();
          fetchInvoices();
        }
        if (customer.address.isNotEmpty) {
          selectedBillingAddress.value = customer.address.first;
          selectedShippingAddress.value = customer.address.first;
        }
        placeOfSupply.value = customer.address.isNotEmpty
            ? customer.address.first.state?.name ?? ""
            : "";
      } else {
        availableSalesOrders.clear();
        selectedSalesOrders.clear();
        availableInvoices.clear();
        selectedInvoices.clear();
      }
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
        _paymentTermsRepository.getPaymentTerms(limit: 100),
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
      availablePaymentTerms.assignAll(
        (results[6] as PaginationModel<PaymentTermsModel>).items,
      );

      if (isEdit.value) {
        await _fetchChallanDetails();
      } else {
        addItem();
      }
    } catch (e) {
      debugPrint("Error loading initial data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchChallanDetails() async {
    try {
      final model = await _salesRepository.getDeliveryChallanById(challanId);
      _populateFields(model);
    } catch (e) {
      AppSnackbar.error(
        "Failed to fetch details: $e",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void _populateFields(DeliveryChallanModel model) {
    createdFrom.value = model.createdFrom;
    selectedDate.value = model.date;
    selectedDueDate.value = model.dueDate;
    placeOfSupply.value = model.placeOfSupply ?? "";
    if (model.customerId != null) {
      final customer = availableCustomers.firstWhereOrNull(
        (e) => e.id == model.customerId!.id,
      );
      if (customer != null) {
        selectedCustomer.value = customer;
        if (model.billingAddress != null) {
          selectedBillingAddress.value = customer.address.firstWhereOrNull(
            (a) => a.id == model.billingAddress!.id,
          );
        }
        if (model.shippingAddress != null) {
          selectedShippingAddress.value = customer.address.firstWhereOrNull(
            (a) => a.id == model.shippingAddress!.id,
          );
        }
      }
    }
    selectedPaymentTermsId.value = model.paymentTermsId?.id ?? "";
    taxType.value = model.taxType ?? "default";
    notes.value = model.notes ?? "";
    notesController.text = model.notes ?? "";

    if (model.shippingDetails != null) {
      shippingType.value = model.shippingDetails!.shippingType;
      shippingTypeController.text = model.shippingDetails!.shippingType;
      referenceNo.value = model.shippingDetails!.referenceNo ?? "";
      referenceNoController.text = model.shippingDetails!.referenceNo ?? "";
      shippingDate.value = model.shippingDetails!.shippingDate;
      weight.value = model.shippingDetails!.weight;
      weightController.text = model.shippingDetails!.weight.toString();
    }

    // Customer already populated above to handle addresses correctly

    selectedSalesOrders.assignAll(model.salesOrderIds);

    items.assignAll(
      model.items.map((e) {
        final state = DeliveryChallanItemState(
          onChanged: calculateSummary,
          availableTaxes: availableTaxes,
        );
        if (e.productId != null) {
          final targetId = e.variantId ?? e.productId!.id;
          state.productId.value = availableProducts.firstWhereOrNull(
            (p) => p.id == targetId,
          );
        }
        state.variantId.value = e.variantId;
        state.qty.value = e.qty;
        state.qtyController.text = e.qty.toString();
        state.price.value = e.price;
        state.priceController.text = e.price.toString();
        state.uomId.value = e.uomId;
        state.unit.value = e.unit ?? "";
        if (e.taxId != null) {
          state.taxId.value = availableTaxes.firstWhereOrNull(
            (t) => t.id == e.taxId!.id,
          );
        }
        state.discount1.value = e.discount1;
        state.discountController.text = e.discount1.toString();
        state.calculate();
        return state;
      }).toList(),
    );

    additionalCharges.assignAll(
      model.additionalCharges.map((e) {
        final state = DeliveryChallanAdditionalChargeState(
          onChanged: calculateSummary,
        );
        if (e.chargeId != null) {
          state.chargeId.value = availableCharges.firstWhereOrNull(
            (c) => c.id == e.chargeId,
          );
        }
        state.amount.value = e.amount;
        state.amountController.text = e.amount.toString();
        state.taxId.value = e.taxId;
        state.totalAmount.value = e.totalAmount;
        return state;
      }).toList(),
    );

    selectedTermsAndConditionIds.assignAll(model.termsAndConditionIds);

    if (model.transactionSummary != null) {
      flatDiscountController.text = model.transactionSummary!.flatDiscount
          .toString();
      roundOffController.text = model.transactionSummary!.roundOff.toString();
    }

    _updateDateControllers();
    calculateSummary();
  }

  Future<void> fetchSalesOrders() async {
    if (selectedCustomer.value == null) return;
    try {
      final orders = await _salesRepository.getSalesOrderDropdown(
        customerFilter: selectedCustomer.value!.id,
        statusFilter: 'pending',
      );
      availableSalesOrders.assignAll(orders);
    } catch (e) {
      debugPrint("Error fetching sales orders: $e");
    }
  }

  Future<void> fetchInvoices() async {
    if (selectedCustomer.value == null) return;
    try {
      final invoices = await _salesRepository.getInvoiceDropdown(
        customerFilter: selectedCustomer.value!.id,
        statusFilter: 'pending',
      );
      availableInvoices.assignAll(invoices);
    } catch (e) {
      debugPrint("Error fetching invoices: $e");
    }
  }

  void onSourceChanged(String? source) {
    createdFrom.value = source;
    if (source != 'sales-order') {
      selectedSalesOrders.clear();
    }
    if (source != 'invoice') {
      selectedInvoices.clear();
    }
  }

  Future<void> addSalesOrder(IdNameModel order) async {
    if (selectedSalesOrders.any((e) => e.id == order.id)) return;
    selectedSalesOrders.add(order);
    try {
      isLoading.value = true;
      final details = await _salesRepository.getSalesOrderById(order.id);
      _mergeAutoFillData(
        customerId: details.customerId?.id,
        placeOfSupplyStr: details.placeOfSupply,
        taxTypeStr: details.taxType,
        notes: details.notes,
        itemsList: details.items,
        chargesList: details.additionalCharges,
        termsIds: details.termsAndConditionIds,
        shipping: details.shippingDetails,
      );
    } catch (e) {
      debugPrint('Error fetching sales order details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addInvoice(IdNameModel invoice) async {
    if (selectedInvoices.any((e) => e.id == invoice.id)) return;
    selectedInvoices.add(invoice);
    try {
      isLoading.value = true;
      final details = await _salesRepository.getInvoiceById(invoice.id);
      _mergeAutoFillData(
        customerId: details.customerId?.id,
        placeOfSupplyStr: details.placeOfSupply,
        taxTypeStr: details.taxType,
        notes: details.notes,
        itemsList: details.items,
        chargesList: details.additionalCharges,
        termsIds: details.termsAndConditionIds,
        shipping: details.shippingDetails,
      );
    } catch (e) {
      debugPrint('Error fetching invoice details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _mergeAutoFillData({
    String? customerId,
    String? placeOfSupplyStr,
    String? taxTypeStr,
    String? notes,
    required List itemsList,
    required List chargesList,
    required List<dynamic> termsIds,
    dynamic shipping,
  }) {
    if (customerId != null && selectedCustomer.value == null) {
      selectedCustomer.value = availableCustomers.firstWhereOrNull(
        (c) => c.id == customerId,
      );
    }
    if (placeOfSupply.value.isEmpty) {
      placeOfSupply.value = placeOfSupplyStr ?? '';
    }
    if (taxTypeStr != null) {
      taxType.value = taxTypeStr;
    }
    if (notes != null && notesController.text.isEmpty) {
      notesController.text = notes;
    }

    if (items.length == 1 && items[0].productId.value == null) {
      items.clear();
    }

    // Append items
    for (var e in itemsList) {
      final state = DeliveryChallanItemState(
        onChanged: calculateSummary,
        availableTaxes: availableTaxes,
      );

      String? prodId;
      String? variantId;
      double qty = 0.0;
      double freeQty = 0.0;
      double price = 0.0;
      double discount1 = 0.0;
      String? taxId;
      String? uomId;
      String? unit;

      if (e is SalesOrderItem) {
        prodId = e.productId?.id;
        variantId = e.variantId;
        qty = e.qty;
        freeQty = e.freeQty;
        price = e.price;
        discount1 = e.discount1;
        taxId = e.taxId?.id;
        uomId = e.uomId?.id;
        unit = e.uomId?.name;
      } else if (e is InvoiceItem) {
        prodId = e.productId?.id;
        variantId = e.variantId;
        qty = e.qty;
        freeQty = e.freeQty;
        price = e.price;
        discount1 = e.discount1;
        taxId = e.taxId?.id;
        uomId = e.uomId?.id;
        unit = e.unit ?? e.uomId?.name;
      } else {
        try {
          prodId = e.productId?.id ?? "";
          variantId = e.variantId;
          qty = (e.qty as num?)?.toDouble() ?? 0.0;
          freeQty = (e.freeQty as num?)?.toDouble() ?? 0.0;
          price = (e.price as num?)?.toDouble() ?? 0.0;
          discount1 = (e.discount1 as num?)?.toDouble() ?? 0.0;
          taxId = e.taxId?.id;
          uomId = e.uomId is String ? e.uomId : e.uomId?.id;
          unit = e.uomId is String ? e.unit : e.uomId?.name;
        } catch (_) {}
      }

      if (prodId != null) {
        final targetId = variantId ?? prodId;
        state.productId.value = availableProducts.firstWhereOrNull(
          (p) => p.id == targetId,
        );
      }
      state.variantId.value = variantId;
      state.qty.value = qty;
      state.qtyController.text = qty.toString();
      state.price.value = price;
      state.priceController.text = price.toString();
      state.uomId.value = uomId;
      state.unit.value = unit ?? "";
      if (taxId != null) {
        state.taxId.value = availableTaxes.firstWhereOrNull(
          (t) => t.id == taxId,
        );
      }
      state.discount1.value = discount1;
      state.discountController.text = discount1.toString();
      state.freeQty.value = freeQty;
      state.freeQtyController.text = freeQty.toString();
      state.calculate();

      items.add(state);
    }

    // Append charges
    for (var e in chargesList) {
      final state = DeliveryChallanAdditionalChargeState(
        onChanged: calculateSummary,
      );

      String? chargeId;
      double amount = 0.0;
      String? taxId;
      double totalAmount = 0.0;

      // Polymorphic charge parsing
      try {
        chargeId = e.chargeId?.toString() ?? e.chargeId?.id?.toString();
        amount = (e.amount as num?)?.toDouble() ?? 0.0;
        taxId = e.taxId?.toString() ?? e.taxId?.id?.toString();
        totalAmount = (e.totalAmount as num?)?.toDouble() ?? amount;
      } catch (_) {}

      if (chargeId != null) {
        state.chargeId.value = availableCharges.firstWhereOrNull(
          (c) => c.id == chargeId,
        );
      }
      state.amount.value = amount;
      state.amountController.text = amount.toString();
      state.taxId.value = taxId;
      state.totalAmount.value = totalAmount;

      additionalCharges.add(state);
    }

    // Append terms
    for (var id in termsIds) {
      final idStr = id is String ? id : id.toString();
      if (!selectedTermsAndConditionIds.contains(idStr)) {
        selectedTermsAndConditionIds.add(idStr);
      }
    }

    // Shipping details
    if (shipping != null) {
      try {
        shippingType.value = shipping.shippingType ?? "";
        shippingTypeController.text = shipping.shippingType ?? "";
        referenceNo.value = shipping.referenceNo ?? "";
        referenceNoController.text = shipping.referenceNo ?? "";
        if (shipping.shippingDate != null) {
          if (shipping.shippingDate is DateTime) {
            shippingDate.value = shipping.shippingDate;
          } else {
            shippingDate.value = DateTime.tryParse(
              shipping.shippingDate.toString(),
            );
          }
        }
        weight.value = (shipping.weight as num?)?.toDouble() ?? 0.0;
        weightController.text = weight.value.toString();
      } catch (_) {}
    }

    _updateDateControllers();
    calculateSummary();
  }

  void addItem() {
    items.add(
      DeliveryChallanItemState(
        onChanged: calculateSummary,
        availableTaxes: availableTaxes,
      ),
    );
  }

  void removeItem(int index) {
    if (items.length > 1) {
      items.removeAt(index);
    } else {
      items[0] = DeliveryChallanItemState(
        onChanged: calculateSummary,
        availableTaxes: availableTaxes,
      );
    }
    calculateSummary();
  }

  void addAdditionalCharge() {
    additionalCharges.add(
      DeliveryChallanAdditionalChargeState(onChanged: calculateSummary),
    );
  }

  void removeAdditionalCharge(int index) {
    additionalCharges.removeAt(index);
    calculateSummary();
  }

  void calculateSummary() {
    double gross = 0;
    double taxTotal = 0;
    double discount = 0;

    for (var item in items) {
      gross += (item.qty.value * item.price.value);
      discount += item.discount1.value;
      taxTotal += item.taxAmount.value;
    }

    double chargesTaxable = 0;
    double chargesTax = 0;
    for (var charge in additionalCharges) {
      chargesTaxable += charge.amount.value;
      chargesTax += (charge.totalAmount.value - charge.amount.value);
    }

    flatDiscount.value = double.tryParse(flatDiscountController.text) ?? 0.0;
    roundOff.value = double.tryParse(roundOffController.text) ?? 0.0;

    grossAmount.value = gross;
    discountAmount.value = discount;
    taxableAmount.value = (gross - discount) + chargesTaxable;
    taxAmount.value = taxTotal + chargesTax;
    netAmount.value =
        (taxableAmount.value + taxAmount.value + roundOff.value) -
        flatDiscount.value;
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

  Future<void> saveDeliveryChallan() async {
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
        "date": selectedDate.value!.toIso8601String(),
        if (!isEdit.value) "dueDate": selectedDueDate.value!.toIso8601String(),
        "customerId": selectedCustomer.value!.id,
        "placeOfSupply": placeOfSupply.value,
        "billingAddress": selectedBillingAddress.value?.id,
        "shippingAddress": selectedShippingAddress.value?.id,
        if (selectedPaymentTermsId.value.isNotEmpty)
          "paymentTermsId": selectedPaymentTermsId.value,
        "taxType": taxType.value,
        "termsAndConditionIds": selectedTermsAndConditionIds,
        "items": items.map((e) => e.toMap()).toList(),
        if (additionalCharges.isNotEmpty)
          "additionalCharges": additionalCharges
              .where(
                (e) =>
                    e.chargeId.value != null && e.chargeId.value!.id.isNotEmpty,
              )
              .map((e) => e.toMap())
              .toList(),
        "shippingDetails": {
          "shippingType": shippingType.value.isNotEmpty
              ? shippingType.value
              : "delivery",
          if (referenceNo.value.isNotEmpty) "referenceNo": referenceNo.value,
          if (shippingDate.value != null)
            "shippingDate": shippingDate.value!.toIso8601String(),
          "weight": weight.value,
        },
        "transactionSummary": {
          "flatDiscount": flatDiscount.value,
          "grossAmount": grossAmount.value,
          "discountAmount": discountAmount.value + flatDiscount.value,
          "taxableAmount": taxableAmount.value,
          "taxAmount": taxAmount.value,
          "roundOff": roundOff.value,
          "netAmount": netAmount.value,
        },
        "status": "delivered",
        "salesOrderIds": selectedSalesOrders.map((e) => e.id).toList(),
        "invoiceIds": selectedInvoices.map((e) => e.id).toList(),
        "createdFrom": createdFrom.value,
      };

      if (isEdit.value) {
        payload["deliveryChallanId"] = challanId;
      }

      final res = isEdit.value
          ? await _salesRepository.updateDeliveryChallan(payload)
          : await _salesRepository.addDeliveryChallan(payload);

      if (res.status == 200 || res.status == 201) {
        _refreshAndBack();
        AppSnackbar.success(
          isEdit.value
              ? "Delivery Challan updated"
              : "Delivery Challan created",
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

  void _refreshAndBack() {
    if (Get.isRegistered<DeliveryChallanController>()) {
      DeliveryChallanController.instance.refreshData();
    }
    Get.back();
  }

  @override
  void onClose() {
    dateController.dispose();
    dueDateController.dispose();
    shippingDateController.dispose();
    shippingTypeController.dispose();
    referenceNoController.dispose();
    weightController.dispose();
    notesController.dispose();
    flatDiscountController.dispose();
    roundOffController.dispose();
    super.onClose();
  }
}

class DeliveryChallanItemState {
  final productId = Rxn<ProductDropdownModel>();
  final variantId = Rxn<String>();
  final qty = 1.0.obs;
  final price = 0.0.obs;
  final uomId = Rxn<String>();
  final unit = "".obs;
  final taxId = Rxn<TaxDropdownModel>();
  final discount1 = 0.0.obs;
  final freeQty = 0.0.obs;
  final taxableAmount = 0.0.obs;
  final taxAmount = 0.0.obs;
  final totalAmount = 0.0.obs;

  final qtyController = TextEditingController(text: "1");
  final priceController = TextEditingController(text: "0");
  final discountController = TextEditingController(text: "0");
  final freeQtyController = TextEditingController(text: "0");

  final VoidCallback? onChanged;
  final List<TaxDropdownModel> availableTaxes;

  DeliveryChallanItemState({this.onChanged, required this.availableTaxes}) {
    _setupListeners();
  }

  void _setupListeners() {
    qtyController.addListener(() {
      qty.value = double.tryParse(qtyController.text) ?? 0.0;
      calculate();
    });
    priceController.addListener(() {
      price.value = double.tryParse(priceController.text) ?? 0.0;
      calculate();
    });
    discountController.addListener(() {
      discount1.value = double.tryParse(discountController.text) ?? 0.0;
      calculate();
    });
    freeQtyController.addListener(() {
      freeQty.value = double.tryParse(freeQtyController.text) ?? 0.0;
    });
    ever(taxId, (_) => calculate());
    ever(productId, (product) {
      if (product != null) {
        variantId.value = product.hasVariant ? product.id : null;
        price.value = product.sellingPrice;
        priceController.text = product.sellingPrice.toString();
        if (product.salesTaxId != null) {
          taxId.value = availableTaxes.firstWhereOrNull(
            (t) => t.id == product.salesTaxId!.id,
          );
        }
        calculate();
      } else {
        variantId.value = null;
      }
    });
  }

  void calculate() {
    final double base = qty.value * price.value;
    final double discounted = base - discount1.value;
    taxableAmount.value = discounted;

    if (taxId.value != null) {
      taxAmount.value = discounted * (taxId.value!.percentage / 100);
    } else {
      taxAmount.value = 0;
    }

    totalAmount.value = taxableAmount.value + taxAmount.value;
    if (onChanged != null) onChanged!();
  }

  Map<String, dynamic> toMap() {
    final hasVar = productId.value?.hasVariant ?? false;
    return {
      "productId": hasVar ? productId.value?.productId : productId.value?.id,
      "variantId": variantId.value,
      "qty": qty.value,
      "price": price.value,
      "uomId": uomId.value,
      "unit": unit.value,
      "taxId": (taxId.value == null || taxId.value!.id.isEmpty)
          ? null
          : taxId.value!.id,
      "discount1": discount1.value,
      "freeQty": freeQty.value,
      "tax": taxAmount.value,
      "taxableAmount": taxableAmount.value,
      "totalAmount": totalAmount.value,
    };
  }
}

class DeliveryChallanAdditionalChargeState {
  final chargeId = Rxn<AdditionalChargeModel>();
  final amount = 0.0.obs;
  final taxId = Rxn<String>();
  final totalAmount = 0.0.obs;

  final amountController = TextEditingController(text: "0");
  final VoidCallback? onChanged;

  DeliveryChallanAdditionalChargeState({this.onChanged}) {
    _setupListeners();
  }

  void _setupListeners() {
    amountController.addListener(() {
      amount.value = double.tryParse(amountController.text) ?? 0.0;
      totalAmount.value = amount.value;
      if (onChanged != null) onChanged!();
    });
  }

  Map<String, dynamic> toMap() {
    return {
      "chargeId": chargeId.value?.id,
      "amount": amount.value,
      "taxId": (taxId.value == null || taxId.value!.isEmpty)
          ? null
          : taxId.value,
      "totalAmount": totalAmount.value,
    };
  }
}
