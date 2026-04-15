import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/data/model/year_model.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

      return PopupMenuButton<YearModel>(
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (YearModel value) {
          controller.selectYear(value);
          if (onChanged != null) {
            onChanged!(value.financialYear);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            enabled: false,
            child: Center(
              child: Text(
                "Financial Year",
                style: TextStyle(fontWeight: FontWeight.bold),
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
        child: Padding(
          padding: const EdgeInsets.all(Sizes.paddingS),
          child: BorderContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.paddingM,
              vertical: Sizes.paddingS,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedYear,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: Sizes.textSizeM,
                  ),
                ),
                const SizedBox(width: Sizes.paddingS),
                const Icon(
                  PhosphorIconsLight.caretDown,
                  size: 16,
                  color: AppColors.darkTextSecondary,
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
          Text(year.financialYear),
        ],
      ),
    );
  }
}
