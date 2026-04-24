import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;
  final IconData? icon;

  const SectionButton({
    super.key,
    this.onTap,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        Sizes.borderRadiusM,
      ),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: context.appColors.border),
          borderRadius: BorderRadius.circular(
            Sizes.borderRadiusM,
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon!,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            if (icon != null && label != null)
              const Gap(4),
            if (label != null)
              Text(
                label!,
                style: TextHelper.bodySmallStyle(context),
              ),
          ],
        ),
      ),
    );
  }
}
