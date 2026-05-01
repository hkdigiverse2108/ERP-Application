import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/crm/loyalty/controllers/loyalty_add_edit_controller.dart';
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

class LoyaltyAddEditView extends GetView<LoyaltyAddEditController> {
  const LoyaltyAddEditView({super.key});

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
                _buildForm(context),
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
              controller.isEdit.value
                  ? PhosphorIconsLight.pencilSimple
                  : PhosphorIconsLight.plus,
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
                  "${controller.isEdit.value ? 'Edit' : 'Add'} Loyalty",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage customer rewards and loyalty programs",
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

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        EditSection(
          title: "Loyalty Details",
          icon: PhosphorIconsLight.gift,
          child: Column(
            children: [
              EditTextField(
                label: "Campaign Name",
                controller: controller.nameController,
                hintText: "Enter campaign name",
              ),
              const Gap(Sizes.defVerticalSpace),
              Row(
                children: [
                  Expanded(
                    child: EditTextField(
                      label: "Discount Value",
                      controller: controller.discountValueController,
                      keyboardType: TextInputType.number,
                      hintText: "0",
                    ),
                  ),
                  const Gap(Sizes.paddingS),
                  Expanded(
                    child: CustomDropdown(
                      label: "Type",
                      items: controller.displayTypes,
                      value: controller.currentTypeDisplay,
                      onChanged: (val) => controller.onTypeDisplayChanged(val),
                    ),
                  ),
                ],
              ),
              const Gap(Sizes.defVerticalSpace),
              Row(
                children: [
                  Expanded(
                    child: EditTextField(
                      label: "Minimum Purchase Amount",
                      controller: controller.minPurchaseAmountController,
                      keyboardType: TextInputType.number,
                      hintText: "0.00",
                    ),
                  ),
                  const Gap(Sizes.paddingS),
                  Expanded(
                    child: EditTextField(
                      label: "Redemption Points",
                      controller: controller.redemptionPointsController,
                      keyboardType: TextInputType.number,
                      hintText: "0",
                    ),
                  ),
                ],
              ),
              const Gap(Sizes.defVerticalSpace),
              EditTextField(
                label: "Usage Limit",
                controller: controller.usageLimitController,
                keyboardType: TextInputType.number,
                hintText: "0",
              ),
              const Gap(Sizes.defVerticalSpace),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      label: "Launch Date",
                      value: controller.launchDate.value,
                      onChanged: (date) => controller.launchDate.value = date,
                    ),
                  ),
                  const Gap(Sizes.paddingS),
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      label: "Expiry Date",
                      value: controller.expiryDate.value,
                      onChanged: (date) => controller.expiryDate.value = date,
                    ),
                  ),
                ],
              ),
              const Gap(Sizes.defVerticalSpace),
              EditTextField(
                label: "Description",
                controller: controller.descriptionController,
                hintText: "Enter campaign description",
                maxLines: 3,
              ),
            ],
          ),
        ),
        const Gap(Sizes.paddingL),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text("Single Time Use"),
                value: controller.singleTimeUse.value,
                onChanged: (v) => controller.singleTimeUse.value = v,
                contentPadding: EdgeInsets.zero,
                activeThumbColor: context.appColors.primary,
              ),
              SwitchListTile(
                title: const Text("Is Active"),
                value: controller.isActive.value,
                onChanged: (v) => controller.isActive.value = v,
                contentPadding: EdgeInsets.zero,
                activeThumbColor: context.appColors.primary,
              ),
            ],
          ),
        ),
        const Gap(Sizes.paddingL),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildDatePicker(
    BuildContext context, {
    required String label,
    required DateTime value,
    required Function(DateTime) onChanged,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) onChanged(date);
      },
      child: IgnorePointer(
        child: EditTextField(
          label: label,
          controller: TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(value),
          ),
          suffixIcon: const Icon(PhosphorIconsLight.calendar, size: 20),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: const Text("Cancel"),
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.isSaving.value
                  ? null
                  : () => controller.save(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
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
                  : Text(controller.isEdit.value ? "Update" : "Save"),
            ),
          ),
        ],
      ),
    );
  }
}
