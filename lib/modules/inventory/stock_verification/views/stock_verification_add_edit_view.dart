import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/stock_verification/controllers/stock_verification_add_edit_controller.dart';
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

class StockVerificationAddEditView
    extends GetView<StockVerificationAddEditController> {
  const StockVerificationAddEditView({super.key});

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
                _buildHeader(context),
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
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "Verification No",
                                    readOnly: true,
                                    initialValue: controller.isEdit.value
                                        ? controller
                                              .stockVerification
                                              ?.stockVerificationNo
                                        : "Auto Generated",
                                    hintText: "Generated upon save",
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "Date",
                                    readOnly: true,
                                    initialValue: DateFormat('dd-MM-yyyy')
                                        .format(
                                          controller.isEdit.value
                                              ? controller
                                                    .stockVerification!
                                                    .createdAt
                                              : DateTime.now(),
                                        ),
                                    suffixIcon: const Icon(
                                      PhosphorIconsLight.calendar,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // --- VERIFICATION ITEMS ---
                      EditSection(
                        title: "Discrepancy Items",
                        icon: PhosphorIconsLight.listChecks,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown(
                              searchable: true,
                              searchHint: "Search Product",
                              label: "Add Product",
                              items: controller.products
                                  .map((e) => e.name)
                                  .toList(),
                              onChanged: (val) {
                                final p = controller.products.firstWhere(
                                  (e) => e.name == val,
                                );
                                controller.addProduct(p);
                              },
                            ),
                            const Gap(Sizes.paddingM),
                            if (controller.items.isEmpty)
                              _buildEmptyItems(context)
                            else
                              _buildItemsList(context),
                          ],
                        ),
                      ),

                      // --- SUMMARY ---
                      if (controller.items.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.paddingM,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(Sizes.paddingM),
                            decoration: BoxDecoration(
                              color: context.appColors.primary.withValues(
                                alpha: 0.05,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusM,
                              ),
                              border: Border.all(
                                color: context.appColors.primary.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildSummaryItem(
                                      "Total Products",
                                      controller.totalProducts.value
                                          .toStringAsFixed(0),
                                      context,
                                    ),
                                    _buildSummaryItem(
                                      "Total Physical",
                                      controller.totalPhysicalQty.value
                                          .toStringAsFixed(2),
                                      context,
                                    ),
                                  ],
                                ),
                                const Divider(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Difference Amount",
                                      style: TextHelper.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "₹ ${controller.totalDifferenceAmount.value.toStringAsFixed(2)}",
                                      style: TextHelper.h5Style(context)
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                controller
                                                        .totalDifferenceAmount
                                                        .value <
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      const Gap(Sizes.paddingL),

                      // --- SAVE BUTTON ---
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

  Widget _buildSummaryItem(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextHelper.captionStyle(context)),
        Text(
          value,
          style: TextHelper.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
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
                  : PhosphorIconsLight.clipboardText,
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
                      ? "Edit Stock Verification"
                      : "Add Stock Verification",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Verify physical stock against system records and log discrepancies",
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

  Widget _buildEmptyItems(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.paddingM),
        child: Column(
          children: [
            Icon(
              PhosphorIconsLight.package,
              size: 48,
              color: context.appColors.textSecondary.withValues(alpha: 0.3),
            ),
            const Gap(Sizes.paddingS),
            Text(
              "No products added yet.\nSearch and select a product to begin verification.",
              textAlign: TextAlign.center,
              style: TextHelper.bodySmall.copyWith(
                color: context.appColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.items.length,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) {
        final item = controller.items[index];
        final bool isNegative = item.differenceQty < 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productId.name,
                        style: TextHelper.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rate: ₹${item.price.toStringAsFixed(2)}",
                        style: TextHelper.captionStyle(context),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => controller.removeProduct(index),
                  icon: const Icon(PhosphorIconsLight.trash, color: Colors.red),
                ),
              ],
            ),
            const Gap(Sizes.paddingS),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "System Qty",
                        style: TextHelper.captionStyle(context),
                      ),
                      const Gap(4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.surface.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                          border: Border.all(color: context.appColors.border),
                        ),
                        child: Text(
                          item.systemQty.toString(),
                          style: TextHelper.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: EditTextField(
                    label: "Physical Qty",
                    initialValue: item.physicalQty.toString(),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (v) => controller.updatePhysicalQty(index, v),
                  ),
                ),
              ],
            ),
            const Gap(Sizes.paddingS),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (isNegative ? Colors.red : Colors.green).withValues(
                  alpha: 0.05,
                ),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
              ),
              child: Row(
                children: [
                  Icon(
                    isNegative
                        ? PhosphorIconsLight.trendDown
                        : PhosphorIconsLight.trendUp,
                    size: 16,
                    color: isNegative ? Colors.red : Colors.green,
                  ),
                  const Gap(8),
                  Text(
                    "Difference: ${item.differenceQty > 0 ? '+' : ''}${item.differenceQty.toStringAsFixed(2)} (Value: ₹${item.differenceAmount.toStringAsFixed(2)})",
                    style: TextHelper.captionStyle(context).copyWith(
                      color: isNegative ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: controller.isSaving.value ? null : () => controller.save(),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            ),
            elevation: 0,
          ),
          child: controller.isSaving.value
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  controller.isEdit.value
                      ? "Update Verification"
                      : "Save Verification",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
