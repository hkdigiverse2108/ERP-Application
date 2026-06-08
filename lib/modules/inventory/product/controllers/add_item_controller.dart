import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/stock_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/repositories/inventory/uom_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class AddItemController extends GetxController {
  static AddItemController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxBool enableQuickPicking = false.obs;

  final ProductRepository _productRepo = ProductRepository();
  final UomRepository _uomRepo = UomRepository();
  final TaxRepository _taxRepo = TaxRepository();
  final StockRepository _stockRepo = StockRepository();

  // Dropdown Selections
  final productId = "".obs;
  String? variantId;
  final productName = "".obs;
  final uomId = "".obs;
  final uomName = "".obs;
  final salesTaxId = "".obs;
  final salesTaxName = "".obs;
  final purchaseTaxId = "".obs;
  final purchaseTaxName = "".obs;

  // Flags
  final purchaseTaxIncluding = false.obs;
  final salesTaxIncluding = false.obs;

  // Controllers for Numeric Fields
  final qtyController = TextEditingController(text: "1");
  final purchasePriceController = TextEditingController(text: "0.00");
  final landingCostController = TextEditingController(text: "0.00");
  final mrpController = TextEditingController(text: "0.00");
  final sellingDiscountController = TextEditingController(text: "0.00");
  final sellingPriceController = TextEditingController(text: "0.00");
  final sellingMarginController = TextEditingController(text: "0.00");

  final products = <ProductDropdownModel>[].obs;
  final taxes = <TaxDropdownModel>[].obs;
  final uoms = <CommonDropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    isLoading.value = true;
    try {
      await Future.wait([_fetchTaxes(), _fetchUoms(), _fetchProducts()]);
    } catch (e) {
      Log.e("Inventory Module Error (AddItem) - Dropdown data", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchTaxes() async {
    try {
      final res = await _taxRepo.getTaxes();
      taxes.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (AddItem)", e);
    }
  }

  Future<void> _fetchUoms() async {
    try {
      final res = await _uomRepo.getUomDropdown();
      uoms.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (AddItem)", e);
    }
  }

  Future<void> _fetchProducts() async {
    try {
      final res = await _productRepo.getProductDropdown(isNewProduct: true);
      products.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (AddItem) - Fetching products", e);
    }
  }

  void onProductSelected(ProductDropdownModel prod) {
    productId.value = prod.hasVariant ? prod.productId! : prod.id;
    variantId = prod.hasVariant ? prod.id : null;
    productName.value = prod.name;

    // Prefill UOM
    if (prod.uomId != null) {
      uomId.value = prod.uomId!.id;
      uomName.value = prod.uomId!.name;
    } else {
      uomId.value = "";
      uomName.value = "";
    }

    // Prefill Purchase Tax
    if (prod.purchaseTaxId != null) {
      purchaseTaxId.value = prod.purchaseTaxId!.id;
      purchaseTaxName.value = prod.purchaseTaxId!.name;
    } else {
      purchaseTaxId.value = "";
      purchaseTaxName.value = "";
    }

    // Prefill Sales Tax
    if (prod.salesTaxId != null) {
      salesTaxId.value = prod.salesTaxId!.id;
      salesTaxName.value = prod.salesTaxId!.name;
    } else {
      salesTaxId.value = "";
      salesTaxName.value = "";
    }

    // Prefill Prices
    purchasePriceController.text = prod.purchasePrice.toStringAsFixed(2);
    landingCostController.text = prod.landingCost.toStringAsFixed(2);
    mrpController.text = prod.mrp.toStringAsFixed(2);
    sellingDiscountController.text = prod.sellingDiscount.toStringAsFixed(2);
    sellingPriceController.text = prod.sellingPrice.toStringAsFixed(2);
    sellingMarginController.text = prod.sellingMargin.toStringAsFixed(2);
  }

  Future<void> saveItem() async {
    if (productId.value.isEmpty) {
      AppSnackbar.error("Please select a product");
      return;
    }
    if (uomId.value.isEmpty) {
      AppSnackbar.error("Please select a UOM");
      return;
    }
    if (qtyController.text.trim().isEmpty) {
      AppSnackbar.error("Please enter a valid quantity");
      return;
    }

    isSaving.value = true;
    try {
      final payload = {
        "productId": productId.value,
        "variantId": variantId,
        "uomId": uomId.value,
        "purchaseTaxId": purchaseTaxId.value.isEmpty
            ? null
            : purchaseTaxId.value,
        "salesTaxId": salesTaxId.value.isEmpty ? null : salesTaxId.value,
        "isPurchaseTaxIncluding": purchaseTaxIncluding.value,
        "isSalesTaxIncluding": salesTaxIncluding.value,
        "purchasePrice": purchasePriceController.text,
        "landingCost": landingCostController.text,
        "mrp": mrpController.text,
        "sellingPrice": sellingPriceController.text,
        "sellingMargin": sellingMarginController.text,
        "qty": qtyController.text,
        "quickPick": enableQuickPicking.value,
      };

      final success = await _stockRepo.addStock(payload);
      if (success) {
        Get.back(result: true);
        AppSnackbar.success("Item added successfully");
      }
    } catch (e) {
      Log.e("Inventory Module Error (AddItem) - Saving item", e);
      AppSnackbar.error(e.toString().replaceAll("Exception:", "").trim());
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    qtyController.dispose();
    purchasePriceController.dispose();
    landingCostController.dispose();
    mrpController.dispose();
    sellingDiscountController.dispose();
    sellingPriceController.dispose();
    sellingMarginController.dispose();
    super.onClose();
  }
}
