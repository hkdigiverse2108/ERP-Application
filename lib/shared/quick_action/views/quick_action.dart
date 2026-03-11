import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              color: context.responsive(AppColors.lightShadow, AppColors.darkShadow),
            ),
          ],
          color: context.responsive(AppColors.lightBackground, AppColors.darkBackground),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Quick Action",
                style: TextHelper.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Icon(PhosphorIconsBold.funnelSimple),
            Spacer(),
            _buildRoundedIconButton(
              context: context,
              icon: PhosphorIconsBold.magnifyingGlass,
              onPressed: () {},
            ),
            Gap(8),
            _buildRoundedIconButton(
              context: context,
              icon: context.responsive(PhosphorIconsBold.moon, PhosphorIconsBold.sun),
              onPressed: () => ThemeService().switchTheme(),
            ),
            Gap(8),
            _buildRoundedIconButton(
              context: context,
              icon: null,
              svg: AppIcons.cashCounter,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRoundedIconButton({
  required BuildContext context,
  String? svg,
  IconData? icon,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.responsive(AppColors.lightBorder, AppColors.darkBorder),
        ),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(Sizes.paddingS),
      child: svg != null
          ? SvgPicture.asset(
              svg,
              colorFilter: ColorFilter.mode(
                context.responsive(AppColors.lightIconSecondary, AppColors.darkIconSecondary),
                BlendMode.srcIn,
              ),
            )
          : Icon(
              icon,
              color: context.responsive(AppColors.lightIconSecondary, AppColors.darkIconSecondary),
            ),
    ),
  );
}
