import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/controllers/bill_of_live_product_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BillOfLiveProductAddEditView
    extends GetView<BillOfLiveProductAddEditController> {
  const BillOfLiveProductAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickAction(),
                const Gap(Sizes.paddingS),
                _buildHeader(context),
                const Gap(Sizes.paddingS),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      _buildGeneralInfo(context),
                      _buildProductDetails(context),
                      const Gap(Sizes.paddingL),
                      _buildSaveButton(context),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            ),
            child: Icon(
              controller.isEdit.value
                  ? PhosphorIconsLight.pencilSimple
                  : PhosphorIconsLight.factory,
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
                      ? "Edit Bill Of Live Product"
                      : "Add Bill Of Live Product",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage live product configurations and recipes",
                  style: TextHelper.captionStyle(
                    context,
                  ).copyWith(color: context.appColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralInfo(BuildContext context) {
    return EditSection(
      title: "General Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "No",
                  controller: controller.numberController,
                  readOnly: true,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: controller.date.value ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (d != null) controller.date.value = d;
                  },
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Date",
                      controller: TextEditingController(
                        text: controller.date.value == null
                            ? ""
                            : DateFormat(
                                'dd-MM-yyyy',
                              ).format(controller.date.value!),
                      ),
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.defVerticalSpace),
          CustomDropdown(
            label: "Recipe",
            items: controller.recipes.map((e) => e.name).toList(),
            value: controller.selectedRecipeIds.isEmpty
                ? null
                : controller.recipes
                      .firstWhereOrNull(
                        (e) => e.id == controller.selectedRecipeIds.first,
                      )
                      ?.name,
            onChanged: (val) {
              final r = controller.recipes.firstWhereOrNull(
                (e) => e.name == val,
              );
              if (r != null) {
                controller.onRecipeChanged([r.id]);
              }
            },
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: controller.allowReverseCalculation.value,
                  onChanged: (v) =>
                      controller.allowReverseCalculation.value = v,
                ),
              ),
              Text(
                "Allow Reverse Calculation",
                style: TextHelper.bodySmallStyle(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return EditSection(
      title: "Product Details",
      icon: PhosphorIconsLight.package,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown(
            searchable: true,
            label: "Add Product",
            items: controller.products.map((e) => e.name).toList(),
            onChanged: (val) {
              final p = controller.products.firstWhere((e) => e.name == val);
              controller.addProduct(p);
            },
          ),
          const Gap(Sizes.paddingM),
          if (controller.productDetails.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.paddingM),
                child: Text(
                  "No products added",
                  style: TextHelper.captionStyle(context),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.productDetails.length,
              separatorBuilder: (context, index) => const Gap(Sizes.paddingM),
              itemBuilder: (context, index) {
                return _buildProductItemCard(context, index);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProductItemCard(BuildContext context, int index) {
    final item = controller.productDetails[index];
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.productName,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.removeProduct(index),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const Divider(),
          const Gap(Sizes.paddingS),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Qty",
                  initialValue: item.qty.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateProductQty(index, v),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Purchase Price",
                  initialValue: item.purchasePrice.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      item.purchasePrice = double.tryParse(v) ?? 0,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Landing Cost",
                  initialValue: item.landingCost.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => item.landingCost = double.tryParse(v) ?? 0,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "MRP",
                  initialValue: item.mrp.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => item.mrp = double.tryParse(v) ?? 0,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Selling Price",
                  initialValue: item.sellingPrice.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => item.sellingPrice = double.tryParse(v) ?? 0,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: item.mfgDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (d != null) {
                      item.mfgDate = d;
                      controller.productDetails.refresh();
                    }
                  },
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "MFG Date",
                      controller: TextEditingController(
                        text: DateFormat('dd-MM-yyyy').format(item.mfgDate),
                      ),
                      suffixIcon: const Icon(
                        PhosphorIconsLight.calendar,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Expiry Days",
                  initialValue: item.expiryDays.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    item.expiryDays = int.tryParse(v) ?? 0;
                    controller.productDetails.refresh();
                  },
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "EXP Date",
                  readOnly: true,
                  controller: TextEditingController(
                    text: DateFormat(
                      'dd-MM-yyyy',
                    ).format(item.mfgDate.add(Duration(days: item.expiryDays))),
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          _buildRawMaterialsSection(context, index, item),
        ],
      ),
    );
  }

  Widget _buildRawMaterialsSection(
    BuildContext context,
    int productIndex,
    ProductDetailItem item,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.paddingS),
      decoration: BoxDecoration(
        color: context.appColors.background.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Raw Materials",
                style: TextHelper.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () =>
                    _showIngredientSelection(context, productIndex),
                icon: const Icon(Icons.add_circle_outline, size: 20),
                color: context.appColors.primary,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          if (item.ingredients.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.paddingS),
              child: Center(
                child: Text(
                  "No raw materials added",
                  style: TextHelper.captionStyle(context),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: item.ingredients.length,
              separatorBuilder: (context, index) => const Divider(height: 16),
              itemBuilder: (context, iIndex) {
                final ingredient = item.ingredients[iIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ingredient.productName,
                            style: TextHelper.captionStyle(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              controller.removeIngredientFromProduct(
                                productIndex,
                                iIndex,
                              ),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 16,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Available: ${ingredient.availableQty}",
                            style: TextHelper.captionStyle(context),
                          ),
                        ),
                        const Gap(Sizes.paddingM),
                        Expanded(
                          child: EditTextField(
                            label: "Use Qty",
                            initialValue: ingredient.useQty.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) =>
                                ingredient.useQty = double.tryParse(v) ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  void _showIngredientSelection(BuildContext context, int productIndex) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(Sizes.paddingL),
        decoration: BoxDecoration(
          color: context.appColors.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Sizes.borderRadiusL),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.appColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(Sizes.paddingM),
            Text(
              "Select Raw Material",
              style: TextHelper.h5Style(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(Sizes.paddingM),
            Expanded(
              child: ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final p = controller.products[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(p.name, style: TextHelper.bodyMedium),
                    subtitle: Text(
                      "Price: ₹ ${p.purchasePrice}",
                      style: TextHelper.captionStyle(context),
                    ),
                    trailing: const Icon(Icons.add, size: 20),
                    onTap: () {
                      controller.addIngredientToProduct(productIndex, p);
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: controller.isSaving.value
              ? null
              : () => controller.saveBOM(),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
            ),
            elevation: 2,
          ),
          child: controller.isSaving.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  controller.isEdit.value
                      ? "Update Bill Of Live Product"
                      : "Save Bill Of Live Product",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
