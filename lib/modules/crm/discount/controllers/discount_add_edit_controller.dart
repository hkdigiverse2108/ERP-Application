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
import 'package:flutter/material.dart';
import 'package:ai_setu/shared/widgets/media_picker/views/media_picker_dialog.dart';
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
  final fixAmountController = TextEditingController();
  final RxList<String> fixAmountProductIds = <String>[].obs;

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
  final Rxn<String> selectedImageUrl = Rxn<String>();

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

    final id = Get.parameters['id'];
    if (id != null) {
      isEdit.value = true;
      _loadDiscount(id);
    }

    // --- WORKERS ---
    ever(discountApplicable, (val) {
      if (val == 'entire_bill') {
        discountMode.value = 'normal';
      }
    });

    // Default dates for new discount
    if (id == null) {
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
        titleController.text = existingDiscount!.title;
        codeController.text = existingDiscount!.discountCode;
        autoApply.value = existingDiscount!.autoApply;
        discountApplicable.value = existingDiscount!.discountApplicable;
        excludeAlreadyDiscounted.value =
            existingDiscount!.excludeAlreadyDiscounted;
        discountMode.value = existingDiscount!.discountMode;
        appliesTo.value = existingDiscount!.appliesTo ?? 'specific_category';
        minimumRequirement.value = existingDiscount!.minimumRequirement;

        hasEndDate.value = existingDiscount!.endDateTime != null;

        startDateController.text = existingDiscount!.startDateTime
            .toIso8601String()
            .split('T')[0];
        endDateController.text =
            existingDiscount!.endDateTime?.toIso8601String().split('T')[0] ??
            '';
        startTimeController.text = DateFormat(
          'HH:mm:ss',
        ).format(existingDiscount!.startDateTime);
        endTimeController.text = existingDiscount!.endDateTime != null
            ? DateFormat('HH:mm:ss').format(existingDiscount!.endDateTime!)
            : '';

        usageLimitController.text =
            existingDiscount!.usageLimitTotal?.toString() ?? '';
        isOneTimeUsage.value = existingDiscount!.usageLimitPerCustomer;

        if (existingDiscount!.minimumRequirement == 'amount') {
          minRequirementValueController.text =
              existingDiscount!.minimumPurchaseAmount?.toString() ?? '';
        } else if (existingDiscount!.minimumRequirement == 'quantity') {
          minRequirementValueController.text =
              existingDiscount!.minimumQuantity?.toString() ?? '';
        } else {
          minRequirementValueController.text = '';
        }

        // Select Branches
        selectedBranches.assignAll(
          existingDiscount!.branchIds.map((e) => e.id),
        );

        // Multi-selects
        selectedCategories.assignAll(
          existingDiscount!.categoryIds.map((e) => e.id),
        );
        selectedBrands.assignAll(existingDiscount!.brandIds.map((e) => e.id));
        selectedProducts.assignAll(
          existingDiscount!.productIds.map((e) => e.id),
        );
        excludeProducts.assignAll(
          existingDiscount!.excludedProductIds.map((e) => e.id),
        );

        // Mode specific
        if (discountMode.value == 'normal') {
          discountType.value = existingDiscount!.discountType;
          discountValueController.text = existingDiscount!.discountValue
              .toString();
        } else if (discountMode.value == 'range_wise') {
          rangeRules.assignAll(existingDiscount!.rangeWiseRules);
        } else if (discountMode.value == 'buy_x_get_y') {
          final buy = existingDiscount!.buyXGetY;
          if (buy != null) {
            buyQtyController.text = buy.buyQty.toString();
            getQtyController.text = buy.getQty.toString();
            getDiscountType.value = buy.getDiscountType;
            getDiscountValueController.text = buy.getDiscountValue.toString();
            getProductIds.assignAll(buy.getProductIds.map((e) => e.id));
          }
        } else if (discountMode.value == 'product_at_fix_amount') {
          fixAmountController.text =
              existingDiscount!.productAtFixAmount?.fixAmount.toString() ?? '';
          fixAmountProductIds.assignAll(
            existingDiscount!.productAtFixAmount?.productId ?? [],
          );
        }
      }
    } catch (e) {
      AppSnackbar.error("Error loading discount: $e");
    } finally {
      isLoading.value = false;
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

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    // if (selectedBranches.isEmpty) {
    //   AppSnackbar.error("Please select a branch");
    //   return;
    // }

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
          "productIds": selectedProducts.toList(),
        if (discountApplicable.value == 'product_wise' &&
            excludeProducts.isNotEmpty)
          "excludeProductIds": excludeProducts.toList(),
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
          "getProductIds": getProductIds.toList(),
        };
      } else if (discountMode.value == 'product_at_fix_amount') {
        payload["productAtFixAmount"] = {
          "fixAmount": double.tryParse(fixAmountController.text) ?? 0,
          "productId": fixAmountProductIds.toList(),
        };
      }

      if (isEdit.value) {
        await _repository.updateDiscount(payload);
        AppSnackbar.success("Discount updated successfully");
      } else {
        await _repository.addDiscount(payload);
        AppSnackbar.success("Discount added successfully");
      }
      Get.back(result: true);
    } catch (e) {
      Log.e("Error saving discount: $e");
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    await MediaPickerDialog.show(
      onMediaSelected: (selected) {
        if (selected.isNotEmpty) {
          selectedImageUrl.value = selected.first.url;
        }
      },
    );
  }

  void removeImage() {
    selectedImageUrl.value = null;
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
    fixAmountController.dispose();
    minRequirementValueController.dispose();
    usageLimitController.dispose();
    userLimitController.dispose();
    super.onClose();
  }
}

