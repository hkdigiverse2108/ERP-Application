import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            color: ThemeService().isDarkMode
                ? AppColors.darkShadow
                : AppColors.lightShadow,
          ),
        ],
        color: ThemeService().isDarkMode
            ? AppColors.darkBackground
            : AppColors.lightBackground,
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
            icon: PhosphorIconsBold.magnifyingGlass,
            onPressed: () {},
          ),
          Gap(8),
          _buildRoundedIconButton(
            icon: PhosphorIconsBold.moon,
            onPressed: () {},
          ),
          Gap(8),
          _buildRoundedIconButton(
            icon: null,
            svg: AppIcons.cashCounter,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

Widget _buildRoundedIconButton({
  String? svg,
  IconData? icon,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeService().isDarkMode
              ? AppColors.darkBorder
              : AppColors.lightBorder,
        ),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(Sizes.paddingS),
      child: svg != null
          ? SvgPicture.asset(
              svg,
              colorFilter: ColorFilter.mode(
                ThemeService().isDarkMode
                    ? AppColors.darkIconSecondary
                    : AppColors.lightIconSecondary,
                BlendMode.srcIn,
              ),
            )
          : Icon(
              icon,
              color: ThemeService().isDarkMode
                  ? AppColors.darkIconSecondary
                  : AppColors.lightIconSecondary,
            ),
    ),
  );
}
