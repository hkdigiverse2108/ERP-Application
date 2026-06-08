import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_add_edit_controller.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/widgets/stock_transfer_item_card.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StockTransferAddEditView extends GetView<StockTransferAddEditController> {
  const StockTransferAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        bottomNavigationBar: _buildBottomActions(context),
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
                _buildGeneralInfoSection(context),
                const Gap(Sizes.paddingM),
                _buildItemsSection(context),
                const Gap(Sizes.paddingXL),
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
              controller.isEdit
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
                  controller.isEdit
                      ? "Edit Stock Transfer"
                      : "Add Stock Transfer",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Transfer stock between branches",
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

  Widget _buildGeneralInfoSection(BuildContext context) {
    return EditSection(
      title: "General Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          CustomDropdown(
            label: "Target Branch",
            value: controller.selectedToBranch.value?.name,
            items: controller.branches.map((e) => e.name).toList(),
            searchable: true,
            onChanged: (v) {
              final branch = controller.branches.firstWhereOrNull(
                (e) => e.name == v,
              );
              controller.onBranchSelected(branch);
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Request Note",
            controller: controller.noteController,
            hintText: "Enter request note",
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context) {
    return EditSection(
      title: "Items",
      icon: PhosphorIconsLight.package,
      child: Column(
        children: [
          Obx(() {
            if (controller.isProductLoading.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search & Add Product",
                    style: TextHelper.bodySmallStyle(
                      context,
                    ).copyWith(color: context.appColors.textSecondary),
                  ),
                  const Gap(8),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Loading products...",
                          style: TextHelper.bodyMediumStyle(
                            context,
                          ).copyWith(color: context.appColors.textSecondary),
                        ),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.appColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return CustomDropdown(
              label: "Search & Add Product",
              readOnly: controller.selectedToBranch.value == null,
              searchable: true,
              items: controller.products.map((e) => e.name).toList(),
              onChanged: (v) {
                final product = controller.products.firstWhereOrNull(
                  (e) => e.name == v,
                );
                if (product != null) {
                  if (product.hasVariant) {
                    if (controller.items.any(
                      (i) => i.variantId == product.id,
                    )) {
                      AppSnackbar.warning("Product already added");
                    } else {
                      controller.addItem();
                      controller.updateItemProduct(
                        controller.items.length - 1,
                        product,
                      );
                    }
                  } else {
                    if (controller.items.any(
                      (i) => i.productId == product.id,
                    )) {
                      AppSnackbar.warning("Product already added");
                    } else {
                      controller.addItem();
                      controller.updateItemProduct(
                        controller.items.length - 1,
                        product,
                      );
                    }
                  }
                }
              },
            );
          }),
          const Gap(Sizes.paddingM),
          if (controller.items.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.paddingXL),
                child: Column(
                  children: [
                    Icon(
                      PhosphorIconsLight.shoppingCartSimple,
                      size: 48,
                      color: context.appColors.textSecondary.withValues(
                        alpha: 0.3,
                      ),
                    ),
                    const Gap(Sizes.paddingS),
                    Text(
                      "No items added yet",
                      style: TextHelper.bodyMedium.copyWith(
                        color: context.appColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              children: List.generate(
                controller.items.length,
                (index) => StockTransferItemCard(
                  index: index,
                  item: controller.items[index],
                  controller: controller,
                  onRemove: () => controller.removeItem(index),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.appColors.border),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextHelper.bodyMediumStyle(context).copyWith(
                  color: context.appColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : () => controller.save(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                ),
                child: controller.isSaving.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        controller.isEdit ? "Update Transfer" : "Save Transfer",
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
