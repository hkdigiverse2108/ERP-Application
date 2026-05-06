import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/settings/taxes/controllers/tax_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TaxAddEditView extends GetView<TaxAddEditController> {
  const TaxAddEditView({super.key});

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

          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const QuickAction(),
                  const Gap(Sizes.paddingS),
                  _buildHeader(context),
                  const Gap(Sizes.paddingS),
                  _buildInfoSection(context),
                  const Gap(Sizes.paddingXL),
                ],
              ),
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
                  : PhosphorIconsLight.percent,
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
                  controller.isEdit ? "Edit Tax" : "Add Tax",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Configure tax rates for your business",
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

  Widget _buildInfoSection(BuildContext context) {
    return EditSection(
      title: "Tax Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          EditTextField(
            label: "Tax Name",
            controller: controller.nameController,
            hintText: "e.g. GST 18%",
            validator: (v) =>
                v == null || v.isEmpty ? "Name is required" : null,
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Percentage (%)",
            controller: controller.percentageController,
            hintText: "e.g. 18",
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v == null || v.isEmpty) return "Percentage is required";
              final val = double.tryParse(v);
              if (val == null) return "Invalid number";
              if (val < 0) return "Cannot be negative";
              return null;
            },
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Text(
                "Active Status",
                style: TextHelper.bodyMediumStyle(context).copyWith(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Obx(
                () => Switch(
                  value: controller.isActive.value,
                  onChanged: controller.setIsActive,
                  activeThumbColor: context.appColors.primary,
                ),
              ),
            ],
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
                    : () => controller.saveTax(),
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
                        controller.isEdit ? "Update Tax" : "Save Tax",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
