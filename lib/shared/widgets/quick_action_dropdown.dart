import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickActionDropdown extends StatelessWidget {
  const QuickActionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 675,
        child: Material(
          color: context.responsive(
            light: AppColors.lightSurface,
            dark: AppColors.darkSurface,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.paddingM,
                vertical: Sizes.paddingM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _ExpandableSection(
                    title: "Sales",
                    items: ["Invoice", "Credit Note"],
                  ),
                  _ExpandableSection(
                    title: "Bank / Cash",
                    items: ["Bank", "Bank Transaction", "Receipt", "Payment"],
                  ),
                  _ExpandableSection(
                    title: "Purchase",
                    items: ["Supplier Bill", "Debit Note"],
                  ),
                  _ExpandableSection(title: "Content", items: ["Contact"]),
                  _ExpandableSection(
                    title: "Inventory",
                    items: ["Product", "Stock Transfer", "Price Master"],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandableSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const _ExpandableSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(
          left: Sizes.paddingS,
          bottom: Sizes.paddingS,
        ),
        initiallyExpanded: true,
        iconColor: context.responsive(
          light: AppColors.lightTextSecondary,
          dark: AppColors.darkTextSecondary,
        ),
        collapsedIconColor: context.responsive(
          light: AppColors.lightTextSecondary,
          dark: AppColors.darkTextSecondary,
        ),
        title: Text(
          title,
          style: TextHelper.h4.copyWith(fontWeight: FontWeight.bold),
        ),
        children: items.map((item) => _QuickActionItem(label: item)).toList(),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final String label;

  const _QuickActionItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        // TODO: Handle navigation for each action
      },
      borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.paddingS / 2),
        child: Row(
          children: [
            Icon(
              PhosphorIconsRegular.arrowBendDownRight,
              size: Sizes.iconSizeS,
              color: context.responsive(
                light: AppColors.lightTextSecondary,
                dark: AppColors.darkTextSecondary,
              ),
            ),
            const Gap(Sizes.paddingS),
            Text(
              label,
              style: TextHelper.bodyMedium.copyWith(
                color: context.responsive(
                  light: AppColors.lightTextSecondary,
                  dark: AppColors.darkTextSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
