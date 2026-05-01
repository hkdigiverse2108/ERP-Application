import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/bank_cash/expense/controllers/expense_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:ai_setu/shared/widgets/images/edit_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExpenseAddEditView extends GetView<ExpenseAddEditController> {
  const ExpenseAddEditView({super.key});

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
    final title = controller.isSalary.value ? "Salary" : "Expense";
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
                  "${controller.isEdit.value ? 'Edit' : 'Add'} $title",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage your business ${title.toLowerCase()} records",
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
          title: "${controller.isSalary.value ? 'Salary' : 'Expense'} Details",
          icon: PhosphorIconsLight.info,
          child: Column(
            children: [
              CustomDropdown(
                label: "Party",
                items: controller.parties.map((e) => e.name).toList(),
                value: controller.parties
                    .firstWhereOrNull(
                      (e) => e.id == controller.selectedPartyId.value,
                    )
                    ?.name,
                onChanged: (val) {
                  final p = controller.parties.firstWhere((e) => e.name == val);
                  controller.selectedPartyId.value = p.id;
                },
                searchable: true,
              ),
              const Gap(Sizes.defVerticalSpace),
              CustomDropdown(
                label: "Expense Type",
                items: controller.isSalary.value
                    ? controller.salaryTypes
                    : controller.expenseTypes,
                value: controller.selectedType.value,
                onChanged: (val) => controller.selectedType.value = val,
              ),
              const Gap(Sizes.defVerticalSpace),
              if (!controller.isSalary.value)
                _buildDatePicker(
                  context,
                  label: "Expense Date",
                  value: controller.fromDate.value,
                  onChanged: (date) => controller.fromDate.value = date,
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(
                        context,
                        label: "From Date",
                        value: controller.fromDate.value,
                        onChanged: (date) => controller.fromDate.value = date,
                      ),
                    ),
                    const Gap(Sizes.paddingS),
                    Expanded(
                      child: _buildDatePicker(
                        context,
                        label: "To Date",
                        value: controller.toDate.value,
                        onChanged: (date) => controller.toDate.value = date,
                      ),
                    ),
                  ],
                ),
              const Gap(Sizes.defVerticalSpace),
              Row(
                children: [
                  Expanded(
                    child: EditTextField(
                      label: "Amount",
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "₹",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  if (controller.isSalary.value) ...[
                    const Gap(Sizes.paddingS),
                    Expanded(
                      child: EditTextField(
                        label: "Incentive",
                        controller: controller.incentiveController,
                        keyboardType: TextInputType.number,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "₹",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (controller.isSalary.value) ...[
                const Gap(Sizes.defVerticalSpace),
                EditTextField(
                  label: "Total",
                  controller: controller.totalController,
                  readOnly: true,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "₹",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              const Gap(Sizes.defVerticalSpace),
              EditTextField(
                label: "Description",
                controller: controller.descriptionController,
                maxLines: 2,
              ),
            ],
          ),
        ),
        const Gap(Sizes.paddingL),
        _buildImageSection(context),
        const Gap(Sizes.paddingL),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
          child: SwitchListTile(
            title: const Text("Is Active"),
            value: controller.isActive.value,
            onChanged: (v) => controller.isActive.value = v,
            contentPadding: EdgeInsets.zero,
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
            text: DateFormat('dd MMM yyyy').format(value),
          ),
          suffixIcon: const Icon(PhosphorIconsLight.calendar, size: 20),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return EditSection(
      title: "Image",
      icon: PhosphorIconsLight.image,
      child: Center(
        child: Obx(
          () => EditImagePicker(
            imagePath: controller.selectedImageUrl.value,
            onPickImage: controller.pickImage,
            onRemoveImage: controller.removeImage,
            label: "Tap to select receipt image",
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
