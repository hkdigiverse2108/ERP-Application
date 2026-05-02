import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/sales/invoice/controllers/invoice_add_edit_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceSummarySection extends StatelessWidget {
  final InvoiceAddEditController controller;

  const InvoiceSummarySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingL),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction Summary",
            style: TextHelper.h4Style(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(Sizes.paddingL),
          _SummaryRow(
            label: "Gross Amount",
            value: controller.grossAmount,
          ),
          _SummaryRow(
            label: "Total Discount",
            value: controller.totalDiscount,
            isNegative: true,
          ),
          const Divider(height: Sizes.paddingL),
          _SummaryRow(
            label: "Taxable Amount",
            value: controller.taxableAmount,
            isBold: true,
          ),
          _SummaryRow(
            label: "Total Tax",
            value: controller.totalTaxAmount,
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Flat Discount",
                  controller: controller.flatDiscountController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Round Off",
                  controller: controller.roundOffController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingL),
          Container(
            padding: const EdgeInsets.all(Sizes.paddingM),
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Net Amount",
                  style: TextHelper.h4Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.netAmount.value.toStringAsFixed(2),
                    style: TextHelper.h3Style(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final RxDouble value;
  final bool isNegative;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isNegative = false,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.paddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextHelper.bodyMediumStyle(context).copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Obx(
            () => Text(
              "${isNegative ? '-' : ''}${value.value.toStringAsFixed(2)}",
              style: TextHelper.bodyMediumStyle(context).copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isNegative ? context.appColors.error : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
