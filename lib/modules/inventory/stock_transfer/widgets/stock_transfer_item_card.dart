import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_add_edit_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StockTransferItemCard extends StatelessWidget {
  final int index;
  final StockTransferFormItem item;
  final StockTransferAddEditController controller;
  final VoidCallback onRemove;

  const StockTransferItemCard({
    super.key,
    required this.index,
    required this.item,
    required this.controller,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final double total = item.qty * item.price;
    final bool isLowStock = item.qty > item.availableQty;

    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(
          color: context.appColors.border.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Accent Line
              Container(
                width: 4,
                color: isLowStock
                    ? context.appColors.error
                    : context.appColors.primary,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.appColors.primary.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusS,
                              ),
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
                              item.productName.isEmpty
                                  ? "Select Product"
                                  : item.productName,
                              style: TextHelper.bodyLargeStyle(context)
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.appColors.textPrimary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: onRemove,
                            icon: Icon(
                              PhosphorIconsLight.trash,
                              color: context.appColors.error.withValues(
                                alpha: 0.8,
                              ),
                              size: 20,
                            ),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                      const Gap(Sizes.paddingS),

                      // Available Stock Badge
                      if (item.productId.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                (isLowStock
                                        ? context.appColors.error
                                        : AppColors.success)
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              Sizes.borderRadiusS,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isLowStock
                                    ? PhosphorIconsLight.warning
                                    : PhosphorIconsLight.checkCircle,
                                size: 14,
                                color: isLowStock
                                    ? context.appColors.error
                                    : AppColors.success,
                              ),
                              const Gap(4),
                              Text(
                                "Stock: ${item.availableQty}",
                                style: TextHelper.captionStyle(context)
                                    .copyWith(
                                      color: isLowStock
                                          ? context.appColors.error
                                          : AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),

                      const Gap(Sizes.paddingM),
                      const Divider(height: 1),
                      const Gap(Sizes.paddingM),

                      // Input Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: EditTextField(
                              label: "Quantity",
                              initialValue: item.qty.toString(),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                controller.items[index] = item.copyWith(
                                  qty: double.tryParse(v) ?? 0,
                                );
                              },
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: EditTextField(
                              label: "Price",
                              initialValue: item.price.toString(),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                controller.items[index] = item.copyWith(
                                  price: double.tryParse(v) ?? 0,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const Gap(Sizes.paddingM),

                      // Line Total Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Line Total",
                            style: TextHelper.captionStyle(
                              context,
                            ).copyWith(color: context.appColors.textSecondary),
                          ),
                          Text(
                            total.toStringAsFixed(2),
                            style: TextHelper.bodyMediumStyle(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.appColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
