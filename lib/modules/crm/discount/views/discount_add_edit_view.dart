import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/crm/discount/controllers/discount_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:ai_setu/shared/widgets/images/edit_image_picker.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DiscountAddEditView extends GetView<DiscountAddEditController> {
  const DiscountAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.appColors.background,
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            // physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const QuickAction(),
                    const Gap(Sizes.paddingS),
                    _buildHeader(context),
                    const Gap(Sizes.paddingS),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 100),
                sliver: SliverToBoxAdapter(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        _buildGeneralInfo(context),
                        _buildDiscountLogic(context),
                        _buildModeSpecificSection(context),
                        _buildApplicabilitySection(context),
                        _buildRequirementsSection(context),
                        _buildLimitsAndDates(context),
                        _buildImageSection(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: _buildBottomAction(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      padding: const EdgeInsets.all(Sizes.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.primary,
            context.appColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        boxShadow: [
          BoxShadow(
            color: context.appColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
            ),
            child: Icon(
              controller.isEdit.value
                  ? PhosphorIconsLight.pencilSimple
                  : PhosphorIconsLight.tag,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.isEdit.value ? 'Edit' : 'New'} Discount Rule",
                  style: TextHelper.h4Style(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Define rewards and applicability criteria",
                  style: TextHelper.captionStyle(
                    context,
                  ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
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
          // _buildMultiSelect(
          //   context,
          //   label: "Eligible Branches",
          //   items: controller.branches.map((e) => e.name).toList(),
          //   selectedItems: controller.selectedBranches
          //       .map(
          //         (id) =>
          //             controller.branches
          //                 .firstWhereOrNull((b) => b.id == id)
          //                 ?.name ??
          //             "",
          //       )
          //       .where((name) => name.isNotEmpty)
          //       .toList(),
          //   onSelected: (val) {
          //     final id = controller.branches
          //         .firstWhereOrNull((b) => b.name == val)
          //         ?.id;
          //     if (id != null && !controller.selectedBranches.contains(id)) {
          //       controller.selectedBranches.add(id);
          //     }
          //   },
          //   onRemoved: (val) {
          //     final id = controller.branches
          //         .firstWhereOrNull((b) => b.name == val)
          //         ?.id;
          //     if (id != null) controller.selectedBranches.remove(id);
          //   },
          // ),
          // const Gap(Sizes.defVerticalSpace),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Discount Title",
                  controller: controller.titleController,
                  hintText: "e.g. Summer Sale",
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Discount Code",
                  controller: controller.codeController,
                  hintText: "e.g. SUMMER50",
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountLogic(BuildContext context) {
    return EditSection(
      title: "Discount Logic",
      icon: PhosphorIconsLight.gear,
      child: Column(
        children: [
          SwitchListTile(
            title: Text(
              "Auto Apply",
              style: TextHelper.bodyMediumStyle(context),
            ),
            subtitle: Text(
              "Apply discount automatically if conditions are met",
              style: TextHelper.captionStyle(context),
            ),
            value: controller.autoApply.value,
            onChanged: (v) => controller.autoApply.value = v,
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          CustomDropdown(
            label: "Discount Applicable",
            items: controller.discountApplicableOptions.keys.toList(),
            value: controller.discountApplicableOptions.entries
                .firstWhereOrNull(
                  (e) => e.value == controller.discountApplicable.value,
                )
                ?.key,
            onChanged: (val) => controller.discountApplicable.value =
                controller.discountApplicableOptions[val]!,
          ),
          const Gap(Sizes.defVerticalSpace),
          SwitchListTile(
            title: Text(
              "Exclude Already Discounted",
              style: TextHelper.bodyMediumStyle(context),
            ),
            value: controller.excludeAlreadyDiscounted.value,
            onChanged: (v) => controller.excludeAlreadyDiscounted.value = v,
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          CustomDropdown(
            label: "Discount Mode",
            items: controller.discountApplicable.value == 'entire_bill'
                ? ["Normal"]
                : controller.discountModeOptions.keys.toList(),
            value: controller.discountModeOptions.entries
                .firstWhereOrNull(
                  (e) => e.value == controller.discountMode.value,
                )
                ?.key,
            onChanged: (val) => controller.discountMode.value =
                controller.discountModeOptions[val]!,
          ),
        ],
      ),
    );
  }

  Widget _buildModeSpecificSection(BuildContext context) {
    final mode = controller.discountMode.value;

    if (mode == 'normal') {
      return EditSection(
        title: "Discount Configuration",
        icon: PhosphorIconsLight.calculator,
        child: Row(
          children: [
            Expanded(
              child: CustomDropdown(
                label: "Type",
                items: controller.discountTypeOptions,
                value: controller.discountType.value,
                onChanged: (val) => controller.discountType.value = val,
              ),
            ),
            const Gap(Sizes.paddingM),
            Expanded(
              child: EditTextField(
                label: "Value",
                controller: controller.discountValueController,
                keyboardType: TextInputType.number,
                hintText: "0.00",
              ),
            ),
          ],
        ),
      );
    } else if (mode == 'range_wise') {
      return EditSection(
        title: "Range Wise Rules",
        icon: PhosphorIconsLight.listNumbers,
        trailing: IconButton(
          onPressed: controller.addRangeRule,
          icon: Icon(Icons.add_circle, color: context.appColors.primary),
        ),
        child: Column(
          children: [
            if (controller.rangeRules.isEmpty)
              Center(
                child: Text(
                  "No rules added. Click + to add.",
                  style: TextHelper.captionStyle(context),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.rangeRules.length,
                separatorBuilder: (_, _) => const Gap(Sizes.paddingS),
                itemBuilder: (context, index) {
                  final rule = controller.rangeRules[index];
                  return Container(
                    padding: const EdgeInsets.all(Sizes.paddingS),
                    decoration: BoxDecoration(
                      border: Border.all(color: context.appColors.border),
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: EditTextField(
                                label: "Min Qty",
                                initialValue: rule.minQty.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (v) => controller.rangeRules[index] =
                                    rule.copyWith(minQty: int.tryParse(v) ?? 0),
                              ),
                            ),
                            const Gap(Sizes.paddingS),
                            Expanded(
                              child: EditTextField(
                                label: "Max Qty",
                                initialValue: rule.maxQty.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (v) => controller.rangeRules[index] =
                                    rule.copyWith(maxQty: int.tryParse(v) ?? 0),
                              ),
                            ),
                          ],
                        ),
                        const Gap(Sizes.paddingS),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdown(
                                label: "Type",
                                items: controller.discountTypeOptions,
                                value: rule.discountType,
                                onChanged: (v) => controller.rangeRules[index] =
                                    rule.copyWith(discountType: v),
                              ),
                            ),
                            const Gap(Sizes.paddingS),
                            Expanded(
                              child: EditTextField(
                                label: "Value",
                                initialValue: rule.discountValue.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (v) => controller.rangeRules[index] =
                                    rule.copyWith(
                                      discountValue: double.tryParse(v) ?? 0,
                                    ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  controller.removeRangeRule(index),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      );
    } else if (mode == 'buy_x_get_y') {
      return EditSection(
        title: "Buy X Get Y Configuration",
        icon: PhosphorIconsLight.gift,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: EditTextField(
                    label: "Buy Quantity",
                    controller: controller.buyQtyController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: EditTextField(
                    label: "Get Quantity",
                    controller: controller.getQtyController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const Gap(Sizes.defVerticalSpace),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    label: "Get Discount Type",
                    items: controller.discountTypeOptions,
                    value: controller.getDiscountType.value,
                    onChanged: (v) => controller.getDiscountType.value = v,
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: EditTextField(
                    label: "Get Discount Value",
                    controller: controller.getDiscountValueController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const Gap(Sizes.defVerticalSpace),
            _buildMultiSelect(
              context,
              label: "Get Products",
              items: controller.products.map((e) => e.name).toList(),
              selectedItems: controller.products
                  .where((p) => controller.getProductIds.contains(p.id))
                  .map((p) => p.name)
                  .toList(),
              onSelected: (val) {
                final id = controller.products
                    .firstWhere((p) => p.name == val)
                    .id;
                if (!controller.getProductIds.contains(id)) {
                  controller.getProductIds.add(id);
                }
              },
              onRemoved: (val) {
                final id = controller.products
                    .firstWhere((p) => p.name == val)
                    .id;
                controller.getProductIds.remove(id);
              },
            ),
          ],
        ),
      );
    } else if (mode == 'product_at_fix_amount') {
      return EditSection(
        title: "Fixed Amount Configuration",
        icon: PhosphorIconsLight.money,
        child: Column(
          children: [
            EditTextField(
              label: "Fixed Price",
              controller: controller.fixAmountController,
              keyboardType: TextInputType.number,
              hintText: "0.00",
            ),
            const Gap(Sizes.defVerticalSpace),
            _buildMultiSelect(
              context,
              label: "Select Products",
              items: controller.products.map((e) => e.name).toList(),
              selectedItems: controller.products
                  .where((p) => controller.fixAmountProductIds.contains(p.id))
                  .map((p) => p.name)
                  .toList(),
              onSelected: (val) {
                final id = controller.products
                    .firstWhere((p) => p.name == val)
                    .id;
                if (!controller.fixAmountProductIds.contains(id)) {
                  controller.fixAmountProductIds.add(id);
                }
              },
              onRemoved: (val) {
                final id = controller.products
                    .firstWhere((p) => p.name == val)
                    .id;
                controller.fixAmountProductIds.remove(id);
              },
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildApplicabilitySection(BuildContext context) {
    if (controller.discountApplicable.value != 'product_wise') {
      return const SizedBox.shrink();
    }

    return EditSection(
      title: "Criteria & Applicability",
      icon: PhosphorIconsLight.intersect,
      child: Column(
        children: [
          CustomDropdown(
            label: "Applies To",
            items: controller.appliesToOptions.keys.toList(),
            value: controller.appliesToOptions.entries
                .firstWhereOrNull((e) => e.value == controller.appliesTo.value)
                ?.key,
            onChanged: (val) =>
                controller.appliesTo.value = controller.appliesToOptions[val]!,
          ),
          const Gap(Sizes.defVerticalSpace),
          _buildAppliesToSelector(context),
          const Gap(Sizes.defVerticalSpace),
          _buildMultiSelect(
            context,
            label: "Exclude Products",
            items: controller.products.map((e) => e.name).toList(),
            selectedItems: controller.products
                .where((p) => controller.excludeProducts.contains(p.id))
                .map((p) => p.name)
                .toList(),
            onSelected: (val) {
              final id = controller.products
                  .firstWhere((p) => p.name == val)
                  .id;
              if (!controller.excludeProducts.contains(id)) {
                controller.excludeProducts.add(id);
              }
            },
            onRemoved: (val) {
              final id = controller.products
                  .firstWhere((p) => p.name == val)
                  .id;
              controller.excludeProducts.remove(id);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppliesToSelector(BuildContext context) {
    final type = controller.appliesTo.value;
    if (type == 'specific_category') {
      return _buildMultiSelect(
        context,
        label: "Select Categories",
        items: controller.categories.map((e) => e.name).toList(),
        selectedItems: controller.categories
            .where((c) => controller.selectedCategories.contains(c.id))
            .map((c) => c.name)
            .toList(),
        onSelected: (val) {
          final id = controller.categories.firstWhere((c) => c.name == val).id;
          if (!controller.selectedCategories.contains(id)) {
            controller.selectedCategories.add(id);
          }
        },
        onRemoved: (val) {
          final id = controller.categories.firstWhere((c) => c.name == val).id;
          controller.selectedCategories.remove(id);
        },
      );
    } else if (type == 'specific_brand') {
      return _buildMultiSelect(
        context,
        label: "Select Brands",
        items: controller.brands.map((e) => e.name).toList(),
        selectedItems: controller.brands
            .where((b) => controller.selectedBrands.contains(b.id))
            .map((b) => b.name)
            .toList(),
        onSelected: (val) {
          final id = controller.brands.firstWhere((b) => b.name == val).id;
          if (!controller.selectedBrands.contains(id)) {
            controller.selectedBrands.add(id);
          }
        },
        onRemoved: (val) {
          final id = controller.brands.firstWhere((b) => b.name == val).id;
          controller.selectedBrands.remove(id);
        },
      );
    } else if (type == 'specific_products') {
      return _buildMultiSelect(
        context,
        label: "Select Products",
        items: controller.products.map((e) => e.name).toList(),
        selectedItems: controller.products
            .where((p) => controller.selectedProducts.contains(p.id))
            .map((p) => p.name)
            .toList(),
        onSelected: (val) {
          final id = controller.products.firstWhere((p) => p.name == val).id;
          if (!controller.selectedProducts.contains(id)) {
            controller.selectedProducts.add(id);
          }
        },
        onRemoved: (val) {
          final id = controller.products.firstWhere((p) => p.name == val).id;
          controller.selectedProducts.remove(id);
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildRequirementsSection(BuildContext context) {
    return EditSection(
      title: "Minimum Requirements",
      icon: PhosphorIconsLight.shieldCheck,
      child: Column(
        children: [
          CustomDropdown(
            label: "Requirement Type",
            items: controller.minRequirementOptions.keys.toList(),
            value: controller.minRequirementOptions.entries
                .firstWhereOrNull(
                  (e) => e.value == controller.minimumRequirement.value,
                )
                ?.key,
            onChanged: (val) => controller.minimumRequirement.value =
                controller.minRequirementOptions[val]!,
          ),
          if (controller.minimumRequirement.value != 'none') ...[
            const Gap(Sizes.defVerticalSpace),
            EditTextField(
              label:
                  controller.minimumRequirement.value == 'min_purchase_amount'
                  ? "Minimum Amount"
                  : "Minimum Quantity",
              controller: controller.minRequirementValueController,
              keyboardType: TextInputType.number,
              hintText: "0.00",
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLimitsAndDates(BuildContext context) {
    return EditSection(
      title: "Usage Limits & Schedule",
      icon: PhosphorIconsLight.calendarCheck,
      child: Column(
        children: [
          EditTextField(
            label: "Usage Limit",
            controller: controller.usageLimitController,
            keyboardType: TextInputType.number,
            hintText: "Total uses",
          ),
          const Gap(Sizes.defVerticalSpace),
          SwitchListTile(
            title: Text(
              "One Time Usage",
              style: TextHelper.bodyMediumStyle(context),
            ),
            value: controller.isOneTimeUsage.value,
            onChanged: (v) => controller.isOneTimeUsage.value = v,
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          Obx(
            () => Column(
              children: [
                SwitchListTile(
                  title: Text(
                    "Has End Date",
                    style: TextHelper.bodyMediumStyle(context),
                  ),
                  subtitle: Text(
                    "Toggle off if the discount runs indefinitely",
                    style: TextHelper.bodySmallStyle(
                      context,
                    ).copyWith(color: context.appColors.textSecondary),
                  ),
                  value: controller.hasEndDate.value,
                  onChanged: (v) => controller.hasEndDate.value = v,
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: context.appColors.primary,
                ),
                const Gap(Sizes.defVerticalSpace),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(
                        context,
                        label: "Start Date",
                        controller: controller.startDateController,
                      ),
                    ),
                    if (controller.hasEndDate.value) ...[
                      const Gap(Sizes.paddingM),
                      Expanded(
                        child: _buildDatePicker(
                          context,
                          label: "End Date",
                          controller: controller.endDateController,
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(Sizes.defVerticalSpace),
                Row(
                  children: [
                    Expanded(
                      child: _buildTimePicker(
                        context,
                        label: "Start Time",
                        controller: controller.startTimeController,
                      ),
                    ),
                    if (controller.hasEndDate.value) ...[
                      const Gap(Sizes.paddingM),
                      Expanded(
                        child: _buildTimePicker(
                          context,
                          label: "End Time",
                          controller: controller.endTimeController,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelect(
    BuildContext context, {
    required String label,
    required List<String> items,
    required List<String> selectedItems,
    required Function(String) onSelected,
    required Function(String) onRemoved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown(
          label: label,
          searchable: true,
          items: items,
          onChanged: onSelected,
        ),
        if (selectedItems.isNotEmpty) ...[
          const Gap(Sizes.paddingS),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: selectedItems.map((item) {
              return Chip(
                label: Text(
                  item,
                  style: TextHelper.bodySmallStyle(context).copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primary,
                  ),
                ),
                onDeleted: () => onRemoved(item),
                deleteIconColor: context.appColors.primary,
                deleteIcon: const Icon(Icons.close, size: 14),
                backgroundColor: context.appColors.primary.withValues(
                  alpha: 0.1,
                ),
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return EditSection(
      title: "Discount Image",
      icon: PhosphorIconsLight.image,
      child: Obx(
        () => EditImagePicker(
          imagePath: controller.selectedImageUrl.value,
          onPickImage: controller.pickImage,
          onRemoveImage: controller.removeImage,
          label: "Tap to select discount banner",
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(date);
        }
      },
      child: IgnorePointer(
        child: EditTextField(
          label: label,
          controller: controller,
          suffixIcon: const Icon(PhosphorIconsLight.calendar, size: 20),
        ),
      ),
    );
  }

  Widget _buildTimePicker(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
  }) {
    return InkWell(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          final hh = time.hour.toString().padLeft(2, '0');
          final mm = time.minute.toString().padLeft(2, '0');
          controller.text = "$hh:$mm:00";
        }
      },
      child: IgnorePointer(
        child: EditTextField(
          label: label,
          controller: controller,
          suffixIcon: const Icon(PhosphorIconsLight.clock, size: 20),
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.background,
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
                padding: const EdgeInsets.all(Sizes.paddingM),
                side: BorderSide(color: context.appColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextHelper.bodyMediumStyle(
                  context,
                ).copyWith(color: context.appColors.textSecondary),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => controller.save(),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.primary,
                padding: const EdgeInsets.all(Sizes.paddingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                elevation: 0,
              ),
              child: Text(
                controller.isEdit.value ? "Update Discount" : "Create Discount",
                style: TextHelper.bodyMediumStyle(
                  context,
                ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
