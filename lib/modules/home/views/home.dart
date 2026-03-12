import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/charts/app_bar_chart.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Gap(Sizes.defHorizontalSpace),

                      // Section Container
                      Obx(
                        () => GridView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2.0,
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                              ),
                          children: [
                            StatCard(
                              title: "Total Sales",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSell,
                                dark: AppColors.darkSectionSell,
                              ),
                            ),
                            StatCard(
                              title: "Total Invoice",
                              value: 0,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSell,
                                dark: AppColors.darkSectionSell,
                              ),
                            ),
                            StatCard(
                              title: "Sold Qty",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSell,
                                dark: AppColors.darkSectionSell,
                              ),
                            ),
                            StatCard(
                              title: "Total Customer",
                              value: 4,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSell,
                                dark: AppColors.darkSectionSell,
                              ),
                            ),
                            StatCard(
                              title: "To Receive",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSell,
                                dark: AppColors.darkSectionSell,
                              ),
                            ),
                            StatCard(
                              title: "Total Sales Return",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSell,
                                dark: AppColors.darkSectionSell,
                              ),
                            ),

                            StatCard(
                              title: "Total Purchase",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSellPurchase,
                                dark: AppColors.darkSectionSellPurchase,
                              ),
                            ),
                            StatCard(
                              title: "Total Bills",
                              value: 0,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSellPurchase,
                                dark: AppColors.darkSectionSellPurchase,
                              ),
                            ),
                            StatCard(
                              title: "Purchase Qty",
                              value: 0,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSellPurchase,
                                dark: AppColors.darkSectionSellPurchase,
                              ),
                            ),
                            StatCard(
                              title: "Total Suppliers",
                              value: 0,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSellPurchase,
                                dark: AppColors.darkSectionSellPurchase,
                              ),
                            ),
                            StatCard(
                              title: "To Pay",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSellPurchase,
                                dark: AppColors.darkSectionSellPurchase,
                              ),
                            ),
                            StatCard(
                              title: "Total Purchase Return",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionSellPurchase,
                                dark: AppColors.darkSectionSellPurchase,
                              ),
                            ),
                            StatCard(
                              title: "Total Paid",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionPaid,
                                dark: AppColors.darkSectionPaid,
                              ),
                            ),
                            StatCard(
                              title: "Total Expense",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionPaid,
                                dark: AppColors.darkSectionPaid,
                              ),
                            ),
                            StatCard(
                              title: "Total Products",
                              value: 43,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionPaid,
                                dark: AppColors.darkSectionPaid,
                              ),
                            ),
                            StatCard(
                              title: "Stock Qty",
                              value: 56,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionPaid,
                                dark: AppColors.darkSectionPaid,
                              ),
                            ),
                            StatCard(
                              title: "Stock Value",
                              value: 100,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionPaid,
                                dark: AppColors.darkSectionPaid,
                              ),
                            ),
                            StatCard(
                              title: "Cash in Hand",
                              value: 100,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionPaid,
                                dark: AppColors.darkSectionPaid,
                              ),
                            ),
                            StatCard(
                              title: "Gross Profit",
                              value: 100,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionProfit,
                                dark: AppColors.darkSectionProfit,
                              ),
                            ),
                            StatCard(
                              title: "Avg. Profit Margin",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionProfit,
                                dark: AppColors.darkSectionProfit,
                              ),
                            ),
                            StatCard(
                              title: "Avg. Profit margin (%)",
                              value: 0,
                              // tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionProfit,
                                dark: AppColors.darkSectionProfit,
                              ),
                            ),
                            StatCard(
                              title: "Avg. Cart Value",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionProfit,
                                dark: AppColors.darkSectionProfit,
                              ),
                            ),
                            StatCard(
                              title: "Avg. Bills (Nos.)",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionProfit,
                                dark: AppColors.darkSectionProfit,
                              ),
                            ),
                            StatCard(
                              title: "Bank Access",
                              value: 0,
                              tag: "₹",
                              color: context.responsive(
                                light: AppColors.lightSectionProfit,
                                dark: AppColors.darkSectionProfit,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Gap(Sizes.defHorizontalSpace),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.paddingM,
                  left: Sizes.paddingM,
                  right: Sizes.paddingM,
                ),
                child: Obx(
                  () => Text(
                    "Sales and Purchase",
                    style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),

                child: Obx(() {
                  // Explicitly access the observable to register the listener
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        DateSection(),
                        Gap(Sizes.lgHorizontalSpace),
                        AppBarChart(
                          values: [45, 80, 65, 30, 90, 50, 70],
                          labels: [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun',
                          ],
                        ),
                        Gap(Sizes.lgVerticalSpace),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
