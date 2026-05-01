import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_add_edit_controller.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';

class DebitNoteSummarySection extends StatelessWidget {
  final PurchaseDebitNoteAddEditController controller;

  const DebitNoteSummarySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return EditSection(
      title: "Summary",
      icon: PhosphorIconsLight.chartBar,
      child: Obx(
        () => Column(
          children: [
            _buildSummaryRow(
              context,
              "Gross Amount",
              controller.grossAmount.value,
              icon: PhosphorIconsLight.money,
            ),
            _buildSummaryRow(
              context,
              "Total Discount",
              controller.totalDiscount.value,
              icon: PhosphorIconsLight.tag,
            ),
            _buildSummaryRow(
              context,
              "Taxable Amount",
              controller.taxableAmount.value,
              icon: PhosphorIconsLight.receipt,
            ),
            _buildSummaryRow(
              context,
              "Total Tax",
              controller.totalTaxAmount.value,
              icon: PhosphorIconsLight.percent,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.paddingS),
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextField(
                    label: "Flat Discount",
                    controller: controller.flatDiscountController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(PhosphorIconsLight.minusCircle),
                    onChanged: (_) => controller.calculateTotals(),
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: EditTextField(
                    label: "Round Off",
                    controller: controller.roundOffController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(PhosphorIconsLight.arrowsClockwise),
                    onChanged: (_) => controller.calculateTotals(),
                  ),
                ),
              ],
            ),
            const Gap(Sizes.paddingM),
            Container(
              padding: const EdgeInsets.all(Sizes.paddingM),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                border: Border.all(
                  color: context.appColors.primary.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Net Amount",
                        style: TextHelper.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.appColors.textSecondary,
                        ),
                      ),
                      Text(
                        "Final debit note amount",
                        style: TextHelper.captionStyle(context),
                      ),
                    ],
                  ),
                  Text(
                    "₹${controller.netAmount.value.toStringAsFixed(2)}",
                    style: TextHelper.h5Style(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    double value, {
    required IconData icon,
    bool isNegative = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: context.appColors.textSecondary),
          const Gap(8),
          Expanded(
            child: Text(
              label,
              style: TextHelper.bodySmall.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextHelper.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: isNegative
                  ? context.appColors.error
                  : context.appColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
