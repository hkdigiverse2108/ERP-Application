import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/product/controllers/add_item_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddItem extends GetView<AddItemController> {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                QuickAction(),
                const Gap(Sizes.paddingS),

                // --- HEADER SECTION ---
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
                          PhosphorIconsLight.package,
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
                              "Add Item",
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

                // --- FORM SECTION ---
                EditSection(
                  title: "Product Information",
                  child: Column(
                    children: [
                      // Product Selection (Full Width)
                      CustomDropdown(
                        label: "Product",
                        searchable: true,
                        items: controller.products.map((e) => e.name).toList(),
                        value: controller.productName.value.isEmpty
                            ? null
                            : controller.productName.value,
                        onChanged: (val) {
                          final prod = controller.products.firstWhere(
                            (e) => e.name == val,
                          );
                          controller.onProductSelected(prod);
                        },
                      ),
                      const Gap(Sizes.defVerticalSpace),

                      // UOM and Quantity
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              label: "Quantity",
                              controller: controller.qtyController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.defVerticalSpace),

                      // Purchase Tax and Inclusion
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomDropdown(
                              label: "Purchase Tax",
                              items: controller.taxes
                                  .map((e) => e.name)
                                  .toList(),
                              value: controller.purchaseTaxName.value.isEmpty
                                  ? null
                                  : controller.purchaseTaxName.value,
                              onChanged: (val) {
                                final tax = controller.taxes.firstWhere(
                                  (e) => e.name == val,
                                );
                                controller.purchaseTaxId.value = tax.id;
                                controller.purchaseTaxName.value = tax.name;
                              },
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            flex: 1,
                            child: _buildInclusionSwitch(
                              "Incl.",
                              controller.purchaseTaxIncluding,
                              context,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.defVerticalSpace),

                      // Sales Tax and Inclusion
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
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
                            flex: 1,
                            child: _buildInclusionSwitch(
                              "Incl.",
                              controller.salesTaxIncluding,
                              context,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.defVerticalSpace),

                      // Pricing: Purchase Price and Landing Cost
                      Row(
                        children: [
                          Expanded(
                            child: EditTextField(
                              label: "Purchase Price",
                              controller: controller.purchasePriceController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: EditTextField(
                              label: "Landing Cost",
                              controller: controller.landingCostController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.defVerticalSpace),

                      // Pricing: MRP and Selling Discount
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
                              label: "Selling Discount",
                              controller: controller.sellingDiscountController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.defVerticalSpace),

                      // Selling Details: Price and Margin
                      Row(
                        children: [
                          Expanded(
                            child: EditTextField(
                              label: "Selling Price",
                              controller: controller.sellingPriceController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: EditTextField(
                              label: "Selling Margin",
                              controller: controller.sellingMarginController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.defVerticalSpace),
                      CheckboxListTile(
                        title: const Text("Enable Quick Picking"),
                        value: controller.enableQuickPicking.value,
                        onChanged: (value) {
                          controller.enableQuickPicking.value = value ?? false;
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Gap(Sizes.paddingL),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        height: Sizes.buttonHeightM,
                        child: ElevatedButton(
                          onPressed: controller.isSaving.value
                              ? null
                              : () => controller.saveItem(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.appColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusM,
                              ),
                            ),
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
                                  "Save Item",
                                  style: TextHelper.button.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Sizes.paddingL),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInclusionSwitch(
    String label,
    RxBool value,
    BuildContext context,
  ) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextHelper.bodySmall),
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.scale(
              scale: 0.85,
              child: Switch(
                value: value.value,
                onChanged: (val) => value.value = val,
                activeThumbColor: context.appColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      );
    });
  }
}
