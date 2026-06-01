import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/bank_cash/payment/controllers/payment_add_edit_controller.dart';
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

class PaymentAddEditView extends GetView<PaymentAddEditController> {
  const PaymentAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value && controller.isEdit.value) {
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
                  : PhosphorIconsLight.arrowUpRight,
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
                      ? "Edit ${controller.label}"
                      : "Add ${controller.label}",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Process advance ${controller.label.toLowerCase()}s or settle against vouchers",
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
          title: "General Information",
          icon: PhosphorIconsLight.info,
          child: Column(
            children: [
              CustomDropdown(
                label: "Party",
                items: controller.parties.map((e) => e.name).toList(),
                value: controller.party.value?.name,
                onChanged: (val) {
                  final p = controller.parties.firstWhereOrNull(
                    (e) => e.name == val,
                  );
                  controller.onPartyChanged(p);
                },
                searchable: true,
                readOnly: controller.isEdit.value,
                // enabled: !controller.isEdit.value,
              ),
              const Gap(Sizes.defVerticalSpace),
              // _buildCustomerSummary(context),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.paymentDate.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) controller.paymentDate.value = date;
                      },
                      child: IgnorePointer(
                        child: EditTextField(
                          label: "${controller.label} Date",
                          controller: TextEditingController(
                            text: DateFormat(
                              'dd MMM yyyy',
                            ).format(controller.paymentDate.value),
                          ),
                          suffixIcon: Icon(
                            PhosphorIconsLight.calendar,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(Sizes.defVerticalSpace),
              _buildTypeToggle(context),
              const Gap(Sizes.defVerticalSpace),
              EditTextField(
                label: "Amount",
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                readOnly: controller.paymentType.value == 'against_bill',
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "₹",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Gap(Sizes.defVerticalSpace),
              CustomDropdown(
                label: "Payment Mode",
                items: controller.paymentModes
                    .map((e) => e.capitalizeFirst!)
                    .toList(),
                value: controller.selectedPaymentMode.value.capitalizeFirst,
                onChanged: (val) =>
                    controller.onPaymentModeChanged(val.toLowerCase()),
                readOnly: controller.isEdit.value,
              ),
              if (controller.isBankRelated(
                controller.selectedPaymentMode.value,
              )) ...[
                const Gap(Sizes.defVerticalSpace),
                CustomDropdown(
                  label: "Bank Account",
                  items: controller.banks.map((e) => e.name).toList(),
                  value: controller.selectedBank.value?.name,
                  onChanged: (val) {
                    final b = controller.banks.firstWhereOrNull(
                      (e) => e.name == val,
                    );
                    controller.selectedBank.value = b;
                  },
                  // isLoading: controller.isBankLoading.value,
                  searchable: true,
                  readOnly: controller.isEdit.value,
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
        if (controller.paymentType.value == 'against_bill')
          _buildVoucherSection(context),
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

  Widget _buildTypeToggle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${controller.label} Type",
          style: TextHelper.bodySmallStyle(context).copyWith(
            color: context.appColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.appColors.background,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          ),
          child: Row(
            children: [
              _toggleItem(context, "Advance ${controller.label}", "advance"),
              _toggleItem(context, "Against Voucher", "against_bill"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toggleItem(BuildContext context, String label, String value) {
    final isSelected = controller.paymentType.value == value;
    return Expanded(
      child: GestureDetector(
        onTap: controller.isEdit.value
            ? null
            : () => controller.onPaymentTypeChanged(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? context.appColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: context.appColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextHelper.bodySmallStyle(context).copyWith(
              color: isSelected
                  ? Colors.white
                  : context.appColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherSection(BuildContext context) {
    return EditSection(
      title: "Voucher Details",
      icon: PhosphorIconsLight.receipt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown(
            label: "Select Sales/Voucher",
            items: controller.dueVouchers.map((e) => e.docNo).toList(),
            onChanged: (val) {
              final v = controller.dueVouchers.firstWhereOrNull(
                (e) => e.docNo == val,
              );
              if (v != null) controller.selectVoucher(v);
            },
            searchable: true,
            readOnly: !controller.isEdit.value,
          ),
          const Gap(Sizes.paddingM),
          if (controller.selectedVoucher.value == null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.paddingL),
                child: Text(
                  "No voucher selected",
                  style: TextStyle(color: context.appColors.textSecondary),
                ),
              ),
            )
          else
            _buildSelectedVoucherDetail(context),
        ],
      ),
    );
  }

  Widget _buildSelectedVoucherDetail(BuildContext context) {
    final item = controller.selectedVoucher.value!;
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        border: Border.all(
          color: context.appColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.voucherNo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red, size: 20),
                onPressed: () => controller.removeSelectedVoucher(),
              ),
            ],
          ),
          const Divider(),
          const Gap(8),
          Row(
            children: [
              _buildInfoItem(context, "Total", "₹${item.totalAmount}"),
              const Gap(16),
              _buildInfoItem(
                context,
                "Pending",
                "₹${item.pendingAmount}",
                color: Colors.red,
              ),
              const Spacer(),
              _buildInfoItem(
                context,
                "Remaining",
                "₹${controller.remainingAmount.toStringAsFixed(2)}",
                color: controller.remainingAmount == 0
                    ? Colors.green
                    : Colors.orange,
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Settlement Amount",
                  controller: controller.amountSettleController,
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.onAmountChanged(v),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Kasar",
                  controller: controller.kasarSettleController,
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.onKasarChanged(v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value, {
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextHelper.captionStyle(
            context,
          ).copyWith(color: context.appColors.textSecondary),
        ),
        Text(
          value,
          style: TextHelper.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
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
                  : Text(
                      controller.isEdit.value
                          ? "Update"
                          : "Save ${controller.label}",
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCustomerSummary(BuildContext context) {
  //   return Obx(() {
  //     final details = controller.customerDetails.value;
  //     if (details == null) return const SizedBox.shrink();

  //     return Container(
  //       margin: const EdgeInsets.only(bottom: Sizes.defVerticalSpace),
  //       padding: const EdgeInsets.all(Sizes.paddingM),
  //       decoration: BoxDecoration(
  //         color: context.appColors.primary.withValues(alpha: 0.05),
  //         borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
  //         border: Border.all(
  //           color: context.appColors.primary.withValues(alpha: 0.1),
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               _buildSummaryItem(
  //                 context,
  //                 "Total Due",
  //                 "₹${details.totalDueAmount.toStringAsFixed(2)}",
  //                 Colors.red,
  //               ),
  //               _buildSummaryItem(
  //                 context,
  //                 "Total Purchase",
  //                 "₹${details.totalPurchaseAmount.toStringAsFixed(2)}",
  //                 context.appColors.primary,
  //               ),
  //               _buildSummaryItem(
  //                 context,
  //                 "Loyalty Points",
  //                 details.customer?.loyaltyPoints.toInt().toString() ?? "0",
  //                 Colors.orange,
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  // Widget _buildSummaryItem(
  //   BuildContext context,
  //   String label,
  //   String value,
  //   Color color,
  // ) {
  //   return Column(
  //     children: [
  //       Text(
  //         label,
  //         style: TextHelper.captionStyle(
  //           context,
  //         ).copyWith(color: context.appColors.textSecondary),
  //       ),
  //       const Gap(4),
  //       Text(
  //         value,
  //         style: TextHelper.bodyMedium.copyWith(
  //           color: color,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
