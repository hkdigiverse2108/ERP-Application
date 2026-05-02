import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/repositories/inventory/uom_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';

class AddItemController extends GetxController {
  static AddItemController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  final ProductRepository _productRepo = ProductRepository();
  final UomRepository _uomRepo = UomRepository();
  final TaxRepository _taxRepo = TaxRepository();

  // Dropdown Selections
  final productId = "".obs;
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

  void saveItem() {
    // Logic for saving the item will be implemented here
    isSaving.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isSaving.value = false;
      Get.back();
      AppSnackbar.success("Item added successfully");
    });
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
