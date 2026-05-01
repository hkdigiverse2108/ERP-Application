import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/inventory/material_consumption_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/settings/consumption_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialConsumptionAddEditController extends GetxController {
  final _repo = MaterialConsumptionRepository();
  final _productRepo = ProductRepository();
  final _consumptionTypeRepo = ConsumptionTypeRepository();

  final formKey = GlobalKey<FormState>();
  MaterialConsumptionModel? materialConsumption;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  // General Information
  final date = Rxn<DateTime>();
  final remarkController = TextEditingController();
  final selectedConsumptionType = Rxn<IdNameModel>();

  // Items
  final items = <MaterialConsumptionItem>[].obs;

  // Dropdown data
  final products = <ProductDropdownModel>[].obs;
  final consumptionTypes = <IdNameModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    date.value = DateTime.now();
    _loadInitialData();

    if (Get.arguments is MaterialConsumptionModel) {
      materialConsumption = Get.arguments as MaterialConsumptionModel;
      isEdit.value = true;
      _populateFields(materialConsumption!);
    } else if (Get.arguments is String &&
        (Get.arguments as String).isNotEmpty) {
      isEdit.value = true;
      _fetchDetails(Get.arguments as String);
    } else {
      isEdit.value = false;
    }
  }

  Future<void> _loadInitialData() async {
    try {
      final productList = await _productRepo.getProductDropdown();
      products.assignAll(productList);

      final typeList = await _consumptionTypeRepo.getConsumptionTypes(
        limit: 100,
      );
      consumptionTypes.assignAll(
        typeList.items.map((e) => IdNameModel(id: e.id, name: e.name)).toList(),
      );
    } catch (e) {
      Log.e(
        "MaterialConsumptionAddEditController - Error loading initial data",
        e,
      );
    }
  }

  Future<void> _fetchDetails(String id) async {
    isLoading.value = true;
    try {
      materialConsumption = await _repo.getMaterialConsumptionById(id);
      _populateFields(materialConsumption!);
    } catch (e) {
      AppSnackbar.error("Failed to load details");
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields(MaterialConsumptionModel mc) {
    date.value = mc.date;
    remarkController.text = mc.remark ?? "";
    selectedConsumptionType.value = mc.consumptionTypeId;
    items.assignAll(mc.items);
  }

  void addItem(ProductDropdownModel product) {
    if (items.any((e) => e.productId.id == product.id)) {
      AppSnackbar.warning("${product.name} is already added");
      return;
    }
    items.add(
      MaterialConsumptionItem(
        productId: IdNameModel(id: product.id, name: product.name),
        qty: 1,
        price: product.mrp,
        totalPrice: product.mrp,
      ),
    );
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  void updateItemQty(int index, String val) {
    final qty = double.tryParse(val) ?? 0;
    final item = items[index];
    items[index] = item.copyWith(qty: qty, totalPrice: qty * item.price);
  }

  void updateItemPrice(int index, String val) {
    final price = double.tryParse(val) ?? 0;
    final item = items[index];
    items[index] = item.copyWith(price: price, totalPrice: item.qty * price);
  }

  double get totalQty => items.fold(0, (sum, item) => sum + item.qty);
  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalPrice);

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (selectedConsumptionType.value == null) {
      AppSnackbar.error("Please select a consumption type");
      return;
    }

    if (items.isEmpty) {
      AppSnackbar.error("Please add at least one item");
      return;
    }

    try {
      isSaving.value = true;
      final Map<String, dynamic> data = {
        "date": date.value?.toIso8601String(),
        "consumptionTypeId": selectedConsumptionType.value?.id,
        "remark": remarkController.text,
        "items": items
            .map(
              (e) => {
                "productId": e.productId.id,
                "qty": e.qty,
                "price": e.price,
                "totalPrice": e.totalPrice,
              },
            )
            .toList(),
        "totalQty": totalQty,
        "totalAmount": totalAmount,
      };

      bool success;
      if (isEdit.value && materialConsumption != null) {
        data["materialConsumptionId"] = materialConsumption!.id;
        success = await _repo.updateMaterialConsumption(data);
      } else {
        success = await _repo.addMaterialConsumption(data);
      }

      if (success) {
        Get.back(result: true);
        AppSnackbar.success("Material Consumption saved successfully");
      } else {
        AppSnackbar.error("Failed to save Material Consumption");
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    remarkController.dispose();
    super.onClose();
  }
}

