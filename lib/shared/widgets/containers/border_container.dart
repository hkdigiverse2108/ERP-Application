import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
// import 'package:ai_setu/core/services/theme_service.dart';
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
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBorder
              : AppColors.lightBorder,
        ),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
      ),
      padding: padding ?? EdgeInsets.all(Sizes.paddingS),
      child: child,
    );
  }
}
