import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditSection extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;
  final Widget? trailing;

  const EditSection({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingS,
      ),
      child: BorderContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION HEADER ---
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (icon != null) ...[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: context.appColors.primary.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icon,
                            size: 15,
                            color: context.appColors.primary,
                          ),
                        ),
                        const Gap(Sizes.paddingS),
                      ],
                      Text(
                        title,
                        style: TextHelper.h4.copyWith(
                          fontWeight: FontWeight.w600,
                          color: icon != null
                              ? context.appColors.primary
                              : null,
                        ),
                      ),
                    ],
                  ),
                  ?trailing,
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),

            // --- SECTION CONTENT ---
            Padding(
              padding: const EdgeInsets.all(Sizes.paddingM),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
