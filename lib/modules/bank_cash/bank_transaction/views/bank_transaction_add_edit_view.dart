import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/bank_cash/bank_transaction/controllers/bank_transaction_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BankTransactionAddEditView
    extends GetView<BankTransactionAddEditController> {
  const BankTransactionAddEditView({super.key});

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
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      _buildTransactionDetails(context),
                      const Gap(Sizes.paddingL),
                      _buildActionButtons(context),
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
              controller.isEdit.value
                  ? PhosphorIconsLight.pencilSimple
                  : PhosphorIconsLight.arrowsLeftRight,
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
                      ? "Edit Bank Transaction"
                      : "Add Bank Transaction",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage deposits, withdrawals and transfers",
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

  Widget _buildTransactionDetails(BuildContext context) {
    return EditSection(
      title: "Transaction Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          CustomDropdown(
            label: "Transaction Type",
            items: controller.transactionTypes,
            value: controller.transactionType.value,
            onChanged: (val) {
              controller.transactionType.value = val;
            },
          ),
          const Gap(Sizes.defVerticalSpace),
          Obx(() => Row(
                children: [
                  if (controller.transactionType.value.toLowerCase() != 'deposit')
                    Expanded(
                      child: CustomDropdown(
                        label: "From Account",
                        items: controller.bankList.map((e) => e.name).toList(),
                        value: (controller.fromAccount.value?.name ?? "")
                                .isEmpty
                            ? null
                            : controller.fromAccount.value!.name,
                        onChanged: (val) => controller.onBankChanged(val, true),
                        searchable: true,
                      ),
                    ),
                  if (controller.transactionType.value.toLowerCase() == 'transfer')
                    const Gap(Sizes.paddingM),
                  if (controller.transactionType.value.toLowerCase() !=
                      'withdrawal')
                    Expanded(
                      child: CustomDropdown(
                        label: "To Account",
                        items: controller.bankList.map((e) => e.name).toList(),
                        value: (controller.toAccount.value?.name ?? "")
                                .isEmpty
                            ? null
                            : controller.toAccount.value!.name,
                        onChanged: (val) =>
                            controller.onBankChanged(val, false),
                        searchable: true,
                      ),
                    ),
                ],
              )),
          const Gap(Sizes.defVerticalSpace),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Amount",
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Date",
                  controller: controller.dateController,
                  readOnly: true,
                  onTap: () => controller.selectDate(context),
                  suffixIcon: const Icon(PhosphorIconsLight.calendar),
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
              ),
            ],
          ),
          const Gap(Sizes.defVerticalSpace),
          EditTextField(
            label: "Description",
            controller: controller.descriptionController,
            maxLines: 3,
            hintText: "Enter transaction details...",
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.isSaving.value
                  ? null
                  : () => controller.saveTransaction(),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: controller.isSaving.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      controller.isEdit.value
                          ? "Update Transaction"
                          : "Save Transaction",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          const Gap(Sizes.paddingS),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                side: BorderSide(color: context.appColors.border),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
