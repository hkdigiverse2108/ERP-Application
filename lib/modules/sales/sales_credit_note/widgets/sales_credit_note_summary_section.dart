import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/controllers/sales_credit_note_add_edit_controller.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SalesCreditNoteSummarySection extends StatelessWidget {
  final SalesCreditNoteAddEditController controller;

  const SalesCreditNoteSummarySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return EditSection(
      title: "Summary",
      icon: PhosphorIconsLight.calculator,
      child: Column(
        children: [
          _buildRow(context, "Gross Amount", controller.grossAmount),
          _buildRow(
            context,
            "Item Discount",
            controller.discountAmount,
            isNegative: true,
          ),
          const Divider(height: Sizes.paddingXL),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: EditTextField(
                  label: "Flat Discount",
                  controller: controller.flatDiscountController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                flex: 1,
                child: EditTextField(
                  label: "Round Off",
                  controller: controller.roundOffController,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingXL),
          _buildRow(context, "Taxable Amount", controller.taxableAmount),
          _buildRow(context, "Total Tax", controller.taxAmount),
          const Gap(Sizes.paddingM),
          Container(
            padding: const EdgeInsets.all(Sizes.paddingM),
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
              border: Border.all(
                color: context.appColors.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Net Amount",
                  style: TextHelper.bodyLargeStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.netAmount.value.toStringAsFixed(2),
                    style: TextHelper.h6Style(context).copyWith(
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

  Widget _buildRow(
    BuildContext context,
    String label,
    RxDouble value, {
    bool isNegative = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextHelper.bodyMediumStyle(
              context,
            ).copyWith(color: context.appColors.textSecondary),
          ),
          Obx(
            () => Text(
              "${isNegative ? '-' : ''}${value.value.toStringAsFixed(2)}",
              style: TextHelper.bodyLargeStyle(context).copyWith(
                fontWeight: FontWeight.w600,
                color: isNegative
                    ? context.appColors.error
                    : context.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
