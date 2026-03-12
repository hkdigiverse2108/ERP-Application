import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  const BorderContainer({
    super.key,
    this.child,
    this.padding,
    this.height,
    this.width,
    this.onTap,
    this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    final container = Obx(
      () => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.responsive(
              light: AppColors.lightBorder,
              dark: AppColors.darkBorder,
            ),
          ),
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        ),
        padding: padding ?? EdgeInsets.all(Sizes.paddingS),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );

    if (onTap != null || onTapDown != null) {
      return GestureDetector(onTap: onTap, onTapDown: onTapDown, child: container);
    }
    return container;
  }
}
