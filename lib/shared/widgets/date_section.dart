import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/constants/strings.dart';

import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/app_showcase_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

class RangedDatePicker extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final Function(DateTimeRange)? onChanged;
  final GlobalKey? showcaseKey;

  const RangedDatePicker({
    super.key,
    this.initialDateRange,
    this.onChanged,
    this.showcaseKey,
  });

  @override
  State<RangedDatePicker> createState() => _RangedDatePickerState();
}

class _RangedDatePickerState extends State<RangedDatePicker> {
  late Rx<DateTimeRange> _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange =
        (widget.initialDateRange ??
                DateTimeRange(
                  start: DateTime.now().subtract(const Duration(days: 30)),
                  end: DateTime.now(),
                ))
            .obs;
  }

  @override
  void didUpdateWidget(covariant RangedDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDateRange != null &&
        widget.initialDateRange != oldWidget.initialDateRange &&
        widget.initialDateRange != _selectedDateRange.value) {
      _selectedDateRange.value = widget.initialDateRange!;
    }
  }

  void _showPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DatePickerBottomSheet(
        initialRange: _selectedDateRange.value,
        onRangeSelected: (range) {
          _selectedDateRange.value = range;
          if (widget.onChanged != null) {
            widget.onChanged!(range);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = BorderContainer(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _showPickerBottomSheet(context),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Obx(
              () => _dateButton(
                context: context,
                date: DateFormat(
                  'dd-MM-yyyy',
                ).format(_selectedDateRange.value.start),
              ),
            ),
            Container(
              width: 1,
              height: 20,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            Obx(
              () => _dateButton(
                context: context,
                date: DateFormat(
                  'dd-MM-yyyy',
                ).format(_selectedDateRange.value.end),
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.showcaseKey != null) {
      return Showcase.withWidget(
        key: widget.showcaseKey!,
        container: AppShowcaseTooltip(
          title: Strings.showcaseDateTitle,
          description: Strings.showcaseDateDesc,
          onNext: () => ShowcaseView.get().next(),
          onSkip: () => ShowcaseView.get().dismiss(),
        ),
        targetShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        targetPadding: const EdgeInsets.all(4),
        child: content,
      );
    }

    return content;
  }

  Widget _dateButton({required BuildContext context, required String date}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              PhosphorIconsLight.calendarDots,
              size: 20,
              color: context.responsive(
                light: context.appColors.primary,
                dark: AppColors.darkIconSecondary,
              ),
            ),
            const SizedBox(width: 8),
            Text(date, style: TextHelper.bodyBoldStyle(context)),
          ],
        ),
      ),
    );
  }
}

class _DatePickerBottomSheet extends StatelessWidget {
  final DateTimeRange initialRange;
  final Function(DateTimeRange) onRangeSelected;

  const _DatePickerBottomSheet({
    required this.initialRange,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select Date Range", style: TextHelper.h4Style(context)),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPresetOption(
            context,
            "Today",
            _getTodayRange(),
            PhosphorIconsLight.calendar,
          ),
          _buildPresetOption(
            context,
            "Yesterday",
            _getYesterdayRange(),
            PhosphorIconsLight.calendar,
          ),
          _buildPresetOption(
            context,
            "Last 7 Days",
            _getLast7DaysRange(),
            PhosphorIconsLight.calendarCheck,
          ),
          _buildPresetOption(
            context,
            "Last 30 Days",
            _getLast30DaysRange(),
            PhosphorIconsLight.calendarCheck,
          ),
          _buildPresetOption(
            context,
            "This Month",
            _getThisMonthRange(),
            PhosphorIconsLight.calendar,
          ),
          const Divider(height: 32),
          ListTile(
            leading: Icon(PhosphorIconsLight.calendarPlus),
            title: Text(
              "Custom Range",
              style: TextHelper.bodyMediumStyle(context),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              Navigator.pop(context);
              final picked = await showDateRangePicker(
                context: context,
                initialDateRange: initialRange,
                firstDate: DateTime(2020),
                lastDate: DateTime(2101),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: context.appColors.primary,
                        onPrimary: Colors.white,
                        surface: isDark ? AppColors.darkSurface : Colors.white,
                        onSurface: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                onRangeSelected(picked);
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPresetOption(
    BuildContext context,
    String title,
    DateTimeRange range,
    IconData icon,
  ) {
    final isSelected = _isSameRange(range, initialRange);
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? context.appColors.primary
            : Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: TextHelper.bodyMediumStyle(context).copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? context.appColors.primary : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: context.appColors.primary)
          : null,
      onTap: () {
        onRangeSelected(range);
        Navigator.pop(context);
      },
    );
  }

  bool _isSameRange(DateTimeRange r1, DateTimeRange r2) {
    return r1.start.year == r2.start.year &&
        r1.start.month == r2.start.month &&
        r1.start.day == r2.start.day &&
        r1.end.year == r2.end.year &&
        r1.end.month == r2.end.month &&
        r1.end.day == r2.end.day;
  }

  DateTimeRange _getTodayRange() {
    final now = DateTime.now();
    return DateTimeRange(start: now, end: now);
  }

  DateTimeRange _getYesterdayRange() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return DateTimeRange(start: yesterday, end: yesterday);
  }

  DateTimeRange _getLast7DaysRange() {
    final now = DateTime.now();
    return DateTimeRange(
      start: now.subtract(const Duration(days: 6)),
      end: now,
    );
  }

  DateTimeRange _getLast30DaysRange() {
    final now = DateTime.now();
    return DateTimeRange(
      start: now.subtract(const Duration(days: 29)),
      end: now,
    );
  }

  DateTimeRange _getThisMonthRange() {
    final now = DateTime.now();
    return DateTimeRange(start: DateTime(now.year, now.month, 1), end: now);
  }
}
