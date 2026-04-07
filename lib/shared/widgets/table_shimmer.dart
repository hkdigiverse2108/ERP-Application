import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';

class TableShimmer extends StatefulWidget {
  final int rowCount;
  final List<double>? columnWidths;
  final double? padding;

  const TableShimmer({
    super.key,
    this.rowCount = 5,
    this.columnWidths,
    this.padding = 0,
  });

  @override
  State<TableShimmer> createState() => _TableShimmerState();

  static Widget buildShimmerRow({
    required double animationValue,
    required Color baseColor,
    required Color highlightColor,
    bool isHeader = false,
    Color? borderColor,
    List<double>? columnWidths,
  }) {
    final widths = columnWidths ?? [140, 100, 100, 100, 100, 100];

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.paddingS + 4,
        horizontal: Sizes.paddingS,
      ),
      decoration: BoxDecoration(
        color: isHeader ? baseColor.withValues(alpha: 0.2) : null,
        border: borderColor != null
            ? Border(top: BorderSide(color: borderColor, width: 0.5))
            : null,
      ),
      child: Row(
        children: widths.map((width) {
          return Container(
            width: width,
            height: isHeader ? 16 : 12,
            margin: const EdgeInsets.only(right: Sizes.paddingS),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment(animationValue - 1, -0.3),
                end: Alignment(animationValue + 1, 0.3),
                colors: [baseColor, highlightColor, baseColor],
                stops: const [0.1, 0.5, 0.9],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TableShimmerState extends State<TableShimmer>
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
    final isDark = ThemeService().isDarkMode;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Padding(
      padding: EdgeInsets.all(widget.padding ?? 0),
      child: BorderContainer(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row shimmer
                  TableShimmer.buildShimmerRow(
                    animationValue: _animation.value,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    isHeader: true,
                  ),
                  // Data rows shimmer
                  ...List.generate(
                    widget.rowCount,
                    (index) => TableShimmer.buildShimmerRow(
                      animationValue: _animation.value,
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      isHeader: false,
                      borderColor: borderColor,
                      columnWidths: widget.columnWidths,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
