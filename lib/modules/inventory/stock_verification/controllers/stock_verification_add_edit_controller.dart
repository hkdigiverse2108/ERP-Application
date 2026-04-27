import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/invetory/stock_verification_model.dart';
import 'package:ai_setu/data/repositories/product_repository.dart';
import 'package:ai_setu/data/repositories/stock_verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockVerificationAddEditController extends GetxController {
  final _repo = StockVerificationRepository();
  final _productRepo = ProductRepository();

  final formKey = GlobalKey<FormState>();
  StockVerificationModel? stockVerification;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  // Items
  var items = <StockVerificationItem>[].obs;
  var products = <ProductDropdownModel>[].obs;
  
  // Totals
  RxDouble totalProducts = 0.0.obs;
  RxDouble totalPhysicalQty = 0.0.obs;
  RxDouble totalDifferenceAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    if (Get.arguments is StockVerificationModel) {
      stockVerification = Get.arguments;
      isEdit.value = true;
      loadStockVerificationData();
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      products.value = await _productRepo.getProductDropdown();
    } catch (e) {
      Log.e("Fetch Products Error", e);
    } finally {
      isLoading.value = false;
    }
  }

  void loadStockVerificationData() {
    if (stockVerification == null) return;
    
    items.value = List.from(stockVerification!.items);
    calculateTotals();
  }

  void addProduct(ProductDropdownModel product) {
    // Check if product already exists
    if (items.any((item) => item.productId.id == product.id)) {
      AppSnackbar.warning("Product already added");
      return;
    }

    final newItem = StockVerificationItem(
      productId: IdNameModel(id: product.id, name: product.name),
      landingCost: product.landingCost,
      price: product.purchasePrice.toDouble(),
      mrp: product.mrp,
      sellingPrice: product.sellingPrice,
      systemQty: product.qty,
      physicalQty: product.qty, // Default to system qty
      differenceQty: 0.0,
      differenceAmount: 0.0,
    );

    items.add(newItem);
    calculateTotals();
  }

  void removeProduct(int index) {
    items.removeAt(index);
    calculateTotals();
  }

  void updatePhysicalQty(int index, String value) {
    final qty = double.tryParse(value) ?? 0.0;
    final item = items[index];
    
    final differenceQty = qty - item.systemQty;
    final differenceAmount = differenceQty * item.price;

    items[index] = item.copyWith(
      physicalQty: qty,
      differenceQty: differenceQty,
      differenceAmount: differenceAmount,
    );
    
    calculateTotals();
  }

  void calculateTotals() {
    totalProducts.value = items.length.toDouble();
    totalPhysicalQty.value = items.fold(0.0, (sum, item) => sum + item.physicalQty);
    totalDifferenceAmount.value = items.fold(0.0, (sum, item) => sum + item.differenceAmount);
  }

  Future<void> save() async {
    if (items.isEmpty) {
      AppSnackbar.error("Please add at least one product");
      return;
    }

    try {
      isSaving.value = true;

      final Map<String, dynamic> data = {
        "items": items.map((item) => {
          "productId": item.productId.id,
          "landingCost": item.landingCost,
          "price": item.price,
          "mrp": item.mrp,
          "sellingPrice": item.sellingPrice,
          "systemQty": item.systemQty,
          "physicalQty": item.physicalQty,
          "differenceQty": item.differenceQty,
          "differenceAmount": item.differenceAmount,
        }).toList(),
        "totalProducts": totalProducts.value,
        "totalPhysicalQty": totalPhysicalQty.value,
        "totalDifferenceAmount": totalDifferenceAmount.value,
        "status": stockVerification?.status ?? "pending",
      };

      bool success;
      if (isEdit.value) {
        data["_id"] = stockVerification!.id;
        success = await _repo.updateStockVerification(data);
      } else {
        success = await _repo.addStockVerification(data);
      }

      if (success) {
        Get.back(result: true);
        AppSnackbar.success("Stock Verification saved successfully");
      } else {
        AppSnackbar.error("Failed to save Stock Verification");
      }
    } catch (e) {
      Log.e("Stock Verification Error", e);
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<List<ProductDropdownModel>> searchProducts(String query) async {
    try {
      // In a real app, this might be a paginated search. 
      // For now, we'll use the dropdown repo if it supports search, 
      // or fetch all and filter.
      final products = await _productRepo.getProductDropdown();
      if (query.isEmpty) return products;
      return products.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    } catch (e) {
      Log.e("Search Product Error", e);
      return [];
    }
  }
}
