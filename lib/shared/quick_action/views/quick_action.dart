import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/showcase_service.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/shared/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ai_setu/shared/widgets/app_showcase_tooltip.dart';
import 'package:showcaseview/showcaseview.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    // Access isDarkMode via ThemeService to avoid ambiguity with GetX extension
    final bool isDark = context.isDarkMode;
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
              return Showcase.withWidget(
                key: ShowcaseService.to.drawerKey,
                container: AppShowcaseTooltip(
                  title: Strings.showcaseDrawerTitle,
                  description: Strings.showcaseDrawerDesc,
                  onNext: () => ShowcaseView.get().next(),
                  onSkip: () => ShowcaseView.get().dismiss(),
                ),
                targetShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                ),
                targetPadding: const EdgeInsets.all(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
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
                ),
              );
            },
          ),
          const Spacer(),
          Showcase.withWidget(
            key: ShowcaseService.to.searchKey,
            container: AppShowcaseTooltip(
              title: Strings.showcaseSearchTitle,
              description: Strings.showcaseSearchDesc,
              onNext: () => ShowcaseView.get().next(),
              onSkip: () => ShowcaseView.get().dismiss(),
            ),
            targetShapeBorder: const CircleBorder(),
            targetPadding: const EdgeInsets.all(6),
            child: _buildRoundedIconButton(
              context: context,
              icon: PhosphorIconsBold.magnifyingGlass,
              onPressed: () => Get.toNamed(Routes.quickSearch),
            ),
          ),
          const Gap(8),
          Showcase.withWidget(
            key: ShowcaseService.to.themeKey,
            container: AppShowcaseTooltip(
              title: Strings.showcaseThemeTitle,
              description: Strings.showcaseThemeDesc,
              onNext: () => ShowcaseView.get().next(),
              onSkip: () => ShowcaseView.get().dismiss(),
            ),
            targetShapeBorder: const CircleBorder(),
            targetPadding: const EdgeInsets.all(6),
            child: _buildRoundedIconButton(
              child: ThemeToggleButton(
                compact: true,
                size: 24,
                darkIconColor: context.appColors.textSecondary,
                lightIconColor: context.appColors.textSecondary,
              ),
              context: context,
            ),
          ),
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
  VoidCallback? onPressed,
  double? padding,
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
      padding: EdgeInsets.all(padding ?? Sizes.paddingS),
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
