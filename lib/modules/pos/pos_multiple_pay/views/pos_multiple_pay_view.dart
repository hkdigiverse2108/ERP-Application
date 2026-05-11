import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/pos/pos_multiple_pay/controllers/pos_multiple_pay_controller.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/pos_widgets.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PosMultiplePayView extends GetView<PosMultiplePayController> {
  const PosMultiplePayView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.appColors.background,
        appBar: AppBar(
          title: Text(
            "Multiple Payment",
            style: TextHelper.h6Style(
              context,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: context.appColors.surface,
          foregroundColor: context.appColors.textPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Get.back(),
          ),
          actions: [
            TextButton.icon(
              onPressed: controller.resetPayments,
              icon: Icon(
                Icons.refresh,
                size: 18,
                color: context.appColors.error,
              ),
              label: Text(
                "Reset",
                style: TextHelper.bodySmallStyle(context).copyWith(
                  color: context.appColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(8),
          ],
        ),
        body: Column(
          children: [
            _buildAmountSummary(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(Sizes.paddingM),
                    _buildCustomerHeader(context),
                    const Gap(24),
                    Row(
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          size: 20,
                          color: context.appColors.primary,
                        ),
                        const Gap(8),
                        Text(
                          "Payment Distribution",
                          style: TextHelper.bodyLargeStyle(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(16),
                    _buildPaymentFormList(context),
                    const Gap(16),
                    _buildPayLaterSection(context),
                    const Gap(24),
                    Center(child: _buildAddButton(context)),
                    const Gap(40),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomAction(context),
      ),
    );
  }

  Widget _buildAmountSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(bottom: BorderSide(color: context.appColors.border)),
      ),
      child: Obx(
        () => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            SummaryCard(
              label: "Total Payable",
              value: "₹${controller.totalAmount.value.toStringAsFixed(2)}",
              bgColor: context.responsive(
                light: context.appColors.primary.withValues(alpha: 0.05),
                dark: context.appColors.primary.withValues(alpha: 0.1),
              ),
              textColor: context.appColors.primary,
            ),
            SummaryCard(
              label: "Total Paid",
              value: "₹${controller.paidAmount.value.toStringAsFixed(2)}",
              bgColor: context.responsive(
                light: context.appColors.success.withValues(alpha: 0.05),
                dark: context.appColors.success.withValues(alpha: 0.1),
              ),
              textColor: context.appColors.success,
            ),
            SummaryCard(
              label: "Balance",
              value: "₹${controller.balanceAmount.value.toStringAsFixed(2)}",
              bgColor: context.responsive(
                light: context.appColors.error.withValues(alpha: 0.05),
                dark: context.appColors.error.withValues(alpha: 0.1),
              ),
              textColor: context.appColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerHeader(BuildContext context) {
    return Obx(() {
      final customer = controller.selectedCustomer.value;
      if (customer == null) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(color: context.appColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: context.appColors.primary.withValues(alpha: 0.1),
              child: Icon(
                Icons.person_outline,
                color: context.appColors.primary,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: TextHelper.bodyLargeStyle(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${customer.phoneNo.countryCode} ${customer.phoneNo.phoneNo}",
                    style: TextHelper.bodySmallStyle(
                      context,
                    ).copyWith(color: context.appColors.textSecondary),
                  ),
                ],
              ),
            ),
            if (customer.customerType != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.appColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  customer.customerType!.toUpperCase(),
                  style: TextHelper.captionStyle(context).copyWith(
                    color: context.appColors.info,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildPaymentFormList(BuildContext context) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.paymentLines.length,
        separatorBuilder: (context, index) => const Gap(20),
        itemBuilder: (context, index) {
          final line = controller.paymentLines[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
              border: Border.all(color: context.appColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.appColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "PAYMENT #${index + 1}",
                        style: TextHelper.bodySmallStyle(context).copyWith(
                          color: context.appColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    if (controller.paymentLines.length > 1)
                      IconButton(
                        onPressed: () => controller.removePaymentLine(index),
                        icon: Icon(
                          Icons.delete_outline,
                          color: context.appColors.error,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
                const Gap(16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomDropdown<PaymentMethod>(
                        label: "Method",
                        items: controller.availableMethods,
                        value: line.method.value,
                        onChanged: (val) => line.method.value = val,
                        itemLabelBuilder: (m) => m.name,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      flex: 3,
                      child: EditTextField(
                        label: "Amount",
                        controller: line.amountController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.currency_rupee, size: 16),
                        onChanged: (_) => controller.calculateTotals(),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                _buildDetailsSection(context, line),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context, PaymentLine line) {
    return Obx(() {
      final method = line.method.value.name.toLowerCase();
      if (method == 'cash') return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.appColors.background.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          border: Border.all(
            color: context.appColors.border.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  line.method.value.icon,
                  size: 14,
                  color: context.appColors.textSecondary,
                ),
                const Gap(6),
                Text(
                  "${line.method.value.name} Details",
                  style: TextHelper.bodySmallStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const Gap(12),
            CustomDropdown<IdNameModel>(
              label: "Select Account",
              items: controller.bankAccounts,
              value: line.selectedAccount.value,
              onChanged: (val) => line.selectedAccount.value = val,
              itemLabelBuilder: (m) => m.name,
            ),
            if (method == 'card') ...[
              const Gap(12),
              EditTextField(
                label: "Card Holder Name",
                controller: line.cardHolderController,
                hintText: "Enter name",
              ),
              const Gap(12),
              EditTextField(
                label: "Transaction No.",
                controller: line.transactionNoController,
                hintText: "Enter number",
              ),
            ],
            if (method == 'cheque' || method == 'upi' || method == 'bank') ...[
              const Gap(12),
              EditTextField(
                label: method == 'upi'
                    ? "Transaction ID / UPI ID"
                    : (method == 'cheque' ? "Cheque Number" : "Ref Number"),
                controller: line.transactionNoController,
                hintText: "Enter reference",
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildAddButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: controller.addPaymentLine,
      icon: const Icon(Icons.add_rounded, size: 20),
      label: const Text("ADD ANOTHER METHOD"),
      style: OutlinedButton.styleFrom(
        foregroundColor: context.appColors.primary,
        side: BorderSide(color: context.appColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(top: BorderSide(color: context.appColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Obx(() {
        final canProcess =
            (controller.balanceAmount.value == 0 ||
                controller.payLaterData.value != null) &&
            controller.paidAmount.value >= 0; // Allow 0 paid if it's all pay later

        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: canProcess
                    ? () => controller.processPayment()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary.withValues(
                    alpha: 0.1,
                  ),
                  foregroundColor: context.appColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "COMPLETE",
                  style: TextHelper.bodyMediumStyle(context).copyWith(
                    color: context.appColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: canProcess
                    ? () => controller.processPayment(shouldPrint: true)
                    : null,
                icon: const Icon(Icons.print, size: 20),
                label: Text(
                  "COMPLETE & PRINT",
                  style: TextHelper.bodyMediumStyle(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPayLaterSection(BuildContext context) {
    return Obx(() {
      if (controller.balanceAmount.value <= 0) return const SizedBox.shrink();

      final payLater = controller.payLaterData.value;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: payLater != null
              ? context.appColors.success.withValues(alpha: 0.05)
              : context.appColors.error.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(
            color: payLater != null
                ? context.appColors.success.withValues(alpha: 0.2)
                : context.appColors.error.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 18,
                        color: payLater != null
                            ? context.appColors.success
                            : context.appColors.error,
                      ),
                      const Gap(8),
                      Text(
                        "Pay Later Balance",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: payLater != null
                              ? context.appColors.success
                              : context.appColors.error,
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    payLater != null
                        ? "Terms configured for ₹${controller.balanceAmount.value.toStringAsFixed(2)}"
                        : "Configure payment terms for the remaining ₹${controller.balanceAmount.value.toStringAsFixed(2)}",
                    style: TextHelper.bodySmallStyle(context).copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (payLater == null)
              ElevatedButton(
                onPressed: controller.openPayLaterSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.error,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("CONFIGURE"),
              )
            else
              IconButton(
                onPressed: controller.removePayLater,
                icon: Icon(Icons.close, color: context.appColors.error),
              ),
          ],
        ),
      );
    });
  }
}
