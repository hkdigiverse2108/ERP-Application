import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/material_consumption/controllers/material_consumption_add_edit_controller.dart';
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

class MaterialConsumptionAddEditView extends GetView<MaterialConsumptionAddEditController> {
  const MaterialConsumptionAddEditView({super.key});

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
                                  child: InkWell(
                                    onTap: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: controller.date.value ?? DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        controller.date.value = date;
                                      }
                                    },
                                    child: IgnorePointer(
                                      child: EditTextField(
                                        label: "Consumption Date",
                                        controller: TextEditingController(
                                          text: controller.date.value == null
                                              ? ""
                                              : DateFormat('dd-MM-yyyy').format(controller.date.value!),
                                        ),
                                        suffixIcon: const Icon(PhosphorIconsLight.calendar),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Consumption Type",
                                    items: controller.consumptionTypes.map((e) => e.name).toList(),
                                    value: controller.selectedConsumptionType.value?.name,
                                    onChanged: (val) {
                                      final type = controller.consumptionTypes.firstWhere((e) => e.name == val);
                                      controller.selectedConsumptionType.value = type;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Remark",
                              controller: controller.remarkController,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),

                      // --- CONSUMPTION ITEMS ---
                      EditSection(
                        title: "Consumption Items",
                        icon: PhosphorIconsLight.listPlus,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown(
                              searchable: true,
                              searchHint: "Search Product",
                              label: "Add Product",
                              items: controller.products.map((e) => e.name).toList(),
                              onChanged: (val) {
                                final p = controller.products.firstWhere((e) => e.name == val);
                                controller.addItem(p);
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
                          padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
                          child: Container(
                            padding: const EdgeInsets.all(Sizes.paddingM),
                            decoration: BoxDecoration(
                              color: context.appColors.primary.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                              border: Border.all(color: context.appColors.primary.withValues(alpha: 0.1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Total Qty", style: TextHelper.captionStyle(context)),
                                    Text(controller.totalQty.toStringAsFixed(2), 
                                      style: TextHelper.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Total Amount", style: TextHelper.captionStyle(context)),
                                    Text("₹ ${controller.totalAmount.toStringAsFixed(2)}", 
                                      style: TextHelper.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.appColors.primary,
                                      )),
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
              controller.isEdit.value ? PhosphorIconsLight.pencilSimple : PhosphorIconsLight.factory,
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
                  controller.isEdit.value ? "Edit Material Consumption" : "Add Material Consumption",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Record raw material usage for production or internal consumption",
                  style: TextHelper.captionStyle(context).copyWith(
                    color: context.appColors.textSecondary,
                  ),
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
        child: Text(
          "No items added yet",
          style: TextHelper.bodySmall.copyWith(
            color: context.appColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildItemsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productId.name,
                        style: TextHelper.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text("Total: ₹ ${item.totalPrice.toStringAsFixed(2)}", 
                        style: TextHelper.captionStyle(context).copyWith(color: context.appColors.primary)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => controller.removeItem(index),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
            const Gap(Sizes.paddingS),
            Row(
              children: [
                Expanded(
                  child: EditTextField(
                    label: "Qty",
                    initialValue: item.qty.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => controller.updateItemQty(index, v),
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: EditTextField(
                    label: "Price",
                    initialValue: item.price.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => controller.updateItemPrice(index, v),
                  ),
                ),
              ],
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
        height: 50,
        child: ElevatedButton(
          onPressed: controller.isSaving.value ? null : () => controller.save(),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadiusM)),
          ),
          child: controller.isSaving.value
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  controller.isEdit.value ? "Update Material Consumption" : "Save Material Consumption",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
