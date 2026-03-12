import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TableColumn<T> {
  final String title;
  final double width;
  final TextAlign alignment;
  final Widget Function(BuildContext context, T item, int index) cellBuilder;

  TableColumn({
    required this.title,
    this.width = 100,
    this.alignment = TextAlign.left,
    required this.cellBuilder,
  });
}

class CommonTable<T> extends StatelessWidget {
  final List<T> items;
  final List<TableColumn<T>> columns;
  final VoidCallback? onAddItem;
  final Function(int index)? onRemoveItem;
  final Function(int index)? onEditItem;
  final String? addLabel;
  final Widget? emptyState;
  final Widget? footer;
  final bool showSerial;

  // Pagination params
  final int? currentPage;
  final int? totalPages;
  final Function(int)? onPageChanged;
  final int? totalItems;

  const CommonTable({
    super.key,
    required this.items,
    required this.columns,
    this.onAddItem,
    this.onRemoveItem,
    this.onEditItem,
    this.addLabel,
    this.emptyState,
    this.footer,
    this.showSerial = true,
    this.currentPage,
    this.totalPages,
    this.onPageChanged,
    this.totalItems,
  });

  static const double _colSerial = 40;
  static const double _colActions = 40;

  double get _totalTableWidth {
    double width = Sizes.paddingS * 2;
    if (showSerial) width += _colSerial;
    for (var col in columns) {
      width += col.width;
    }
    if (onRemoveItem != null || onEditItem != null) width += _colActions;
    return width;
  }

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
                  // Header Row
                  _buildHeaderRow(headerBg),

                  // Data Rows
                  if (items.isEmpty)
                    emptyState ?? _buildEmptyState(surfaceColor)
                  else
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 400),
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

        // Pagination
        if (totalPages != null && totalPages! > 1) ...[
          const SizedBox(height: Sizes.smallSpace),
          _buildPagination(context, borderColor, surfaceColor),
        ],

        // Footer Section
        if (footer != null) ...[
          const SizedBox(height: Sizes.smallSpace),
          footer!,
        ],

        // Add Item Button
        if (onAddItem != null) ...[
          const SizedBox(height: Sizes.defHorizontalSpace),
          _buildAddButton(),
        ],
      ],
    );
  }

  Widget _buildPagination(
    BuildContext context,
    Color borderColor,
    Color surfaceColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Info
          if (totalItems != null)
            Text('Total: $totalItems items', style: TextHelper.caption)
          else
            const SizedBox.shrink(),

          // Controls
          Row(
            children: [
              IconButton(
                onPressed: currentPage! > 1
                    ? () => onPageChanged?.call(currentPage! - 1)
                    : null,
                icon: const Icon(PhosphorIconsBold.caretLeft, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              Text(
                'Page $currentPage of $totalPages',
                style: TextHelper.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: currentPage! < totalPages!
                    ? () => onPageChanged?.call(currentPage! + 1)
                    : null,
                icon: const Icon(PhosphorIconsBold.caretRight, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
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
          if (showSerial) _headerCell('#', width: _colSerial),
          ...columns.map(
            (col) =>
                _headerCell(col.title, width: col.width, align: col.alignment),
          ),
          if (onRemoveItem != null || onEditItem != null)
            const SizedBox(width: _colActions),
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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.paddingS,
        horizontal: Sizes.paddingS,
      ),
      decoration: BoxDecoration(
        color: rowColor,
        border: Border(top: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: Row(
        children: [
          // Serial No
          if (showSerial)
            SizedBox(
              width: _colSerial,
              child: Text('${index + 1}', style: TextHelper.bodySmall),
            ),

          // Dynamic Columns
          ...columns.map(
            (col) => SizedBox(
              width: col.width,
              child: col.cellBuilder(context, item, index),
            ),
          ),

          // Actions
          if (onRemoveItem != null || onEditItem != null)
            SizedBox(
              width: _colActions,
              child: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                iconSize: 18,
                icon: const Icon(PhosphorIconsBold.dotsThreeVertical, size: 16),
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

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onAddItem,
        icon: const Icon(PhosphorIconsBold.plus, size: 16),
        label: Text(addLabel ?? 'Add Item'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
