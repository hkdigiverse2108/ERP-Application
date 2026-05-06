import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/settings/consumption_type/controllers/consumption_type_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConsumptionTypeAddEditView
    extends GetView<ConsumptionTypeAddEditController> {
  const ConsumptionTypeAddEditView({super.key});

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
                  _buildInformationSection(context),
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
                  : PhosphorIconsLight.plusCircle,
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
                      ? "Edit Consumption Type"
                      : "Add Consumption Type",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Define types for material consumption tracking",
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

  Widget _buildInformationSection(BuildContext context) {
    return EditSection(
      title: "Type Details",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          EditTextField(
            label: "Type Name",
            controller: controller.nameController,
            hintText: "e.g. Wastage, Production",
            readOnly: controller.isSystemGenerated,
            validator: (v) =>
                v == null || v.isEmpty ? "Name is required" : null,
          ),
          const Gap(Sizes.paddingM),
          _buildSwitchTile(
            context,
            title: "Active Status",
            subtitle: "Enable or disable this consumption type",
            value: controller.isActive,
            onChanged: controller.setIsActive,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextHelper.bodyMediumStyle(context).copyWith(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(subtitle, style: TextHelper.captionStyle(context)),
            ],
          ),
        ),
        Obx(
          () => Switch(
            value: value.value,
            onChanged: onChanged,
            activeThumbColor: context.appColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Obx(() {
      if (controller.isSystemGenerated) return const SizedBox.shrink();
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
                      : () => controller.saveConsumptionType(),
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
                          controller.isEdit ? "Update Type" : "Save Type",
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
    });
  }
}
