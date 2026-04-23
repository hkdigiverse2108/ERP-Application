import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/services/showcase_service.dart';
import 'package:ai_setu/data/model/year_model.dart';
import 'package:ai_setu/shared/widgets/app_showcase_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

class FinancialYearDropdown extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const FinancialYearDropdown({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    // We use GetX for reactivity
    final controller = FinancialYearController.to;

    return Obx(() {
      final selectedYear =
          controller.selectedYear.value?.financialYear ?? "Select Year";
      final availableYears = controller.availableYears;

      return Showcase.withWidget(
        key: ShowcaseService.to.yearSelectionKey,
        container: AppShowcaseTooltip(
          title: Strings.showcaseYearTitle,
          description: Strings.showcaseYearDesc,
          onNext: () => ShowcaseView.getNamed(ShowcaseService.homeScope).next(),
          onSkip: () =>
              ShowcaseView.getNamed(ShowcaseService.homeScope).dismiss(),
        ),
        targetShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
        ),
        targetPadding: const EdgeInsets.all(4),
        child: PopupMenuButton<YearModel>(
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (YearModel value) {
            controller.selectYear(value);
            if (onChanged != null) {
              onChanged!(value.financialYear);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: false,
              child: Text(
                "Select Financial Year",
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.appColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const PopupMenuDivider(),
            if (availableYears.isEmpty)
              const PopupMenuItem(
                enabled: false,
                child: Text("No years available"),
              ),
            ...availableYears.map((e) => _buildPopupItem(e)),
          ],
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.paddingS,
              vertical: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  PhosphorIconsFill.calendar,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: Sizes.paddingS),
                Flexible(
                  child: Text(
                    selectedYear,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.textSizeM,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: Sizes.paddingS / 2),
                const Icon(
                  PhosphorIconsFill.caretDown,
                  size: 14,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  PopupMenuItem<YearModel> _buildPopupItem(YearModel year) {
    return PopupMenuItem<YearModel>(
      value: year,
      child: Row(
        children: [
          const Icon(PhosphorIconsLight.calendar, size: 18),
          const SizedBox(width: 10),
          Text(
            year.financialYear,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
