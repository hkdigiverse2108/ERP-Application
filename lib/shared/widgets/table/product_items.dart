import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ai_setu/data/model/product_item_model.dart';

class ProductItems extends StatelessWidget {
  final List<ProductItemModel> items;
  final VoidCallback? onAddItem;
  final Function(int index)? onRemoveItem;
  final Function(int index)? onEditItem;

  const ProductItems({
    super.key,
    this.items = const [],
    this.onAddItem,
    this.onRemoveItem,
    this.onEditItem,
  });

  // Fixed column widths for horizontal scrolling
  static const double _colSerial = 40;
  static const double _colItem = 140;
  static const double _colQty = 80;
  static const double _colPrice = 100;
  static const double _colAmount = 100;
  static const double _colDiscount = 100;
  static const double _colTax = 100;
  static const double _colTotal = 100;
  static const double _colActions = 40;

  double get _totalTableWidth =>
      _colSerial +
      _colItem +
      _colQty +
      _colPrice +
      _colAmount +
      _colDiscount +
      _colTax +
      _colTotal +
      ((onRemoveItem != null || onEditItem != null) ? _colActions : 0);

  @override
  Widget build(BuildContext context) {
    final borderColor = context.responsive(
      light: AppColors.lightBorder,
      dark: AppColors.darkBorder,
    );
    final headerBg = context.responsive(
      light: AppColors.primary.withValues(alpha: 0.08),
      dark: AppColors.primary.withValues(alpha: 0.25),
    );
    final surfaceColor = context.responsive(
      light: AppColors.lightSurface,
      dark: AppColors.darkSurface,
    );
    final stripColor = context.responsive(
      light: AppColors.lightBackground,
      dark: AppColors.darkBackground,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scrollable Table (horizontal + vertical)
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: _totalTableWidth,
              child: Column(
                children: [
                  // Header Row (stays at top)
                  _buildHeaderRow(headerBg),

                  // Data Rows (vertical scroll)
                  if (items.isEmpty)
                    _buildEmptyState(surfaceColor)
                  else
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(items.length, (index) {
                            return _buildDataRow(
                              context,
                              index,
                              index.isEven ? surfaceColor : stripColor,
                              borderColor,
                            );
                          }),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // Total Section
        if (items.isNotEmpty) ...[
          const SizedBox(height: Sizes.smallSpace),
          _buildTotalSection(borderColor, surfaceColor),
        ],

        // Add Item Button
        if (onAddItem != null) ...[
          const SizedBox(height: Sizes.defHorizontalSpace),
          _buildAddButton(),
        ],
      ],
    );
  }

  Widget _buildHeaderRow(Color headerBg) {
    return Container(
      color: headerBg,
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.paddingS + 2,
        horizontal: Sizes.paddingS,
      ),
      child: Row(
        children: [
          _headerCell('#', width: _colSerial),
          _headerCell('Item', width: _colItem),
          _headerCell('Qty', width: _colQty, align: TextAlign.center),
          _headerCell('Price', width: _colPrice, align: TextAlign.right),
          _headerCell('Amount', width: _colAmount, align: TextAlign.right),
          _headerCell('Discount', width: _colDiscount, align: TextAlign.right),
          _headerCell('Tax', width: _colTax, align: TextAlign.right),
          // _headerCell('Total', width: _colTotal, align: TextAlign.right),
          if (onRemoveItem != null || onEditItem != null)
            SizedBox(width: _colActions),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {required double width, TextAlign? align}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: align ?? TextAlign.left,
        style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildDataRow(
    BuildContext context,
    int index,
    Color rowColor,
    Color borderColor,
  ) {
    final item = items[index];
    return Obx(
      () => Container(
        color: rowColor,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.paddingS,
          horizontal: Sizes.paddingS,
        ),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: borderColor, width: 0.5)),
        ),
        child: Row(
          children: [
            // Serial No
            SizedBox(
              width: _colSerial,
              child: Text('${index + 1}', style: TextHelper.bodySmall),
            ),

            // Item Name + SKU
            SizedBox(
              width: _colItem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextHelper.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.sku.isNotEmpty)
                    Text(
                      item.sku,
                      style: TextHelper.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

            // Quantity + Unit
            SizedBox(
              width: _colQty,
              child: Text(
                '${item.quantity} ${item.unit}',
                textAlign: TextAlign.center,
                style: TextHelper.bodySmall,
              ),
            ),

            // Price
            SizedBox(
              width: _colPrice,
              child: Text(
                '₹${item.price.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: TextHelper.bodySmall,
              ),
            ),

            // Amount
            SizedBox(
              width: _colAmount,
              child: Text(
                '₹${item.subtotal.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: TextHelper.bodySmall,
              ),
            ),

            // Discount
            SizedBox(
              width: _colDiscount,
              child: Text(
                item.discount > 0
                    ? '${item.discount.toStringAsFixed(1)}%'
                    : '-',
                textAlign: TextAlign.right,
                style: TextHelper.bodySmall.copyWith(
                  color: item.discount > 0 ? AppColors.success : null,
                ),
              ),
            ),

            // Tax
            SizedBox(
              width: _colTax,
              child: Text(
                item.tax > 0 ? '${item.tax.toStringAsFixed(1)}%' : '-',
                textAlign: TextAlign.right,
                style: TextHelper.bodySmall,
              ),
            ),

            // Total
            SizedBox(
              width: _colTotal,
              child: Text(
                '₹${item.total.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: TextHelper.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Actions
            if (onRemoveItem != null || onEditItem != null)
              SizedBox(
                width: _colActions,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  iconSize: 18,
                  icon: Icon(PhosphorIconsBold.dotsThreeVertical, size: 16),
                  onSelected: (value) {
                    if (value == 'edit') onEditItem?.call(index);
                    if (value == 'delete') onRemoveItem?.call(index);
                  },
                  itemBuilder: (context) => [
                    if (onEditItem != null)
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(PhosphorIconsBold.pencilSimple, size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                    if (onRemoveItem != null)
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              PhosphorIconsBold.trash,
                              size: 16,
                              color: AppColors.error,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(color: AppColors.error),
                            ),
                          ],
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

  Widget _buildEmptyState(Color surfaceColor) {
    return Container(
      color: surfaceColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(
            PhosphorIconsLight.package,
            size: 40,
            color: AppColors.lightTextSecondary,
          ),
          const SizedBox(height: 8),
          Text('No items added yet', style: TextHelper.label),
        ],
      ),
    );
  }

  Widget _buildTotalSection(Color borderColor, Color surfaceColor) {
    double subtotal = 0;
    double totalDiscount = 0;
    double totalTax = 0;
    double grandTotal = 0;

    for (final item in items) {
      subtotal += item.subtotal;
      totalDiscount += item.discountAmount;
      totalTax += item.taxAmount;
      grandTotal += item.total;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        color: surfaceColor,
      ),
      padding: const EdgeInsets.all(Sizes.paddingS),
      child: Column(
        children: [
          _totalRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
          if (totalDiscount > 0)
            _totalRow(
              'Discount',
              '- ₹${totalDiscount.toStringAsFixed(2)}',
              valueColor: AppColors.success,
            ),
          if (totalTax > 0)
            _totalRow('Tax', '+ ₹${totalTax.toStringAsFixed(2)}'),
          const Divider(height: 16),
          _totalRow(
            'Grand Total',
            '₹${grandTotal.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _totalRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold ? TextHelper.bodyBold : TextHelper.bodySmall,
          ),
          Text(
            value,
            style: (isBold ? TextHelper.bodyBold : TextHelper.bodySmall)
                .copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onAddItem,
        icon: Icon(PhosphorIconsBold.plus, size: 16),
        label: Text('Add Item'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
