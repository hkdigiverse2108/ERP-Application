import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/popup/year_popup.dart';
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

          PopupMenuButton<int>(
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Center(
                  child: Text(
                    "Financial Year",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(PhosphorIconsLight.calendar, size: 18),
                    SizedBox(width: 10),
                    Text("2024 - 2025"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(PhosphorIconsLight.calendar, size: 18),
                    SizedBox(width: 10),
                    Text("2025 - 2026"),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(Sizes.paddingS),
              child: BorderContainer(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.paddingM,
                  vertical: Sizes.paddingS,
                ),

                child: Text(
                  '2025-2026',
                  style: TextStyle(
                    color: AppColors.lightIconSecondary,
                    fontSize: Sizes.textSizeM,
                  ),
                ),
              ),
            ),
          ),

          Gap(Sizes.defVerticalSpace),
          // BorderContainer(

          // padding: EdgeInsets.symmetric(
          //   horizontal: Sizes.paddingM,
          //   vertical: Sizes.paddingS,
          // ),
          // child: Text(
          //   '2025-2026',
          //   style: TextStyle(
          //     color: AppColors.lightIconSecondary,
          //     fontSize: Sizes.textSizeM,
          //   ),
          // ),
          // ),
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
