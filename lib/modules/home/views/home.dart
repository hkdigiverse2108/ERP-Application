import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          Strings.appName,
          style: TextHelper.h2.copyWith(color: Colors.white),
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
      ),
      body: Column(
        children: [
          QuickAction(),
          Padding(
            padding: EdgeInsets.all(Sizes.paddingM),
            child: BorderContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Gap(10),
                              Text("Select Location"),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(PhosphorIconsLight.caretDown),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(Sizes.smallSpace),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Gap(10),
                              Text("Select Channel"),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(PhosphorIconsLight.caretDown),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(Sizes.defHorizontalSpace),
                  DateSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
