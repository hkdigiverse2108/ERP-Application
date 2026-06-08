import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/invetory/recipe_model.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/recipe_repository.dart';
import 'package:ai_setu/modules/inventory/recipe/controllers/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeAddEditController extends GetxController {
  final RecipeRepository _recipeRepo = RecipeRepository();
  final ProductRepository _productRepo = ProductRepository();

  final formKey = GlobalKey<FormState>();
  RecipeModel? recipe;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxBool isActive = true.obs;

  // General Information
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final recipeDate = Rxn<DateTime>();
  Rx<RecipeType> recipeType = RecipeType.assemble.obs;

  // Final Product
  final finalProductId = "".obs;
  final finalProductName = "".obs;
  String? finalProductVariantId;
  final finalProductQtyController = TextEditingController(text: "0");
  final finalProductMrpController = TextEditingController(text: "0");

  // Raw Materials (Ingredients)
  final rawProducts = <RawProductItem>[].obs;

  // Selection/Search temporary state
  final products = <ProductDropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    recipeDate.value = DateTime.now();
    _loadProducts();

    if (Get.arguments is RecipeModel) {
      recipe = Get.arguments as RecipeModel;
      isEdit.value = true;
      _populateFields(recipe!);
    } else if (Get.arguments is String &&
        (Get.arguments as String).isNotEmpty) {
      isEdit.value = true;
      _fetchRecipeDetails(Get.arguments as String);
    } else {
      isEdit.value = false;
    }
  }

  Future<void> _loadProducts() async {
    try {
      final res = await _productRepo.getProductDropdown(isNewProduct: false);
      products.assignAll(res);
    } catch (e) {
      Log.e("RecipeAddEditController - Error loading products", e);
    }
  }

  Future<void> _fetchRecipeDetails(String id) async {
    isLoading.value = true;
    try {
      recipe = await _recipeRepo.getRecipeById(id);
      _populateFields(recipe!);
    } catch (e) {
      AppSnackbar.error("Failed to load recipe details");
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields(RecipeModel r) {
    nameController.text = r.name;
    numberController.text = r.number;
    recipeDate.value = r.date;
    recipeType.value = r.type == "assemble"
        ? RecipeType.assemble
        : RecipeType.unassemble;
    isActive.value = r.isActive;

    if (r.finalProducts.productId != null) {
      finalProductId.value = r.finalProducts.productId!.id;
      finalProductName.value = r.finalProducts.productId!.name;
      finalProductQtyController.text = r.finalProducts.qtyGenerate.toString();
      finalProductMrpController.text = r.finalProducts.mrp.toString();
    }

    rawProducts.assignAll(
      r.rawProducts
          .map(
            (rp) => RawProductItem(
              id: rp.id,
              productId: rp.productId?.id ?? "",
              productName: rp.productId?.name ?? "",
              qty: rp.useQty,
              mrp: rp.mrp,
              variantId: rp.variantId,
            ),
          )
          .toList(),
    );
  }

  void addIngredient(ProductDropdownModel product) {
    if (rawProducts.any((e) => e.productId == product.id)) {
      AppSnackbar.warning("${product.name} is already added");
      return;
    }
    rawProducts.add(
      RawProductItem(
        productId: product.hasVariant ? product.productId! : product.id,
        productName: product.name,
        qty: 1,
        mrp: product.mrp,
        variantId: product.hasVariant ? product.id : null,
      ),
    );
  }

  void removeIngredient(int index) {
    rawProducts.removeAt(index);
  }

  void updateIngredientQty(int index, String val) {
    final qty = double.tryParse(val) ?? 0;
    rawProducts[index] = rawProducts[index].copyWith(qty: qty);
  }

  void setFinalProduct(ProductDropdownModel product) {
    finalProductId.value = product.hasVariant ? product.productId! : product.id;
    finalProductName.value = product.name;
    finalProductVariantId = product.hasVariant ? product.id : null;
    finalProductMrpController.text = "0"; // MRP not available
  }

  Future<void> saveRecipe() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (finalProductId.value.isEmpty) {
      AppSnackbar.error("Please select a final product");
      return;
    }

    if (rawProducts.isEmpty) {
      AppSnackbar.error("Please add at least one ingredient");
      return;
    }

    try {
      isSaving.value = true;
      final Map<String, dynamic> data = {
        "name": nameController.text,
        "date": recipeDate.value?.toIso8601String(),
        "type": recipeType.value.name,
        "isActive": isActive.value,
        "finalProducts": {
          "productId": finalProductId.value,
          "qtyGenerate": double.tryParse(finalProductQtyController.text) ?? 0,
          "mrp": double.tryParse(finalProductMrpController.text) ?? 0,
          "variantId": finalProductVariantId,
        },
        "rawProducts": rawProducts
            .map(
              (e) => {
                "productId": e.productId,
                "useQty": e.qty,
                "mrp": e.mrp,
                "variantId": e.variantId,
              },
            )
            .toList(),
      };

      if (isEdit.value && recipe != null) {
        data["recipeId"] = recipe!.id;
        final res = await _recipeRepo.updateRecipe(data);
        if (res) {
          await _refreshAndBack();
          AppSnackbar.success("Recipe updated successfully");
        } else {
          AppSnackbar.error("Failed to update recipe");
        }
      } else {
        final res = await _recipeRepo.addRecipe(data);
        if (res) {
          await _refreshAndBack();
          AppSnackbar.success("Recipe added successfully");
        } else {
          AppSnackbar.error("Failed to add recipe");
        }
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    numberController.dispose();
    finalProductQtyController.dispose();
    finalProductMrpController.dispose();
    products.clear();
    super.onClose();
  }

  Future<void> _refreshAndBack() async {
    final recipeController = Get.isRegistered<RecipeController>()
        ? Get.find<RecipeController>()
        : null;

    if (recipeController != null) {
      await recipeController.refreshData();
    }
    Get.back(result: true);
  }
}

class RawProductItem {
  final String id;
  final String productId;
  final String productName;
  final double qty;
  final double mrp;
  final String? variantId;

  RawProductItem({
    this.id = "",
    required this.productId,
    required this.productName,
    required this.qty,
    required this.mrp,
    this.variantId,
  });

  RawProductItem copyWith({
    String? id,
    String? productId,
    String? productName,
    double? qty,
    double? mrp,
    String? variantId,
  }) {
    return RawProductItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      qty: qty ?? this.qty,
      mrp: mrp ?? this.mrp,
      variantId: variantId ?? this.variantId,
    );
  }
}
