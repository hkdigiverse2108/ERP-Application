import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';

class Container extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final Color? color;
  const Container({
    super.key,
    this.child,
    this.padding,
    this.height,
    this.width,
    this.onTap,
    this.onTapDown,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: ThemeService.themeTransitionDuration,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: context.appColors.border),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
      ),
      padding: padding ?? EdgeInsets.all(Sizes.paddingS),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
