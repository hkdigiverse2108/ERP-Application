import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/inventory/bill_of_live_product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/inventory/recipe_repository.dart';
import 'package:ai_setu/data/model/invetory/recipe_model.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/controllers/bill_of_live_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillOfLiveProductAddEditController extends GetxController {
  final BillOfLiveProductRepository _repo = BillOfLiveProductRepository();
  final ProductRepository _productRepo = ProductRepository();
  final RecipeRepository _recipeRepo = RecipeRepository();

  final formKey = GlobalKey<FormState>();
  BillOfLiveProductModel? bom;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxBool isActive = true.obs;

  // General Information
  final numberController = TextEditingController();
  final date = Rxn<DateTime>();
  RxBool allowReverseCalculation = false.obs;

  // Product Details
  final productDetails = <ProductDetailItem>[].obs;
  final recipes = <RecipeModel>[].obs;
  final selectedRecipeIds = <String>[].obs;

  // Selection/Search temporary state
  final products = <ProductDropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    date.value = DateTime.now();
    _loadProducts();
    _loadRecipes();

    if (Get.arguments is BillOfLiveProductModel) {
      bom = Get.arguments as BillOfLiveProductModel;
      isEdit.value = true;
      _populateFields(bom!);
    } else {
      isEdit.value = false;
    }
  }

  Future<void> _loadProducts() async {
    try {
      final res = await _productRepo.getProductDropdown(isNewProduct: false);
      products.assignAll(res);
    } catch (e) {
      Log.e("BillOfLiveProductAddEditController - Error loading products", e);
    }
  }

  Future<void> _loadRecipes() async {
    try {
      final res = await _recipeRepo.getRecipeList();
      recipes.assignAll(res.items);
    } catch (e) {
      Log.e("BillOfLiveProductAddEditController - Error loading recipes", e);
    }
  }

  void onRecipeChanged(List<String> ids) {
    selectedRecipeIds.assignAll(ids);

    // Auto-populate products from recipes
    productDetails.clear();
    for (var id in ids) {
      final recipe = recipes.firstWhereOrNull((e) => e.id == id);
      if (recipe != null && recipe.finalProducts.productId != null) {
        final finalProd = recipe.finalProducts;

        final newItem = ProductDetailItem(
          productId: finalProd.productId!.id,
          productName: finalProd.productId!.name,
          qty: finalProd.qtyGenerate,
          purchasePrice: 0, // Not directly in RecipeModel, default to 0
          mrp: finalProd.mrp,
          sellingPrice: finalProd.mrp,
          mfgDate: DateTime.now(),
          expiryDays: 0,
          ingredients: recipe.rawProducts
              .map(
                (rp) => IngredientItem(
                  productId: rp.productId?.id ?? "",
                  productName: rp.productId?.name ?? "",
                  availableQty: 0,
                  useQty: rp.useQty,
                ),
              )
              .toList(),
        );

        productDetails.add(newItem);
      }
    }
  }

  void _populateFields(BillOfLiveProductModel b) {
    numberController.text = b.number;
    date.value = b.date;
    allowReverseCalculation.value = b.allowReverseCalculation;
    isActive.value = b.isActive;
    selectedRecipeIds.assignAll(b.recipeId.map((e) => e.id));

    productDetails.assignAll(
      b.productDetails.map((pd) => ProductDetailItem.fromModel(pd)).toList(),
    );
  }

  void addProduct(ProductDropdownModel product) {
    if (productDetails.any((e) => e.productId == product.id)) {
      AppSnackbar.warning("${product.name} is already added");
      return;
    }
    productDetails.add(
      ProductDetailItem(
        productId: product.id,
        productName: product.name,
        qty: 1,
        purchasePrice: product.purchasePrice,
        mrp: product.mrp,
        sellingPrice: product.mrp,
        mfgDate: DateTime.now(),
        expiryDays: 0,
        ingredients: [],
      ),
    );
  }

  void updateProductQty(int index, String value) {
    final qty = double.tryParse(value) ?? 0;
    final item = productDetails[index];

    if (allowReverseCalculation.value && item.qty > 0) {
      final ratio = qty / item.qty;
      for (var ingredient in item.ingredients) {
        ingredient.useQty *= ratio;
      }
    }

    item.qty = qty;
    productDetails.refresh();
  }

  void removeProduct(int index) {
    productDetails.removeAt(index);
  }

  void addIngredientToProduct(
    int productIndex,
    ProductDropdownModel ingredient,
  ) {
    final product = productDetails[productIndex];
    if (product.ingredients.any((e) => e.productId == ingredient.id)) {
      AppSnackbar.warning(
        "${ingredient.name} is already added as an ingredient",
      );
      return;
    }

    product.ingredients.add(
      IngredientItem(
        productId: ingredient.id,
        productName: ingredient.name,
        availableQty: 0, // Should be fetched or 0
        useQty: 1,
      ),
    );
    productDetails.refresh();
  }

  void removeIngredientFromProduct(int productIndex, int ingredientIndex) {
    productDetails[productIndex].ingredients.removeAt(ingredientIndex);
    productDetails.refresh();
  }

  Future<void> saveBOM() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (productDetails.isEmpty) {
      AppSnackbar.error("Please add at least one product");
      return;
    }

    try {
      isSaving.value = true;
      final Map<String, dynamic> data = {
        "date": date.value?.toIso8601String(),
        // "number": numberController.text,
        "allowReverseCalculation": allowReverseCalculation.value,
        "isActive": isActive.value,
        "recipeId": selectedRecipeIds,
        "productDetails": productDetails.map((pd) => pd.toMap()).toList(),
      };

      if (isEdit.value && bom != null) {
        data["billOfLiveProductId"] = bom!.id;
        final res = await _repo.updateBillOfLiveProduct(data);
        if (res.status == 200) {
          AppSnackbar.success("BOM updated successfully");
          await _refreshAndBack();
        } else {
          AppSnackbar.error(res.message ?? "Failed to update BOM");
        }
      } else {
        final res = await _repo.addBillOfLiveProduct(data);
        if (res.status == 200) {
          AppSnackbar.success("BOM added successfully");
          await _refreshAndBack();
        } else {
          AppSnackbar.error(res.message ?? "Failed to add BOM");
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
    numberController.dispose();
    super.onClose();
  }

  Future<void> _refreshAndBack() async {
    final billOfLiveProductController =
        Get.isRegistered<BillOfLiveProductController>()
        ? Get.find<BillOfLiveProductController>()
        : null;

    if (billOfLiveProductController != null) {
      await billOfLiveProductController.refreshData();
    }
    Get.back(result: true);
  }
}

class ProductDetailItem {
  final String id;
  final String productId;
  final String productName;
  double qty;
  double purchasePrice;
  double landingCost;
  double mrp;
  double sellingPrice;
  DateTime mfgDate;
  int expiryDays;
  final List<IngredientItem> ingredients;

  ProductDetailItem({
    this.id = "",
    required this.productId,
    required this.productName,
    required this.qty,
    required this.purchasePrice,
    this.landingCost = 0,
    required this.mrp,
    required this.sellingPrice,
    required this.mfgDate,
    required this.expiryDays,
    required this.ingredients,
  });

  factory ProductDetailItem.fromModel(ProductDetail pd) {
    return ProductDetailItem(
      id: pd.id,
      productId: pd.productId.id,
      productName: pd.productId.name,
      qty: pd.qty,
      purchasePrice: pd.purchasePrice,
      landingCost: pd.landingCost,
      mrp: pd.mrp,
      sellingPrice: pd.sellingPrice,
      mfgDate: pd.mfgDate,
      expiryDays: pd.expiryDays,
      ingredients: pd.ingredients
          .map((i) => IngredientItem.fromModel(i))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    "productId": productId,
    "qty": qty,
    "purchasePrice": purchasePrice,
    "landingCost": landingCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "mfgDate": mfgDate.toIso8601String(),
    "expiryDays": expiryDays,
    "ingredients": ingredients.map((i) => i.toMap()).toList(),
  };
}

class IngredientItem {
  final String id;
  final String productId;
  final String productName;
  double availableQty;
  double useQty;

  IngredientItem({
    this.id = "",
    required this.productId,
    required this.productName,
    required this.availableQty,
    required this.useQty,
  });

  factory IngredientItem.fromModel(Ingredient i) {
    return IngredientItem(
      id: i.id,
      productId: i.productId.id,
      productName: i.productId.name,
      availableQty: i.availableQty,
      useQty: i.useQty,
    );
  }

  Map<String, dynamic> toMap() => {
    "productId": productId,
    "availableQty": availableQty,
    "useQty": useQty,
  };
}
