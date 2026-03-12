import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatCard extends StatelessWidget {
  final String? image;
  final double value;
  final String title;
  final String? tag;
  final Color? color;
  final bool showDecimal;

  const StatCard({
    this.image,
    super.key,
    required this.value,
    required this.title,
    this.tag,
    this.color,
    this.showDecimal = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor =
        color ??
        context.responsive(
          light: AppColors.lightBackground,
          dark: AppColors.darkBackground,
        );
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null)
              Image.asset(
                image!,
                height: Sizes.iconSizeXXL,
                width: Sizes.iconSizeXXL,
              ),
            if (image != null) Gap(Sizes.smallSpace),
            Text(
              (tag == null)
                  ? (showDecimal
                        ? value.toStringAsFixed(2)
                        : value.toStringAsFixed(0))
                  : "$tag ${showDecimal ? value.toStringAsFixed(2) : value.toStringAsFixed(0)}",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: Sizes.textSizeM,
              ),
            ),
            Gap(Sizes.smallSpace),
            Text(
              title,
              style: TextHelper.bodyMedium.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
