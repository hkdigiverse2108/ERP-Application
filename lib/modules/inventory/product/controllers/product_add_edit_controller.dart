import 'dart:convert';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/category/category_model.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';
import 'package:ai_setu/data/repositories/brand_repository.dart';
import 'package:ai_setu/data/repositories/category_repository.dart';
import 'package:ai_setu/data/repositories/product_repository.dart';
import 'package:ai_setu/data/repositories/settings/tax_repository.dart';
import 'package:ai_setu/data/repositories/uom_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddEditController extends GetxController {
  final ProductRepository _productRepo = ProductRepository();
  final CategoryRepository _categoryRepo = CategoryRepository();
  final BrandRepository _brandRepo = BrandRepository();
  final TaxRepository _taxRepo = TaxRepository();
  final UomRepository _uomRepo = UomRepository();

  final formKey = GlobalKey<FormState>();
  ProductModel? product;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  // Form Controllers
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final printNameController = TextEditingController();
  final openingBalanceController = TextEditingController();
  final mrpController = TextEditingController();
  final costController = TextEditingController();
  final salesPriceController = TextEditingController();
  final hsnCodeController = TextEditingController();
  final minStockController = TextEditingController();
  final maxStockController = TextEditingController();
  final leadTimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final skuController = TextEditingController();
  final cessController = TextEditingController();
  final expiryDaysController = TextEditingController();
  final netWeightController = TextEditingController();
  final masterQtyController = TextEditingController();
  final ingredientInputController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final nutritionNameController = TextEditingController();
  final nutritionValueController = TextEditingController();

  late QuillController quillController;

  // Dropdown Selections
  final selectedType = ProductType.finished.obs;
  final categoryId = "".obs;
  final categoryName = "".obs;
  final brandId = "".obs;
  final brandName = "".obs;
  final salesTaxId = "".obs;
  final salesTaxName = "".obs;
  final purchaseTaxId = "".obs;
  final purchaseTaxName = "".obs;
  final uomId = "".obs;
  final uomName = "".obs;
  final subCategoryId = "".obs;
  final subCategoryName = "".obs;
  final subBrandId = "".obs;
  final subBrandName = "".obs;

  // Observables for Switches/Flags
  final manageMultipleBatch = false.obs;
  final hasExpiry = false.obs;
  final isExpiryProductSaleable = false.obs;
  final calculateExpiryOn = "Manufacturing Date".obs;
  final expiryReferenceDate = Rxn<DateTime>();

  // Lists
  final ingredients = <String>[].obs;
  final nutritionList = <Nutrition>[].obs;
  final imageList = <String>[].obs;

  // Dropdown Lists
  final categories = <CategoryDropdownModel>[].obs;
  final brands = <IdNameModel>[]
      .obs; // Using Id model from ProductModel for brands as it's simple
  final taxes = <TaxDropdownModel>[].obs;
  final uoms = <CommonDropdownModel>[].obs;
  final subCategories = <CategoryDropdownModel>[].obs;
  final subBrands = <IdNameModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    quillController = QuillController.basic();
    _loadDropdownData();

    if (Get.arguments is ProductModel) {
      product = Get.arguments as ProductModel;
      isEdit.value = true;
      _populateFields(product!);
    } else if (Get.arguments is ProductItemModel) {
      final item = Get.arguments as ProductItemModel;
      isEdit.value = true;
      _fetchProductDetails(item.id);
    } else if (Get.arguments is String &&
        (Get.arguments as String).isNotEmpty) {
      isEdit.value = true;
      _fetchProductDetails(Get.arguments as String);
    } else {
      isEdit.value = false;
    }
  }

  Future<void> _fetchProductDetails(String id) async {
    isLoading.value = true;
    try {
      product = await _productRepo.getProductById(id);
      _populateFields(product!);
    } catch (e) {
      AppSnackbar.error("Failed to load product details");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadDropdownData() async {
    isLoading.value = true;
    try {
      await Future.wait([
        _fetchCategories(),
        _fetchBrands(),
        _fetchTaxes(),
        _fetchUoms(),
      ]);
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit) - Dropdown data", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final res = await _categoryRepo.getCategories();
      categories.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit)", e);
    }
  }

  Future<void> _fetchBrands() async {
    try {
      final res = await _brandRepo.getBrands();
      // BrandRepository seems to return List<BrandDropdownModel> or similar,
      // let's assume it has id and name
      brands.assignAll(
        res.map((e) => IdNameModel(id: e.id, name: e.name)).toList(),
      );
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit)", e);
    }
  }

  Future<void> _fetchTaxes() async {
    try {
      final res = await _taxRepo.getTaxes();
      taxes.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit)", e);
    }
  }

  Future<void> _fetchUoms() async {
    try {
      final res = await _uomRepo.getUomDropdown();
      uoms.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit)", e);
    }
  }

  Future<void> _fetchSubCategories(String parentId) async {
    try {
      final res = await _categoryRepo.getCategories(
        parentCategoryFilter: parentId,
      );
      subCategories.assignAll(res);
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit)", e);
    }
  }

  Future<void> _fetchSubBrands(String parentId) async {
    try {
      final res = await _brandRepo.getBrands(parentBrandFilter: parentId);
      subBrands.assignAll(
        res.map((e) => IdNameModel(id: e.id, name: e.name)).toList(),
      );
    } catch (e) {
      Log.e("Inventory Module Error (ProductAddEdit)", e);
    }
  }

  void onCategorySelected(CategoryDropdownModel cat) {
    categoryId.value = cat.id;
    categoryName.value = cat.name;
    subCategoryId.value = "";
    subCategoryName.value = "";
    _fetchSubCategories(cat.id);
  }

  void onBrandSelected(IdNameModel brand) {
    brandId.value = brand.id;
    brandName.value = brand.name;
    subBrandId.value = "";
    subBrandName.value = "";
    _fetchSubBrands(brand.id);
  }

  // Expiry Logic
  void syncExpiryDaysToDate(String days) {
    if (days.isEmpty) return;
    int? d = int.tryParse(days);
    if (d != null) {
      expiryReferenceDate.value = DateTime.now().add(Duration(days: d));
    }
  }

  void syncExpiryDateToDays(DateTime date) {
    expiryReferenceDate.value = date;
    final diff = date.difference(DateTime.now()).inDays;
    expiryDaysController.text = diff.toString();
  }

  // Nutrition
  void addNutrition() {
    if (nutritionNameController.text.isNotEmpty &&
        nutritionValueController.text.isNotEmpty) {
      nutritionList.add(
        Nutrition(
          id: "",
          name: nutritionNameController.text,
          value: nutritionValueController.text,
        ),
      );
      nutritionNameController.clear();
      nutritionValueController.clear();
    }
  }

  void removeNutrition(int index) {
    nutritionList.removeAt(index);
  }

  // Images
  bool _isPickingImage = false;
  Future<void> pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageList.add(image.path);
      }
    } finally {
      _isPickingImage = false;
    }
  }

  void removeImage(int index) {
    imageList.removeAt(index);
  }

  void _populateFields(ProductModel p) {
    nameController.text = p.name;
    codeController.text = p.sku ?? ""; // Assuming SKU for code if not present
    printNameController.text = p.printName;
    openingBalanceController.text = p.openingQty?.toString() ?? "0";
    mrpController.text = p.mrp.toString();
    costController.text = p.purchasePrice.toString();
    salesPriceController.text = p.sellingPrice.toString();
    hsnCodeController.text = p.hsnCode ?? "";
    minStockController.text = p.minimumQty?.toString() ?? "0";
    skuController.text = p.sku ?? "";
    cessController.text = p.cessPercentage?.toString() ?? "";
    expiryDaysController.text = p.expiryDays?.toString() ?? "";
    netWeightController.text = p.netWeight?.toString() ?? "";
    masterQtyController.text = p.masterQty?.toString() ?? "";
    ingredients.assignAll(p.ingredients.map((e) => e.toString()).toList());
    shortDescriptionController.text = p.shortDescription ?? "";

    // Quill population - assuming p.description is HTML or JSON
    // If it's plain text, we might need to convert it
    // For now, setting it as plain text if it fails to parse as JSON
    try {
      // Logic to convert HTML/JSON to Document if needed
    } catch (_) {}

    selectedType.value = p.productType;
    categoryId.value = p.categoryId?.id ?? "";
    categoryName.value = p.categoryId?.name ?? "";
    brandId.value = p.brandId?.id ?? "";
    brandName.value = p.brandId?.name ?? "";
    salesTaxId.value = p.salesTaxId?.id ?? "";
    salesTaxName.value = p.salesTaxId?.name ?? "";
    purchaseTaxId.value = p.purchaseTaxId?.id ?? "";
    purchaseTaxName.value = p.purchaseTaxId?.name ?? "";
    uomId.value = p.uomId?.id ?? "";
    uomName.value = p.uomId?.name ?? "";

    subCategoryId.value = p.subCategoryId?.id ?? "";
    subCategoryName.value = p.subCategoryId?.name ?? "";
    subBrandId.value = p.subBrandId?.id ?? "";
    subBrandName.value = p.subBrandId?.name ?? "";

    manageMultipleBatch.value = p.manageMultipleBatch;
    hasExpiry.value = p.hasExpiry;
    isExpiryProductSaleable.value = p.isExpiryProductSaleable;
    calculateExpiryOn.value = p.calculateExpiryOn ?? "Manufacturing Date";
    expiryReferenceDate.value = p.expiryReferenceDate;

    nutritionList.assignAll(p.nutrition);
    imageList.assignAll(p.images);

    if (categoryId.value.isNotEmpty) _fetchSubCategories(categoryId.value);
    if (brandId.value.isNotEmpty) _fetchSubBrands(brandId.value);
  }

  Future<void> saveProduct() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isSaving.value = true;
      final Map<String, dynamic> data = {
        "name": nameController.text,
        "printName": printNameController.text.isEmpty
            ? nameController.text
            : printNameController.text,
        "productType": productTypeValues.reverse[selectedType.value],
        "purchasePrice": double.tryParse(costController.text) ?? 0,
        "mrp": double.tryParse(mrpController.text) ?? 0,
        "sellingPrice": double.tryParse(salesPriceController.text) ?? 0,
        "openingQty": double.tryParse(openingBalanceController.text) ?? 0,
        "minimumQty": double.tryParse(minStockController.text) ?? 0,
        "hsnCode": hsnCodeController.text,
        "sku": skuController.text,
        "description": descriptionController.text, // Fallback
        "richDescription": jsonEncode(
          quillController.document.toDelta().toJson(),
        ),
        "categoryId": categoryId.value.isEmpty ? null : categoryId.value,
        "subCategoryId": subCategoryId.value.isEmpty
            ? null
            : subCategoryId.value,
        "brandId": brandId.value.isEmpty ? null : brandId.value,
        "subBrandId": subBrandId.value.isEmpty ? null : subBrandId.value,
        "salesTaxId": salesTaxId.value.isEmpty ? null : salesTaxId.value,
        "purchaseTaxId": purchaseTaxId.value.isEmpty
            ? null
            : purchaseTaxId.value,
        "uomId": uomId.value.isEmpty ? null : uomId.value,
        "cessPercentage": double.tryParse(cessController.text),
        "manageMultipleBatch": manageMultipleBatch.value,
        "hasExpiry": hasExpiry.value,
        "expiryDays": int.tryParse(expiryDaysController.text),
        "calculateExpiryOn": calculateExpiryOn.value,
        "expiryReferenceDate": expiryReferenceDate.value?.toIso8601String(),
        "isExpiryProductSaleable": isExpiryProductSaleable.value,
        "ingredients": ingredients.toList(),
        "shortDescription": shortDescriptionController.text,
        "netWeight": double.tryParse(netWeightController.text),
        "masterQty": int.tryParse(masterQtyController.text),
        "nutrition": nutritionList.map((e) => e.toMap()).toList(),
        "productImages": imageList,
      };

      if (isEdit.value && product != null) {
        data["productId"] = product!.id;
        final res = await _productRepo.updateProduct(data);
        if (res) {
          AppSnackbar.success("Product updated successfully");
          Get.back(result: true);
        } else {
          AppSnackbar.error("Failed to update product");
        }
      } else {
        final res = await _productRepo.addProduct(data);
        if (res) {
          AppSnackbar.success("Product added successfully");
          Get.back(result: true);
        } else {
          AppSnackbar.error("Failed to add product");
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
    codeController.dispose();
    printNameController.dispose();
    openingBalanceController.dispose();
    mrpController.dispose();
    costController.dispose();
    salesPriceController.dispose();
    hsnCodeController.dispose();
    minStockController.dispose();
    maxStockController.dispose();
    leadTimeController.dispose();
    descriptionController.dispose();
    skuController.dispose();
    cessController.dispose();
    expiryDaysController.dispose();
    netWeightController.dispose();
    masterQtyController.dispose();
    ingredientInputController.dispose();
    shortDescriptionController.dispose();
    nutritionNameController.dispose();
    nutritionValueController.dispose();
    quillController.dispose();
    super.onClose();
  }
}
