import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/accounting/credit/controllers/credit_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/images/edit_image_picker.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreditAddEditView extends GetView<CreditAddEditController> {
  const CreditAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
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
        ),
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
                  "${controller.isEdit ? 'Edit' : 'Add'} Credit Note",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Record credit notes for accounting",
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
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          EditSection(
            title: "General Information",
            icon: PhosphorIconsLight.info,
            child: Column(
              children: [
                EditTextField(
                  label: "Person Name",
                  controller: controller.personNameController,
                  validator: (val) =>
                      val == null || val.isEmpty ? "Required" : null,
                  prefixIcon: const Icon(PhosphorIconsLight.user, size: 20),
                ),
                const Gap(Sizes.defVerticalSpace),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: EditTextField(
                        label: "Code",
                        controller: controller.countryCodeController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const Gap(Sizes.paddingS),
                    Expanded(
                      child: EditTextField(
                        label: "Phone Number",
                        controller: controller.phoneNoController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(
                          PhosphorIconsLight.phone,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Sizes.defVerticalSpace),
                _buildDatePicker(context),
              ],
            ),
          ),
          const Gap(Sizes.paddingL),
          EditSection(
            title: "Financial Details",
            icon: PhosphorIconsLight.currencyCircleDollar,
            child: Column(
              children: [
                EditTextField(
                  label: "Amount",
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val == null || val.isEmpty ? "Required" : null,
                  prefixIcon: const Icon(PhosphorIconsLight.money, size: 20),
                ),
                const Gap(Sizes.defVerticalSpace),
                Obx(
                  () => CustomDropdown(
                    label: "Bank Account",
                    items: controller.bankAccounts.map((e) => e.name).toList(),
                    value: controller.bankAccounts
                        .firstWhereOrNull(
                          (e) => e.id == controller.selectedBankAccountId.value,
                        )
                        ?.name,
                    onChanged: (val) {
                      final account = controller.bankAccounts.firstWhere(
                        (e) => e.name == val,
                      );
                      controller.selectedBankAccountId.value = account.id;
                    },
                  ),
                ),
              ],
            ),
          ),
          const Gap(Sizes.paddingL),
          EditSection(
            title: "Additional Notes",
            icon: PhosphorIconsLight.note,
            child: EditTextField(
              label: "Description",
              controller: controller.descriptionController,
              maxLines: 3,
            ),
          ),
          const Gap(Sizes.paddingL),
          _buildImageSection(context),
          const Gap(Sizes.paddingXL),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: controller.selectedDate.value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          controller.onDateSelected(date);
        }
      },
      child: IgnorePointer(
        child: EditTextField(
          label: "Date",
          controller: controller.dateController,
          validator: (val) => val == null || val.isEmpty ? "Required" : null,
          suffixIcon: const Icon(PhosphorIconsLight.calendar, size: 20),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return EditSection(
      title: "Attachment",
      icon: PhosphorIconsLight.image,
      child: Center(
        child: Obx(
          () => EditImagePicker(
            imagePath: controller.selectedImageUrl.value,
            onPickImage: controller.pickImage,
            onRemoveImage: controller.removeImage,
            label: "Tap to select credit note image",
          ),
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
              onPressed: () =>
                  controller.isSaving.value ? null : controller.save(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: Obx(
                () => controller.isSaving.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
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
