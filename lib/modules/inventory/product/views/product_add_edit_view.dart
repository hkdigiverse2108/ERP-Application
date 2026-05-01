import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_quill_editor.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_tag_input.dart';
import 'package:ai_setu/shared/widgets/images/image_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProductAddEditView extends GetView<ProductAddEditController> {
  const ProductAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuickAction(),
                const Gap(Sizes.paddingS),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.paddingM,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.appColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusL,
                          ),
                        ),
                        child: Icon(
                          controller.isEdit.value
                              ? PhosphorIconsLight.pencilSimple
                              : PhosphorIconsLight.package,
                          color: context.appColors.primary,
                          size: 28,
                        ),
                      ),
                      const Gap(Sizes.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.isEdit.value
                                  ? "Edit Product"
                                  : "Add Product",
                              style: TextHelper.h5Style(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.appColors.textPrimary,
                              ),
                            ),
                            Text(
                              "Configure product details and inventory settings",
                              style: TextHelper.captionStyle(context).copyWith(
                                color: context.appColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Sizes.paddingS),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // --- GENERAL INFORMATION ---
                      EditSection(
                        title: "General Information",
                        icon: PhosphorIconsLight.info,
                        child: Column(
                          children: [
                            EditTextField(
                              label: "Product Name",
                              controller: controller.nameController,
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            CustomDropdown(
                              label: "Product Type",
                              items: ProductType.values
                                  .map((e) => e.name.capitalizeFirst!)
                                  .toList(),
                              value: controller
                                  .selectedType
                                  .value
                                  .name
                                  .capitalizeFirst!,
                              onChanged: (val) {
                                controller.selectedType.value = ProductType
                                    .values
                                    .firstWhere(
                                      (e) => e.name.capitalizeFirst == val,
                                    );
                              },
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Print Name",
                              controller: controller.printNameController,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "SKU / Code",
                                    controller: controller.skuController,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "HSN Code",
                                    controller: controller.hsnCodeController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // --- PRICING DETAILS ---
                      EditSection(
                        title: "Pricing Details",
                        icon: PhosphorIconsLight.currencyCircleDollar,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "MRP",
                                    controller: controller.mrpController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "Cost Price",
                                    controller: controller.costController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Sales Price",
                              controller: controller.salesPriceController,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),

                      // --- INVENTORY & CATEGORIZATION ---
                      EditSection(
                        title: "Inventory & Categorization",
                        icon: PhosphorIconsLight.package,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Category",
                                    items: controller.categories
                                        .map((e) => e.name)
                                        .toList(),
                                    value: controller.categoryName.value.isEmpty
                                        ? null
                                        : controller.categoryName.value,
                                    onChanged: (val) {
                                      final cat = controller.categories
                                          .firstWhere((e) => e.name == val);
                                      controller.onCategorySelected(cat);
                                    },
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Sub Category",
                                    items: controller.subCategories
                                        .map((e) => e.name)
                                        .toList(),
                                    value:
                                        controller.subCategoryName.value.isEmpty
                                        ? null
                                        : controller.subCategoryName.value,
                                    onChanged: (val) {
                                      final cat = controller.subCategories
                                          .firstWhere((e) => e.name == val);
                                      controller.subCategoryId.value = cat.id;
                                      controller.subCategoryName.value =
                                          cat.name;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Brand",
                                    items: controller.brands
                                        .map((e) => e.name)
                                        .toList(),
                                    value: controller.brandName.value.isEmpty
                                        ? null
                                        : controller.brandName.value,
                                    onChanged: (val) {
                                      final brand = controller.brands
                                          .firstWhere((e) => e.name == val);
                                      controller.onBrandSelected(brand);
                                    },
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Sub Brand",
                                    items: controller.subBrands
                                        .map((e) => e.name)
                                        .toList(),
                                    value: controller.subBrandName.value.isEmpty
                                        ? null
                                        : controller.subBrandName.value,
                                    onChanged: (val) {
                                      final brand = controller.subBrands
                                          .firstWhere((e) => e.name == val);
                                      controller.subBrandId.value = brand.id;
                                      controller.subBrandName.value =
                                          brand.name;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown(
                                    label: "UOM",
                                    items: controller.uoms
                                        .map((e) => e.name)
                                        .toList(),
                                    value: controller.uomName.value.isEmpty
                                        ? null
                                        : controller.uomName.value,
                                    onChanged: (val) {
                                      final uom = controller.uoms.firstWhere(
                                        (e) => e.name == val,
                                      );
                                      controller.uomId.value = uom.id;
                                      controller.uomName.value = uom.name;
                                    },
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "Opening Qty",
                                    controller:
                                        controller.openingBalanceController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Minimum Stock",
                              controller: controller.minStockController,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),

                      // --- TAX DETAILS ---
                      EditSection(
                        title: "Tax Details",
                        icon: PhosphorIconsLight.receipt,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Sales Tax",
                                    items: controller.taxes
                                        .map((e) => e.name)
                                        .toList(),
                                    value: controller.salesTaxName.value.isEmpty
                                        ? null
                                        : controller.salesTaxName.value,
                                    onChanged: (val) {
                                      final tax = controller.taxes.firstWhere(
                                        (e) => e.name == val,
                                      );
                                      controller.salesTaxId.value = tax.id;
                                      controller.salesTaxName.value = tax.name;
                                    },
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Purchase Tax",
                                    items: controller.taxes
                                        .map((e) => e.name)
                                        .toList(),
                                    value:
                                        controller.purchaseTaxName.value.isEmpty
                                        ? null
                                        : controller.purchaseTaxName.value,
                                    onChanged: (val) {
                                      final tax = controller.taxes.firstWhere(
                                        (e) => e.name == val,
                                      );
                                      controller.purchaseTaxId.value = tax.id;
                                      controller.purchaseTaxName.value =
                                          tax.name;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Cess %",
                              controller: controller.cessController,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),

                      // --- BATCH & EXPIRY ---
                      Obx(
                        () => EditSection(
                          title: "Batch & Expiry Management",
                          icon: PhosphorIconsLight.calendar,
                          child: Column(
                            children: [
                              SwitchListTile(
                                title: const Text("Manage Multiple Batch"),
                                value: controller.manageMultipleBatch.value,
                                onChanged: (v) =>
                                    controller.manageMultipleBatch.value = v,
                                contentPadding: EdgeInsets.zero,
                              ),
                              if (controller.manageMultipleBatch.value) ...[
                                SwitchListTile(
                                  title: const Text("Has Expiry"),
                                  value: controller.hasExpiry.value,
                                  onChanged: (v) =>
                                      controller.hasExpiry.value = v,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                if (controller.hasExpiry.value) ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: EditTextField(
                                          label: "Expiry Days",
                                          controller:
                                              controller.expiryDaysController,
                                          keyboardType: TextInputType.number,

                                          onChanged: (v) => controller
                                              .syncExpiryDaysToDate(v),
                                        ),
                                      ),
                                      const Gap(Sizes.paddingM),
                                      Expanded(
                                        child: CustomDropdown(
                                          label: "Calculate Expiry On",
                                          items: const [
                                            "Manufacturing Date",
                                            "Packing Date",
                                          ],
                                          value: controller
                                              .calculateExpiryOn
                                              .value,
                                          onChanged: (v) =>
                                              controller
                                                      .calculateExpiryOn
                                                      .value =
                                                  v,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(Sizes.defVerticalSpace),
                                  InkWell(
                                    onTap: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            controller
                                                .expiryReferenceDate
                                                .value ??
                                            DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        controller.syncExpiryDateToDays(date);
                                      }
                                    },
                                    child: IgnorePointer(
                                      child: EditTextField(
                                        label: "Expiry Reference Date",
                                        controller: TextEditingController(
                                          text:
                                              controller
                                                      .expiryReferenceDate
                                                      .value ==
                                                  null
                                              ? ""
                                              : DateFormat('dd-MM-yyyy').format(
                                                  controller
                                                      .expiryReferenceDate
                                                      .value!,
                                                ),
                                        ),
                                        suffixIcon: const Icon(
                                          PhosphorIconsLight.calendar,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(Sizes.defVerticalSpace),
                                  SwitchListTile(
                                    title: const Text(
                                      "Is Expiry Product Saleable",
                                    ),
                                    value: controller
                                        .isExpiryProductSaleable
                                        .value,
                                    onChanged: (v) =>
                                        controller
                                                .isExpiryProductSaleable
                                                .value =
                                            v,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ),

                      // --- CONTENT ---
                      EditSection(
                        title: "Product Content",
                        icon: PhosphorIconsLight.article,
                        child: Column(
                          children: [
                            CustomTagInput(
                              label: "Ingredients",
                              tags: controller.ingredients,
                              controller: controller.ingredientInputController,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Short Description",
                              controller: controller.shortDescriptionController,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),

                      const Gap(Sizes.defVerticalSpace),

                      // --- DETAILED DESCRIPTION ---
                      EditSection(
                        title: "Detailed Description",
                        icon: PhosphorIconsLight.textT,
                        child: CustomQuillEditor(
                          label: "", // Label is already in section title
                          controller: controller.quillController,
                        ),
                      ),

                      // --- NUTRITION ---
                      EditSection(
                        title: "Nutrition Info",
                        icon: PhosphorIconsLight.list,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "Nutrient Name",
                                    controller:
                                        controller.nutritionNameController,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "Value (per 100g/ml)",
                                    controller:
                                        controller.nutritionValueController,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.paddingM),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () => controller.addNutrition(),
                                icon: const Icon(Icons.add),
                                label: const Text("ADD NUTRITION"),
                              ),
                            ),
                            if (controller.nutritionList.isNotEmpty) ...[
                              const Gap(Sizes.paddingM),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.nutritionList.length,
                                separatorBuilder: (context, index) =>
                                    const Gap(8),
                                itemBuilder: (context, index) {
                                  final item = controller.nutritionList[index];
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerHighest
                                          .withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${item.name}: ${item.value}",
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              controller.removeNutrition(index),
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),

                      // --- LOGISTICS ---
                      EditSection(
                        title: "Logistics Info",
                        icon: PhosphorIconsLight.truck,
                        child: Row(
                          children: [
                            Expanded(
                              child: EditTextField(
                                label: "Net Weight",
                                controller: controller.netWeightController,
                                keyboardType: TextInputType.number,
                                suffixIcon: const Icon(
                                  PhosphorIconsLight.scales,
                                ),
                              ),
                            ),
                            const Gap(Sizes.paddingM),
                            Expanded(
                              child: EditTextField(
                                label: "Master Qty",
                                controller: controller.masterQtyController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- PRODUCT IMAGES ---
                      EditSection(
                        title: "Product Images",
                        icon: PhosphorIconsLight.image,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120,
                              child: Obx(
                                () => ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.imageList.length + 1,
                                  separatorBuilder: (context, index) =>
                                      const Gap(12),
                                  itemBuilder: (context, index) {
                                    if (index == controller.imageList.length) {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(
                                          Sizes.borderRadiusM,
                                        ),
                                        onTap: () => controller.pickImage(),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: context.appColors.surface,
                                            border: Border.all(
                                              color: context.appColors.border,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                          ),
                                          child: Icon(
                                            PhosphorIconsLight.plus,
                                            color:
                                                context.appColors.textSecondary,
                                            size: 32,
                                          ),
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap: () => Get.to(
                                        () => ImageViewerPage(
                                          imageUrl: controller.imageList[index],
                                          title:
                                              controller
                                                  .nameController
                                                  .text
                                                  .isEmpty
                                              ? "Product Image"
                                              : controller.nameController.text,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            child: Hero(
                                              tag: controller.imageList[index],
                                              child: Image.network(
                                                controller.imageList[index],
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Container(
                                                      width: 100,
                                                      height: 100,
                                                      color: context
                                                          .appColors
                                                          .background,
                                                      child: Icon(
                                                        PhosphorIconsLight
                                                            .warning,
                                                        color: context
                                                            .appColors
                                                            .textSecondary,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 4,
                                            right: 4,
                                            child: InkWell(
                                              onTap: () =>
                                                  controller.removeImage(index),
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black54,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Gap(Sizes.paddingL),

                      // --- SAVE BUTTON ---
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingM,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isSaving.value
                                ? null
                                : () => controller.saveProduct(),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.borderRadiusM,
                                ),
                              ),
                            ),
                            child: controller.isSaving.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    controller.isEdit.value
                                        ? "Update Product"
                                        : "Add Product",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(Sizes.paddingXL),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
