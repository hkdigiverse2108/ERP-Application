import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/controllers/sales_credit_note_add_edit_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SalesCreditNoteItemCard extends StatelessWidget {
  final int index;
  final SalesCreditNoteItemState item;
  final SalesCreditNoteAddEditController controller;

  const SalesCreditNoteItemCard({
    super.key,
    required this.index,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: context.appColors.primary.withValues(
                  alpha: 0.1,
                ),
                child: Text(
                  "${index + 1}",
                  style: TextHelper.captionStyle(context).copyWith(
                    color: context.appColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: Text(
                  item.productName,
                  style: TextHelper.bodyLargeStyle(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: () => controller.removeItem(index),
                icon: Icon(
                  PhosphorIconsLight.trash,
                  color: context.appColors.error,
                  size: 20,
                ),
              ),
            ],
          ),
          const Divider(),
          const Gap(Sizes.paddingS),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Qty",
                  controller: TextEditingController(text: item.qty.toString()),
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      controller.updateItemQty(index, double.tryParse(v) ?? 0),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Free Qty",
                  controller: TextEditingController(
                    text: item.freeQty.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateItemFreeQty(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Price",
                  controller: TextEditingController(
                    text: item.price.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateItemPrice(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Disc Amt",
                  controller: TextEditingController(
                    text: item.discount1.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateItemDiscount(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tax (${item.taxPercent}%)",
                      style: TextHelper.captionStyle(context),
                    ),
                    const Gap(4),
                    Text(
                      item.tax.toStringAsFixed(2),
                      style: TextHelper.bodyMediumStyle(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total", style: TextHelper.captionStyle(context)),
                    const Gap(4),
                    Text(
                      item.total.toStringAsFixed(2),
                      style: TextHelper.bodyLargeStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
