import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/settings/payment_terms/controllers/payment_terms_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentTermsAddEditView extends GetView<PaymentTermsAddEditController> {
  const PaymentTermsAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(),
      drawer: AppDrawer(),
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
                QuickAction(),
                const Gap(Sizes.paddingS),
                _buildHeader(context),
                _buildInformationSection(context),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(Sizes.paddingS),
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            ),
            child: Icon(
              controller.isEdit
                  ? PhosphorIconsLight.pencilSimple
                  : PhosphorIconsLight.calendarCheck,
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
                      ? "Modify Payment Term"
                      : "Create New Payment Term",
                  style: TextHelper.h5Style(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Set up credit periods for your transactions",
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
      title: "Term Information",
      child: Column(
        children: [
          EditTextField(
            label: "Term Name",
            controller: controller.nameController,
            hintText: "e.g. Net 30",
            validator: (v) =>
                v == null || v.isEmpty ? "Name is required" : null,
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Days",
            controller: controller.dayController,
            hintText: "Number of days",
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v == null || v.isEmpty) return "Days is required";
              if (int.tryParse(v) == null) return "Invalid number";
              return null;
            },
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Active Status",
                      style: TextHelper.bodyMediumStyle(context).copyWith(
                        color: context.appColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Enable or disable this term",
                      style: TextHelper.captionStyle(context),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Switch(
                  value: controller.isActive.value,
                  onChanged: controller.setIsActive,
                  activeThumbColor: context.appColors.primary,
                ),
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
                      "Default Term",
                      style: TextHelper.bodyMediumStyle(context).copyWith(
                        color: context.appColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Use as primary payment term",
                      style: TextHelper.captionStyle(context),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Switch(
                  value: controller.isDefault.value,
                  onChanged: controller.setIsDefault,
                  activeThumbColor: context.appColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        bottom: MediaQuery.of(context).padding.bottom + Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: context.appColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                side: BorderSide(color: context.appColors.border),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(color: context.appColors.textPrimary),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : () => controller.savePaymentTerm(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                  elevation: 0,
                ),
                child: controller.isSaving.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Text(controller.isEdit ? "Update" : "Save"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Gap extends StatelessWidget {
  final double size;
  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size);
  }
}
