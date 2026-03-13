import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/shared/widgets/financial_year_dropdown.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.lightAiLogo, height: 30, width: 30),

          const FinancialYearDropdown(),

          Gap(Sizes.defVerticalSpace),
        ],
      ),

      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(AppIcons.menuBar, height: 40, width: 40),
            ),
            Gap(10),
            Icon(PhosphorIconsFill.bell, color: Colors.white, size: 20),
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
