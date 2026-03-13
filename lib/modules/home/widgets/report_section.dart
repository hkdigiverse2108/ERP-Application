import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ReportSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Rx<DateTimeRange?>? initialDateRange;
  final Function(DateTimeRange)? onDateChanged;

  const ReportSection({
    super.key,
    required this.title,
    required this.child,
    this.initialDateRange,
    this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        Padding(
          padding: const EdgeInsets.all(Sizes.paddingM),
          child: Obx(() {
            // Trigger rebuild on theme change or date range change
            ThemeService().isDarkMode;
            final dateRange = initialDateRange?.value;

            return BorderContainer(
              child: Column(
                children: [
                  if (initialDateRange != null && onDateChanged != null) ...[
                    RangedDatePicker(
                      initialDateRange: dateRange,
                      onChanged: (range) {
                        if (onDateChanged != null) {
                          onDateChanged!(range);
                        }
                      },
                    ),
                    const Gap(Sizes.defHorizontalSpace),
                  ],
                  child,
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: Text(
        title,
        style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
