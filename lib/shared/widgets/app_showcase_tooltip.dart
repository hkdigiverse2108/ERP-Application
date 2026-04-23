import 'package:flutter/material.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';

class AppShowcaseTooltip extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onNext;
  final VoidCallback? onSkip;
  final bool isLastStep;

  const AppShowcaseTooltip({
    super.key,
    required this.title,
    required this.description,
    required this.onNext,
    this.onSkip,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(Sizes.paddingM),
        decoration: BoxDecoration(
          color: isDark
              ? (context.appColors.background).withValues(alpha: 0.95)
              : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.15,
            ),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: context.appColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: (textTheme.titleLarge ?? const TextStyle()).copyWith(
                      color: context.appColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Sizes.paddingS),
            Text(
              description,
              style: (textTheme.bodyMedium ?? const TextStyle()).copyWith(
                color: textColor,
                height: 1.5,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: Sizes.paddingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onSkip != null)
                  TextButton(
                    onPressed: onSkip,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Skip',
                      style: (textTheme.bodySmall ?? const TextStyle())
                          .copyWith(color: secondaryTextColor),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.paddingM,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(isLastStep ? 'Finish' : 'Next'),
                      if (!isLastStep) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, size: 16),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
