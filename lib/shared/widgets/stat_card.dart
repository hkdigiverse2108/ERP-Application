import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StatCard extends StatelessWidget {
  final String? image;
  final double value;
  final String title;
  final String? tag;
  final Color? color;
  final bool showDecimal;
  final bool isLoading;

  const StatCard({
    this.image,
    super.key,
    required this.value,
    required this.title,
    this.tag,
    this.color,
    this.showDecimal = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? context.appColors.background;
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
            isLoading
                ? DefaultTextStyle(
                    style: const TextStyle(fontSize: 20.0),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          '...',
                          speed: Duration(milliseconds: 200),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  )
                : Text(
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
