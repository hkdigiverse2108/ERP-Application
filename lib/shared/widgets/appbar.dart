import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DefAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          Image.asset(Images.lightAisetuLogo),
          Gap(10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
              border: Border.all(color: AppColors.lightIconSecondary),
            ),
            child: Padding(
              padding: EdgeInsets.all(Sizes.paddingS),
              child: Text(
                '2025-2026',
                style: TextStyle(
                  color: AppColors.lightIconSecondary,
                  fontSize: Sizes.textSizeXL,
                ),
              ),
            ),
          ),
        ],
      ),

      actions: [
        Row(
          children: [
            SvgPicture.asset(AppIcons.menuBar, height: 40, width: 40),
            Gap(10),
            Icon(PhosphorIconsFill.bell, color: Colors.white),
            Gap(20),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(PhosphorIconsBold.user, color: AppColors.primary),
            ),
            Gap(10),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
