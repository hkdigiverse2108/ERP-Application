import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:ai_setu/shared/widgets/app_showcase_tooltip.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

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
  final Function(T item)? onRemoveItem;
  final Function(T item)? onEditItem;
  final Function(T item)? onRowTap;
  final bool Function(T item)? canEdit;
  final bool Function(T item)? canDelete;
  final String? addLabel;
  final Widget? emptyState;
  final Widget? footer;
  final bool showSerial;
  final bool isLoading;
  final double? rowPadding;
  final GlobalKey? showcaseKey;

  // Pagination params
  final int? currentPage;
  final int? totalPages;
  final Function(int)? onPageChanged;
  final int? totalItems;
  final int pageSize;

  const CommonTable({
    super.key,
    required this.items,
    required this.columns,
    this.onAddItem,
    this.onRemoveItem,
    this.onEditItem,
    this.onRowTap,
    this.canEdit,
    this.canDelete,
    this.addLabel,
    this.emptyState,
    this.footer,
    this.showSerial = true,
    this.isLoading = false,
    this.rowPadding,
    this.currentPage,
    this.totalPages,
    this.onPageChanged,
    this.totalItems,
    this.pageSize = 10,
    this.showcaseKey,
  });

  static const double _colSerial = 40;
  static const double _colActions = 90;

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
      light: context.appColors.primary.withValues(alpha: 0.08),
      dark: context.appColors.primary.withValues(alpha: 0.25),
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
                  if (isLoading)
                    _buildLoadingOverlay(borderColor)
                  else if (items.isEmpty)
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
        if (totalPages != null) ...[
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
          _buildAddButton(context),
        ],
      ],
    );
  }

  Widget _buildLoadingOverlay(Color borderColor) {
    return _CommonTableShimmer(
      rowCount: (items.isNotEmpty) ? items.length : pageSize,
      borderColor: borderColor,
      columnWidths: [
        if (showSerial) _colSerial,
        ...columns.map((c) => c.width),
        if (onRemoveItem != null || onEditItem != null) _colActions,
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
      padding: EdgeInsets.symmetric(
        vertical: (rowPadding ?? Sizes.paddingS) + 2,
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
            _headerCell('Actions', width: _colActions, align: TextAlign.center),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {required double width, TextAlign? align}) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: _getAlignment(align ?? TextAlign.left),
        child: Text(
          text,
          textAlign: align ?? TextAlign.left,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Alignment _getAlignment(TextAlign alignment) {
    switch (alignment) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.left:
      case TextAlign.start:
        return Alignment.centerLeft;
      case TextAlign.end:
        return Alignment.centerRight;
      case TextAlign.justify:
        return Alignment.centerLeft;
    }
  }

  Widget _buildDataRow(
    BuildContext context,
    int index,
    Color rowColor,
    Color borderColor,
  ) {
    final item = items[index];
    Widget rowContent = InkWell(
      onTap: onRowTap != null ? () => onRowTap!(item) : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: rowPadding ?? Sizes.paddingS,
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
                child: Text(
                  '${index + 1 + ((currentPage ?? 1) - 1) * pageSize}',
                  style: TextHelper.bodySmall,
                ),
              ),

            // Dynamic Columns
            ...columns.map(
              (col) => SizedBox(
                width: col.width,
                child: Align(
                  alignment: _getAlignment(col.alignment),
                  child: col.cellBuilder(context, item, index),
                ),
              ),
            ),

            // Actions
            if (onRemoveItem != null || onEditItem != null)
              Builder(
                builder: (context) {
                  final showEdit =
                      onEditItem != null && (canEdit?.call(item) ?? true);
                  final showDelete =
                      onRemoveItem != null && (canDelete?.call(item) ?? true);

                  if (!showEdit && !showDelete) {
                    return const SizedBox(width: _colActions);
                  }

                  return SizedBox(
                    width: _colActions,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showEdit)
                          _buildActionIcon(
                            context,
                            icon: PhosphorIconsBold.pencilSimple,
                            color: context.appColors.primary,
                            onTap: () => onEditItem?.call(item),
                            tooltip: 'Edit',
                          ),
                        if (showEdit && showDelete) const SizedBox(width: 8),
                        if (showDelete)
                          _buildActionIcon(
                            context,
                            icon: PhosphorIconsBold.trash,
                            color: AppColors.error,
                            onTap: () => onRemoveItem?.call(item),
                            tooltip: 'Delete',
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );

    if (index == 0 && showcaseKey != null) {
      return Showcase.withWidget(
        key: showcaseKey!,
        container: AppShowcaseTooltip(
          title: Strings.showcaseRowTitle,
          description: Strings.showcaseRowDesc,
          onNext: () => ShowcaseView.get().next(),
          onSkip: () => ShowcaseView.get().dismiss(),
        ),
        targetShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
        ),
        targetPadding: const EdgeInsets.all(4),
        child: rowContent,
      );
    }

    return rowContent;
  }

  Widget _buildEmptyState(Color surfaceColor) {
    return Builder(
      builder: (context) => Container(
        color: surfaceColor,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Icon(
              PhosphorIconsLight.package,
              size: 40,
              color: context.appColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text('No items added yet', style: TextHelper.label),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onAddItem,
        icon: const Icon(PhosphorIconsBold.plus, size: 16),
        label: Text(addLabel ?? 'Add Item'),
        style: OutlinedButton.styleFrom(
          foregroundColor: context.appColors.primary,
          side: BorderSide(color: context.appColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class _CommonTableShimmer extends StatefulWidget {
  final int rowCount;
  final List<double> columnWidths;
  final Color borderColor;

  const _CommonTableShimmer({
    required this.rowCount,
    required this.columnWidths,
    required this.borderColor,
  });

  @override
  State<_CommonTableShimmer> createState() => _CommonTableShimmerState();
}

class _CommonTableShimmerState extends State<_CommonTableShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: List.generate(
            widget.rowCount,
            (index) => TableShimmer.buildShimmerRow(
              animationValue: _animation.value,
              baseColor: baseColor,
              highlightColor: highlightColor,
              borderColor: widget.borderColor,
              columnWidths: widget.columnWidths,
            ),
          ),
        );
      },
    );
  }
}
