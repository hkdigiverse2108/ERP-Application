import 'package:ai_setu/core/services/theme_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppBarChart extends StatefulWidget {
  final List<List<double>> values;
  final List<String> labels;
  final List<Color>? colors;
  final List<String>? seriesNames;
  final String Function(String label, double visibleRange)? labelFormatter;
  final double? maxY;
  final double aspectRatio;

  const AppBarChart({
    super.key,
    required this.values,
    required this.labels,
    this.labelFormatter,
    this.colors,
    this.seriesNames,
    this.maxY,
    this.aspectRatio = 1.5,
  }) : assert(
         colors == null ||
             seriesNames == null ||
             colors.length == seriesNames.length,
         'colors and seriesNames must have the same length',
       );

  @override
  State<AppBarChart> createState() => _AppBarChartState();
}

class _AppBarChartState extends State<AppBarChart> {
  double _minX = 0;
  double _maxX = 0;

  // Gesture tracking
  double _initialMinX = 0;
  double _initialMaxX = 0;

  @override
  void initState() {
    super.initState();
    _resetRange();
  }

  @override
  void didUpdateWidget(AppBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.labels.length != widget.labels.length) {
      _resetRange();
    }
  }

  void _resetRange() {
    _minX = 0;
    _maxX = (widget.labels.length > 1 ? widget.labels.length - 1 : 1)
        .toDouble();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _initialMinX = _minX;
    _initialMaxX = _maxX;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details, double chartWidth) {
    if (chartWidth <= 0) return;

    // 1. Handle Panning (Translation)
    if (details.scale == 1.0 && details.pointerCount == 1) {
      final double deltaX = details.focalPointDelta.dx;
      final double dataDelta = -(deltaX / chartWidth) * (_maxX - _minX);

      setState(() {
        _minX += dataDelta;
        _maxX += dataDelta;
        _clampRange();
      });
      return;
    }

    // 2. Handle Zooming (Scaling)
    if (details.scale != 1.0) {
      final double scaleFactor = details.scale;
      final double focalPointX = details.localFocalPoint.dx;

      // Map focal point to data space
      final double focalDataX =
          _initialMinX +
          (focalPointX / chartWidth) * (_initialMaxX - _initialMinX);

      setState(() {
        _minX = focalDataX - (focalDataX - _initialMinX) / scaleFactor;
        _maxX = focalDataX + (_initialMaxX - focalDataX) / scaleFactor;
        _clampRange();
      });
    }
  }

  void _clampRange() {
    final double maxRange = (widget.labels.length - 1).toDouble();
    if (_maxX - _minX > maxRange) {
      _minX = 0;
      _maxX = maxRange;
    }
    if (_minX < 0) {
      final double diff = -_minX;
      _minX = 0;
      _maxX += diff;
    }
    if (_maxX > maxRange) {
      final double diff = _maxX - maxRange;
      _maxX = maxRange;
      _minX -= diff;
    }
    // Prevent zooming in too much (min 2 items)
    if (_maxX - _minX < 1.0) {
      _maxX = _minX + 1.0;
    }

    // Final safety clamp
    _minX = _minX.clamp(0, maxRange);
    _maxX = _maxX.clamp(0, maxRange);
  }

  double get _calculatedMaxY {
    if (widget.maxY != null) return widget.maxY!;
    if (widget.values.isEmpty) return 100;

    double maxVal = 0;
    for (var group in widget.values) {
      for (var val in group) {
        if (val > maxVal) maxVal = val;
      }
    }
    return maxVal > 0 ? maxVal * 1.2 : 100;
  }

  double _calculateRodWidth(int itemsCount, int maxRodsPerItem) {
    double rodWidth = 16.0;
    if (itemsCount > 30) {
      rodWidth = 4.0;
    } else if (itemsCount > 15) {
      rodWidth = 8.0;
    } else if (itemsCount > 7) {
      rodWidth = 12.0;
    }

    // Scale width based on zoom level relative to full view
    final double zoomScale = (widget.labels.length - 1) / (_maxX - _minX);
    rodWidth = rodWidth * zoomScale;

    return rodWidth.clamp(2.0, 40.0) /
        (maxRodsPerItem > 2 ? maxRodsPerItem * 0.5 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = context.appColors.textPrimary;
    final gridLineColor = context.appColors.border.withValues(alpha: 0.5);
    final defaultColor = context.appColors.sectionSell;

    final double maxYValue = _calculatedMaxY;
    final int maxRodsPerItem = widget.values.fold(
      0,
      (max, g) => g.length > max ? g.length : max,
    );

    // Visible range determines label interval
    final double visibleRange = _maxX - _minX;
    final int labelInterval = (visibleRange / 6).ceil().clamp(1, 100);

    final double yInterval = maxYValue > 0 ? (maxYValue / 5) : 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Legend ──
        if (widget.seriesNames != null && widget.colors != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 8),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              children: List.generate(
                widget.seriesNames!.length,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: widget.colors![index % widget.colors!.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.seriesNames![index],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // ── Chart Area ──
        AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Row(
            children: [
              // 1. Fixed Y-Axis
              SizedBox(
                width: 45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 35),
                  child: BarChart(
                    BarChartData(
                      maxY: maxYValue,
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                            interval: yInterval,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) return const SizedBox();
                              return SideTitleWidget(
                                meta: meta,
                                space: 8,
                                child: Text(
                                  _formatYAxisValue(value),
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: const [],
                    ),
                  ),
                ),
              ),

              // 2. Main Data View (Gesture Controlled)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double chartWidth = constraints.maxWidth;

                    return GestureDetector(
                      onScaleStart: _handleScaleStart,
                      onScaleUpdate: (details) =>
                          _handleScaleUpdate(details, chartWidth),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: maxYValue,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (_) =>
                                    context.appColors.background,
                                tooltipBorder: BorderSide(
                                  color: context.appColors.border,
                                  width: 1,
                                ),
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                      final actualIndex = group.x.toInt();
                                      if (actualIndex < 0 ||
                                          actualIndex >= widget.labels.length) {
                                        return null;
                                      }

                                      final rawLabel = widget.labels[actualIndex];
                                      final label = widget.labelFormatter?.call(rawLabel, visibleRange) ?? rawLabel;
                                      final seriesName =
                                          (widget.seriesNames != null &&
                                               rodIndex <
                                                   widget.seriesNames!.length)
                                           ? widget.seriesNames![rodIndex]
                                           : null;

                                      return BarTooltipItem(
                                        '$label\n',
                                        TextStyle(
                                          color: rod.color ?? defaultColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          if (seriesName != null)
                                            TextSpan(
                                              text: '$seriesName: ',
                                              style: TextStyle(
                                                color: textColor.withValues(
                                                  alpha: 0.7,
                                                ),
                                                fontSize: 12,
                                              ),
                                            ),
                                          TextSpan(
                                            text: rod.toY.toStringAsFixed(2),
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 35,
                                  interval: labelInterval.toDouble(),
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index < 0 ||
                                        index >= widget.labels.length ||
                                        index % labelInterval != 0) {
                                      return const SizedBox();
                                    }
                                    final rawLabel = widget.labels[index];
                                    final label = widget.labelFormatter?.call(rawLabel, visibleRange) ?? rawLabel;
                                    return SideTitleWidget(
                                      meta: meta,
                                      space: 8,
                                      child: Text(
                                        label,
                                        style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: yInterval,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: gridLineColor,
                                strokeWidth: 1,
                                dashArray: [5, 5],
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: widget.values.asMap().entries
                                .where((e) => e.key >= _minX.floor() && e.key <= _maxX.ceil())
                                .map(
                                  (e) => BarChartGroupData(
                                    x: e.key,
                                    barsSpace: 2.0,
                                    barRods: List.generate(
                                      e.value.length,
                                      (rodIndex) => BarChartRodData(
                                        toY: e.value[rodIndex],
                                        color: (widget.colors != null &&
                                            rodIndex < widget.colors!.length)
                                            ? widget.colors![rodIndex]
                                            : defaultColor,
                                        width: _calculateRodWidth(
                                          widget.labels.length,
                                          maxRodsPerItem,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatYAxisValue(double value) {
    if (value >= 100000) {
      return '${(value / 100000).toStringAsFixed(value % 100000 == 0 ? 0 : 1)}L';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}K';
    }
    return value.toStringAsFixed(0);
  }
}
