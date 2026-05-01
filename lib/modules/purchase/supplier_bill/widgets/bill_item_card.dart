import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/controllers/supplier_bill_add_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BillItemCard extends StatelessWidget {
  final int index;
  final SupplierBillItem item;
  final SupplierBillAddEditController controller;
  final VoidCallback onRemove;

  const BillItemCard({
    super.key,
    required this.index,
    required this.item,
    required this.controller,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(color: context.appColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Product Name and Remove Button
          Padding(
            padding: const EdgeInsets.all(Sizes.paddingM),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.appColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    PhosphorIconsLight.package,
                    color: context.appColors.primary,
                    size: 20,
                  ),
                ),
                const Gap(Sizes.paddingS),
                Expanded(
                  child: Text(
                    item.productName,
                    style: TextHelper.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
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
                    color: context.appColors.error,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Input Fields Grid
          Padding(
            padding: const EdgeInsets.all(Sizes.paddingM),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: "Quantity",
                        initialValue: item.qty.toString(),
                        onChanged: (v) => controller.updateItemQty(
                          index,
                          double.tryParse(v) ?? 0,
                        ),
                      ),
                    ),
                    const Gap(Sizes.paddingM),
                    Expanded(
                      child: _buildInputField(
                        label: "Unit Cost",
                        initialValue: item.unitCost.toString(),
                        onChanged: (v) => controller.updateItemPrice(
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
                      child: _buildInputField(
                        label: "Disc Amt",
                        initialValue: item.discountAmount.toString(),
                        onChanged: (v) => controller.updateItemDiscount(
                          index,
                          double.tryParse(v) ?? 0,
                        ),
                      ),
                    ),
                    const Gap(Sizes.paddingM),
                    Expanded(
                      child: _buildInputField(
                        label: "MRP",
                        initialValue: item.mrp.toString(),
                        onChanged: (v) {
                          controller.billItems[index] = item.copyWith(
                            mrp: double.tryParse(v) ?? 0,
                          );
                          controller.calculateTotals();
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(Sizes.paddingM),
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: "Selling Price",
                        initialValue: item.sellingPrice.toString(),
                        onChanged: (v) {
                          controller.billItems[index] = item.copyWith(
                            sellingPrice: double.tryParse(v) ?? 0,
                          );
                          controller.calculateTotals();
                        },
                      ),
                    ),
                    const Gap(Sizes.paddingM),
                    Expanded(
                      child: _buildInputField(
                        label: "Free Qty",
                        initialValue: item.freeQty.toString(),
                        onChanged: (v) {
                          controller.billItems[index] = item.copyWith(
                            freeQty: double.tryParse(v) ?? 0,
                          );
                          controller.calculateTotals();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Footer with Calculations
          Container(
            padding: const EdgeInsets.all(Sizes.paddingM),
            decoration: BoxDecoration(
              color: context.appColors.background.withValues(alpha: 0.3),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(Sizes.borderRadiusL),
                bottomRight: Radius.circular(Sizes.borderRadiusL),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoItem(
                      isLeftAligned: true,
                      "Taxable Amount",
                      "₹${item.taxable.toStringAsFixed(2)}",
                      context,
                    ),
                    _buildInfoItem(
                      "Tax Amount",
                      "₹${item.tax.toStringAsFixed(2)}",
                      context,
                    ),
                  ],
                ),
                const Gap(Sizes.paddingS),
                const Divider(height: 1, thickness: 0.5),
                const Gap(Sizes.paddingS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoItem(
                      isLeftAligned: true,
                      "Landing Price",
                      "₹${item.landingPrice.toStringAsFixed(2)}",
                      context,
                      valueColor: context.appColors.primary,
                      isBold: true,
                    ),
                    _buildInfoItem(
                      "Margin",
                      "₹${item.margin.toStringAsFixed(2)}",
                      context,
                      valueColor: item.margin >= 0
                          ? context.appColors.success
                          : context.appColors.error,
                      isBold: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const Gap(4),
        TextFormField(
          initialValue: initialValue,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    BuildContext context, {
    Color? valueColor,
    bool isLeftAligned = false,
    bool isBold = false,
  }) {
    return Column(
      crossAxisAlignment: isLeftAligned
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextHelper.captionStyle(
            context,
          ).copyWith(color: context.appColors.textSecondary, fontSize: 10),
        ),
        const Gap(2),
        Text(
          value,
          style: TextHelper.bodySmall.copyWith(
            color: valueColor ?? context.appColors.textPrimary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
