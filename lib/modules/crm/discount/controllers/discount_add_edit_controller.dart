import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/model/brand/brand_model.dart';
import 'package:ai_setu/data/model/category/category_model.dart';
import 'package:ai_setu/data/model/crm/discount_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/settings/branch_repository.dart';
import 'package:ai_setu/data/repositories/inventory/brand_repository.dart';
import 'package:ai_setu/data/repositories/inventory/category_repository.dart';
import 'package:ai_setu/data/repositories/crm/discount_repository.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/modules/crm/discount/controllers/discount_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DiscountAddEditController extends GetxController {
  final DiscountRepository _repository = DiscountRepository();
  final BranchRepository _branchRepo = BranchRepository();
  final CategoryRepository _categoryRepo = CategoryRepository();
  final BrandRepository _brandRepo = BrandRepository();
  final ProductRepository _productRepo = ProductRepository();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form Fields
  final titleController = TextEditingController();
  final codeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  // Normal Mode Fields
  final discountValueController = TextEditingController();

  // Range Wise Fields
  final RxList<RangeWiseRule> rangeRules = <RangeWiseRule>[].obs;

  // Buy X Get Y Fields
  final buyQtyController = TextEditingController();
  final getQtyController = TextEditingController();
  final getDiscountValueController = TextEditingController();
  final RxList<String> getProductIds = <String>[].obs;

  // Product At Fix Amount Fields
  final minAmountController = TextEditingController();
  final freeQtyController = TextEditingController(text: "1");
  final RxList<String> freeProductIds = <String>[].obs;

  // Requirements
  final minRequirementValueController = TextEditingController();

  // Usage Limits
  final usageLimitController = TextEditingController();
  final userLimitController = TextEditingController();

  // Dropdown Data
  final RxList<BranchDropdownModel> branches = <BranchDropdownModel>[].obs;
  final RxList<CategoryDropdownModel> categories =
      <CategoryDropdownModel>[].obs;
  final RxList<BrandDropdownModel> brands = <BrandDropdownModel>[].obs;
  final RxList<ProductDropdownModel> products = <ProductDropdownModel>[].obs;

  // Observables for Dropdowns
  final RxList<String> selectedBranches = <String>[].obs;
  final RxBool hasEndDate = true.obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<String> selectedBrands = <String>[].obs;
  final RxList<String> selectedProducts = <String>[].obs;
  final RxList<String> excludeProducts = <String>[].obs;

  // UI Toggles
  final RxBool isLoading = false.obs;
  final RxBool isEdit = false.obs;
  final RxBool autoApply = false.obs;
  final RxBool excludeAlreadyDiscounted = false.obs;
  final RxBool isOneTimeUsage = false.obs;

  // Enums/Strings for visibility
  final RxString discountApplicable = 'product_wise'.obs;
  final RxString discountMode = 'normal'.obs;
  final RxString appliesTo = 'specific_category'.obs;
  final RxString minimumRequirement = 'none'.obs;
  final RxString discountType = 'percentage'.obs;
  final RxString getDiscountType = 'percentage'.obs;

  final Map<String, String> discountApplicableOptions = {
    "Product Wise": "product_wise",
    "Entire Bill": "entire_bill",
  };

  final Map<String, String> discountModeOptions = {
    "Normal": "normal",
    "Range Wise": "range_wise",
    "Buy X Get Y": "buy_x_get_y",
    "Product At Fix Amount": "product_at_fix_amount",
  };

  final Map<String, String> appliesToOptions = {
    "Specific Category": "specific_category",
    "Specific Brand": "specific_brand",
    "Specific Products": "specific_products",
  };

  final Map<String, String> minRequirementOptions = {
    "None": "none",
    "Minimum Purchase Amount": "min_purchase_amount",
    "Minimum Quantity": "min_quantity",
  };

  final List<String> discountTypeOptions = ["percentage", "flat"];

  DiscountModel? existingDiscount;

  @override
  void onInit() {
    super.onInit();
    _fetchDropdownData();

    // Check for arguments (Model passed from list) or parameters (ID passed via URL)
    final arg = Get.arguments;
    final paramId = Get.parameters['id'];

    if (arg != null && arg is DiscountModel) {
      isEdit.value = true;
      existingDiscount = arg;
      _populateFields(arg);
    } else if (paramId != null) {
      isEdit.value = true;
      _loadDiscount(paramId);
    }

    // --- WORKERS ---
    ever(discountApplicable, (val) {
      if (val == 'entire_bill') {
        discountMode.value = 'normal';
      }
    });

    // Default dates for new discount
    if (!isEdit.value) {
      startDateController.text = DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now());
      startTimeController.text = DateFormat('HH:mm:ss').format(DateTime.now());
    }
  }

  Future<void> _fetchDropdownData() async {
    try {
      final results = await Future.wait([
        _branchRepo.getBranchesDropdown(),
        _categoryRepo.getCategories(),
        _brandRepo.getBrands(),
        _productRepo.getProductDropdown(),
      ]);

      branches.assignAll(results[0] as List<BranchDropdownModel>);
      categories.assignAll(results[1] as List<CategoryDropdownModel>);
      brands.assignAll(results[2] as List<BrandDropdownModel>);
      products.assignAll(results[3] as List<ProductDropdownModel>);
    } catch (e) {
      AppSnackbar.error("Error fetching dropdown data: $e");
    }
  }

  Future<void> _loadDiscount(String id) async {
    isLoading.value = true;
    try {
      existingDiscount = await _repository.getDiscountById(id);
      if (existingDiscount != null) {
        _populateFields(existingDiscount!);
      }
    } catch (e) {
      AppSnackbar.error("Error loading discount: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields(DiscountModel discount) {
    titleController.text = discount.title;
    codeController.text = discount.discountCode;
    autoApply.value = discount.autoApply;
    discountApplicable.value = discount.discountApplicable;
    excludeAlreadyDiscounted.value = discount.excludeAlreadyDiscounted;
    discountMode.value = discount.discountMode;
    appliesTo.value = discount.appliesTo ?? 'specific_category';
    minimumRequirement.value = discount.minimumRequirement;

    hasEndDate.value = discount.endDateTime != null;

    startDateController.text = discount.startDateTime.toIso8601String().split(
      'T',
    )[0];
    endDateController.text =
        discount.endDateTime?.toIso8601String().split('T')[0] ?? '';
    startTimeController.text = DateFormat(
      'HH:mm:ss',
    ).format(discount.startDateTime);
    endTimeController.text = discount.endDateTime != null
        ? DateFormat('HH:mm:ss').format(discount.endDateTime!)
        : '';

    usageLimitController.text = discount.usageLimitTotal?.toString() ?? '';
    isOneTimeUsage.value = discount.usageLimitPerCustomer;

    if (discount.minimumRequirement == 'min_purchase_amount') {
      minRequirementValueController.text =
          discount.minimumPurchaseAmount?.toString() ?? '';
    } else if (discount.minimumRequirement == 'min_quantity') {
      minRequirementValueController.text =
          discount.minimumQuantity?.toString() ?? '';
    } else {
      minRequirementValueController.text = '';
    }

    // Select Branches
    selectedBranches.assignAll(discount.branchIds.map((e) => e.id));

    // Multi-selects
    selectedCategories.assignAll(discount.categoryIds.map((e) => e.id));
    selectedBrands.assignAll(discount.brandIds.map((e) => e.id));
    selectedProducts.assignAll(discount.productIds.map((e) => e.id));
    excludeProducts.assignAll(discount.excludedProductIds.map((e) => e.id));

    // Mode specific
    if (discountMode.value == 'normal') {
      discountType.value = discount.discountType;
      discountValueController.text = discount.discountValue.toString();
    } else if (discountMode.value == 'range_wise') {
      rangeRules.assignAll(discount.rangeWiseRules);
    } else if (discountMode.value == 'buy_x_get_y') {
      final buy = discount.buyXGetY;
      if (buy != null) {
        buyQtyController.text = buy.buyQty.toString();
        getQtyController.text = buy.getQty.toString();
        getDiscountType.value = buy.getDiscountType;
        getDiscountValueController.text = buy.getDiscountValue.toString();
        getProductIds.assignAll(buy.getProductIds.map((e) => e.id));
      }
    } else if (discountMode.value == 'product_at_fix_amount') {
      minAmountController.text =
          discount.productAtFixAmount?.minimumAmount.toString() ?? '';
      freeQtyController.text =
          discount.productAtFixAmount?.freeQty.toString() ?? "1";
      freeProductIds.assignAll(
        discount.productAtFixAmount?.freeProductIds.map((e) => e.id).toList() ??
            [],
      );
    }
  }

  void addRangeRule() {
    rangeRules.add(
      RangeWiseRule(
        minQty: 0,
        maxQty: 0,
        discountType: 'percentage',
        discountValue: 0,
      ),
    );
  }

  void removeRangeRule(int index) {
    rangeRules.removeAt(index);
  }

  Map<String, dynamic> _mapProductPayload(String id) {
    final product = products.firstWhereOrNull((p) => p.id == id);
    if (product != null) {
      if (product.hasVariant) {
        return {"productId": product.productId, "variantId": product.id};
      } else {
        return {"productId": product.id, "variantId": null};
      }
    }
    return {"productId": id, "variantId": null};
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;

    // --- Validation Logic Based on Joi Schema ---
    if (discountMode.value == 'range_wise') {
      if (rangeRules.isEmpty) {
        AppSnackbar.error("Please add at least one range rule");
        return;
      }
      for (var rule in rangeRules) {
        if (rule.maxQty < rule.minQty) {
          AppSnackbar.error("Max Quantity cannot be less than Min Quantity");
          return;
        }
      }
    }

    if (discountMode.value == 'buy_x_get_y') {
      final buyQty = int.tryParse(buyQtyController.text) ?? 0;
      final getQty = int.tryParse(getQtyController.text) ?? 0;
      if (buyQty < 1 || getQty < 1) {
        AppSnackbar.error("Buy and Get quantities must be at least 1");
        return;
      }
    }

    if (discountMode.value == 'product_at_fix_amount') {
      final minAmount = double.tryParse(minAmountController.text) ?? 0;
      final freeQty = int.tryParse(freeQtyController.text) ?? 0;
      if (minAmount < 0) {
        AppSnackbar.error("Minimum amount cannot be negative");
        return;
      }
      if (freeProductIds.isEmpty) {
        AppSnackbar.error("Please select at least one free product");
        return;
      }
      if (freeQty < 1) {
        AppSnackbar.error("Free quantity must be at least 1");
        return;
      }
    }

    // Targeting Validation
    if (discountApplicable.value == 'product_wise') {
      if (appliesTo.value == 'specific_category' &&
          selectedCategories.isEmpty) {
        AppSnackbar.error("Please select at least one category");
        return;
      }
      if (appliesTo.value == 'specific_brand' && selectedBrands.isEmpty) {
        AppSnackbar.error("Please select at least one brand");
        return;
      }
      if (appliesTo.value == 'specific_products' && selectedProducts.isEmpty) {
        AppSnackbar.error("Please select at least one product");
        return;
      }
    }

    // Minimum Requirement Validation
    if (minimumRequirement.value == 'min_purchase_amount') {
      final amt = double.tryParse(minRequirementValueController.text) ?? 0;
      if (amt <= 0) {
        AppSnackbar.error("Minimum purchase amount must be greater than 0");
        return;
      }
    } else if (minimumRequirement.value == 'min_quantity') {
      final qty = int.tryParse(minRequirementValueController.text) ?? 0;
      if (qty <= 0) {
        AppSnackbar.error("Minimum quantity must be at least 1");
        return;
      }
    }

    // Date Validation
    if (hasEndDate.value) {
      if (endDateController.text.isEmpty || endTimeController.text.isEmpty) {
        AppSnackbar.error("Please select end date and time");
        return;
      }
      final start = DateTime.parse(
        '${startDateController.text}T${startTimeController.text}',
      );
      final end = DateTime.parse(
        '${endDateController.text}T${endTimeController.text}',
      );
      if (end.isBefore(start)) {
        AppSnackbar.error("End date cannot be before start date");
        return;
      }
    }

    isLoading.value = true;
    try {
      final payload = {
        if (isEdit.value) "discountId": existingDiscount!.id,
        // "branchId": selectedBranch.value!.id,
        "title": titleController.text,
        "discountCode": codeController.text,
        "autoApply": autoApply.value,
        "discountApplicable": discountApplicable.value,
        "excludeAlreadyDiscounted": excludeAlreadyDiscounted.value,
        "discountMode": discountMode.value,
        "appliesTo": (discountApplicable.value == 'product_wise')
            ? appliesTo.value
            : null,
        if (discountApplicable.value == 'product_wise' &&
            selectedCategories.isNotEmpty)
          "categoryIds": selectedCategories.toList(),
        if (discountApplicable.value == 'product_wise' &&
            selectedBrands.isNotEmpty)
          "brandIds": selectedBrands.toList(),
        if (discountApplicable.value == 'product_wise' &&
            selectedProducts.isNotEmpty)
          "productIds": selectedProducts
              .map((id) => _mapProductPayload(id))
              .toList(),
        if (discountApplicable.value == 'product_wise' &&
            excludeProducts.isNotEmpty)
          "excludedProductIds": excludeProducts
              .map((id) => _mapProductPayload(id))
              .toList(),
        "minimumRequirement": minimumRequirement.value,
        // only add minimumQuantity if minimumRequirement is 'quantity'
        if (minimumRequirement.value == 'min_quantity')
          "minimumQuantity": int.tryParse(minRequirementValueController.text),
        // only add minimumPurchaseAmount if minimumRequirement is 'amount'
        if (minimumRequirement.value == 'min_purchase_amount')
          "minimumPurchaseAmount":
              double.tryParse(minRequirementValueController.text) ?? 0,
        "startDateTime":
            '${startDateController.text}T${startTimeController.text}.000Z',
        "hasEndDate": hasEndDate.value,
        "endDateTime": hasEndDate.value
            ? '${endDateController.text}T${endTimeController.text}.000Z'
            : null,
        // "branchIds": selectedBranches.toList(),
        "usageLimitTotal": int.tryParse(usageLimitController.text),
        "usageLimitPerCustomer": isOneTimeUsage.value,
        "isActive": true,
      };

      // Mode specific payload
      if (discountMode.value == 'normal') {
        payload["discountType"] = discountType.value;
        payload["discountValue"] =
            double.tryParse(discountValueController.text) ?? 0;
      } else if (discountMode.value == 'range_wise') {
        payload["rangeWiseRules"] = rangeRules.map((e) => e.toMap()).toList();
      } else if (discountMode.value == 'buy_x_get_y') {
        payload["buyXGetY"] = {
          "buyQty": int.tryParse(buyQtyController.text) ?? 0,
          "getQty": int.tryParse(getQtyController.text) ?? 0,
          "getDiscountType": getDiscountType.value,
          "getDiscountValue":
              double.tryParse(getDiscountValueController.text) ?? 0,
          "getProductIds": getProductIds
              .map((id) => _mapProductPayload(id))
              .toList(),
        };
      } else if (discountMode.value == 'product_at_fix_amount') {
        payload["productAtFixAmount"] = {
          "minimumAmount": double.tryParse(minAmountController.text) ?? 0,
          "freeProductIds": freeProductIds
              .map((id) => _mapProductPayload(id))
              .toList(),
          "freeQty": int.tryParse(freeQtyController.text) ?? 1,
        };
      }

      if (isEdit.value) {
        await _repository.updateDiscount(payload);
        AppSnackbar.success("Discount updated successfully");
      } else {
        await _repository.addDiscount(payload);
        AppSnackbar.success("Discount added successfully");
      }
      await _refreshAndBack();
    } catch (e) {
      Log.e("Error saving discount: $e");
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    codeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    discountValueController.dispose();
    buyQtyController.dispose();
    getQtyController.dispose();
    getDiscountValueController.dispose();
    minAmountController.dispose();
    freeQtyController.dispose();
    minRequirementValueController.dispose();
    usageLimitController.dispose();
    userLimitController.dispose();
    super.onClose();
  }

  Future<void> _refreshAndBack() async {
    final discountController = Get.isRegistered<DiscountController>()
        ? Get.find<DiscountController>()
        : null;

    if (discountController != null) {
      await discountController.refreshData();
    }
    Get.back(result: true);
  }
}
