import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Image.asset(AppLogo.lightAiLogo),
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
      ),
    );
  }
}
