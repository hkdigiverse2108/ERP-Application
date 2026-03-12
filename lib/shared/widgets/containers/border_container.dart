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
  const BorderContainer({
    super.key,
    this.child,
    this.padding,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
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
  }
}
