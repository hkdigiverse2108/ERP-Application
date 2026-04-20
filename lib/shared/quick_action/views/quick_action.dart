import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    // Access isDarkMode via ThemeService to avoid ambiguity with GetX extension
    final bool isDark = ThemeService().isDarkMode;
    const Duration animDuration = Duration(milliseconds: 300);

    return AnimatedContainer(
      duration: animDuration,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            color: isDark ? AppColors.darkShadow : AppColors.lightShadow,
          ),
        ],
        color: context.appColors.background,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Builder(
            builder: (buttonContext) {
              return GestureDetector(
                onTap: () {
                  debugPrint("Quick Action");
                  Scaffold.of(context).openDrawer();
                  // final RenderBox renderBox =
                  //     buttonContext.findRenderObject() as RenderBox;
                  // final offset = renderBox.localToGlobal(Offset.zero);
                  // final size = renderBox.size;

                  // Get.dialog(
                  //   QuickActionDropdown(
                  //     topOffset: offset.dy + size.height + 16,
                  //   ),
                  //   useSafeArea: false,
                  //   barrierColor: Colors.black.withValues(alpha: 0.1),
                  // );
                },
                child: Row(
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: animDuration,
                      style: TextHelper.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appColors.textPrimary,
                      ),
                      child: const Text("Quick Action"),
                    ),
                    const Gap(10),
                    Icon(
                      PhosphorIconsBold.funnelSimple,
                      color: context.appColors.textPrimary,
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(),
          _buildRoundedIconButton(
            context: context,
            icon: PhosphorIconsBold.magnifyingGlass,
            onPressed: () => Get.toNamed(Routes.quickSearch),
          ),
          const Gap(8),
          _buildRoundedIconButton(
            context: context,
            icon: null,
            onPressed: () => ThemeService().switchTheme(),
            child: AnimatedSwitcher(
              duration: animDuration,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isDark ? PhosphorIconsBold.sun : PhosphorIconsBold.moon,
                key: ValueKey(isDark),
                color: context.appColors.textSecondary,
              ),
            ),
          ),
          // const Gap(8),
          // _buildRoundedIconButton(
          //   context: context,
          //   icon: null,
          //   svg: AppIcons.cashCounter,
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}

Widget _buildRoundedIconButton({
  required BuildContext context,
  String? svg,
  IconData? icon,
  Widget? child,
  required VoidCallback onPressed,
}) {
  const Duration animDuration = Duration(milliseconds: 300);
  return GestureDetector(
    onTap: onPressed,
    child: AnimatedContainer(
      duration: animDuration,
      decoration: BoxDecoration(
        border: Border.all(color: context.appColors.border),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(Sizes.paddingS),
      child:
          child ??
          (svg != null
              ? SvgPicture.asset(
                  svg,
                  colorFilter: ColorFilter.mode(
                    context.appColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                )
              : Icon(icon, color: context.appColors.textSecondary)),
    ),
  );
}
