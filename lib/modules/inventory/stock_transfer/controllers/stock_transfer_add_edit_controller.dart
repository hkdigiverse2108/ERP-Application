import 'dart:convert';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/invetory/stock_transfer_model.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/stock_transfer_repository.dart';
import 'package:ai_setu/data/repositories/settings/branch_repository.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTransferAddEditController extends GetxController {
  final _repository = StockTransferRepository();
  final _branchRepository = BranchRepository();
  final _productRepository = ProductRepository();

  final Rxn<StockTransferModel> existingTransfer = Rxn<StockTransferModel>();
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  // Form Fields
  final noteController = TextEditingController();
  final Rxn<BranchDropdownModel> selectedToBranch = Rxn<BranchDropdownModel>();
  final RxBool isActive = true.obs;

  // Items
  final RxList<StockTransferFormItem> items = <StockTransferFormItem>[].obs;

  // Dropdown Data
  final RxList<BranchDropdownModel> branches = <BranchDropdownModel>[].obs;
  final RxList<ProductDropdownModel> products = <ProductDropdownModel>[].obs;

  bool get isEdit => existingTransfer.value != null;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is StockTransferModel) {
      existingTransfer.value = Get.arguments as StockTransferModel;
    }
    loadDropdownData();
  }

  Future<void> loadDropdownData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _branchRepository.getBranchesDropdown(),
        _productRepository.getProductDropdown(),
      ]);

      // Get current branch ID to exclude it
      String? currentBranchId;
      final userData = StorageService.instance.read(StorageKeys.userData);
      if (userData != null) {
        if (userData is Map<String, dynamic>) {
          currentBranchId = userData['branchId'] is Map
              ? userData['branchId']['_id']
              : userData['branchId'];
        } else if (userData is String) {
          try {
            final decoded = jsonDecode(userData) as Map<String, dynamic>;
            currentBranchId = decoded['branchId'] is Map
                ? decoded['branchId']['_id']
                : decoded['branchId'];
          } catch (_) {}
        }
      }

      final allBranches = results[0] as List<BranchDropdownModel>;
      branches.value = allBranches
          .where((b) => b.id != currentBranchId)
          .toList();
      products.value = results[1] as List<ProductDropdownModel>;

      if (isEdit) {
        _populateFields();
        if (branches.isNotEmpty) {
          selectedToBranch.value = branches.firstWhereOrNull(
            (b) => b.id == existingTransfer.value?.requestedToBranchId?.id,
          );
        }
      }
    } catch (e) {
      Log.e("Error loading dropdown data", e);
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    final transfer = existingTransfer.value!;
    noteController.text = transfer.requestNote;
    isActive.value = transfer.isActive;

    items.value = transfer.items.map((item) {
      // Try to find current available quantity for this product
      final product = products.firstWhereOrNull(
        (p) => p.id == item.productId?.id,
      );

      return StockTransferFormItem(
        productId: item.productId?.id ?? '',
        productName: item.productId?.name ?? '',
        qty: item.requestedQty,
        price: item.price,
        availableQty: product?.qty ?? item.requestedQty,
      );
    }).toList();
  }

  void addItem() {
    items.add(StockTransferFormItem());
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  void updateItemProduct(int index, ProductDropdownModel product) {
    items[index] = items[index].copyWith(
      productId: product.id,
      productName: product.name,
      price: product.sellingPrice, // Use selling price by default
      availableQty: product.qty,
    );
  }

  Future<void> save() async {
    if (selectedToBranch.value == null) {
      AppSnackbar.error("Please select a target branch");
      return;
    }

    if (items.isEmpty) {
      AppSnackbar.error("Please add at least one item");
      return;
    }

    for (var item in items) {
      if (item.productId.isEmpty) {
        AppSnackbar.error("Please select a product for all items");
        return;
      }
      if (item.qty <= 0) {
        AppSnackbar.error("Quantity must be greater than zero");
        return;
      }
      if (item.qty > item.availableQty) {
        AppSnackbar.error(
          "Quantity for ${item.productName} exceeds available stock (${item.availableQty})",
        );
        return;
      }
    }

    try {
      isSaving.value = true;
      final payload = {
        "requestedToBranchId": selectedToBranch.value?.id,
        "requestNote": noteController.text,
        "isActive": isActive.value,
        "items": items
            .map(
              (item) => {
                "productId": item.productId,
                "requestedQty": item.qty,
                "price": item.price,
              },
            )
            .toList(),
      };

      bool success;
      if (isEdit) {
        payload["stockTransferId"] = existingTransfer.value!.id;
        success = await _repository.updateStockTransfer(payload);
      } else {
        success = await _repository.addStockTransfer(payload);
      }

      if (success) {
        await _refreshAndBack();
        AppSnackbar.success(
          "Stock transfer ${isEdit ? 'updated' : 'added'} successfully",
        );
      } else {
        AppSnackbar.error("Failed to save stock transfer");
      }
    } catch (e) {
      Log.e("Error saving stock transfer", e);
      AppSnackbar.error("An error occurred while saving");
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  Future<void> _refreshAndBack() async {
    final stockTransferController =
        Get.isRegistered<StockTransferController>()
            ? Get.find<StockTransferController>()
            : null;

    if (stockTransferController != null) {
      await stockTransferController.refreshData();
    }
    Get.back(result: true);
  }
}

class StockTransferFormItem {
  final String productId;
  final String productName;
  final double qty;
  final double price;
  final double availableQty;

  StockTransferFormItem({
    this.productId = '',
    this.productName = '',
    this.qty = 1.0,
    this.price = 0.0,
    this.availableQty = 0.0,
  });

  StockTransferFormItem copyWith({
    String? productId,
    String? productName,
    double? qty,
    double? price,
    double? availableQty,
  }) {
    return StockTransferFormItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      availableQty: availableQty ?? this.availableQty,
    );
  }
}
