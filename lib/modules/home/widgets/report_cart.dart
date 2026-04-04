import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportCart extends StatelessWidget {
  const ReportCart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final vipCustColor = context.appColors.sectionSell;

    final regularCustColor = context.appColors.sectionSellPurchase;

    final riskCustColor = context.appColors.sectionPaid;

    final lostCustColor = context.appColors.sectionProfit;

    return Obx(
      () => GridView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.1,
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        children: [
          StatCard(
            image: "assets/images/vip.png",
            title: "VIP Customer",
            value: controller.categoryWiseCustomersCount.isNotEmpty
                ? controller.categoryWiseCustomersCount[0].count.toDouble()
                : 0,
            color: vipCustColor,
          ),
          StatCard(
            image: "assets/images/regular.png",
            title: "Regular Customer",
            value: controller.categoryWiseCustomersCount.isNotEmpty
                ? controller.categoryWiseCustomersCount[1].count.toDouble()
                : 0,
            color: regularCustColor,
          ),
          StatCard(
            image: "assets/images/risk.png",
            title: "Risk Customer",
            value: controller.categoryWiseCustomersCount.isNotEmpty
                ? controller.categoryWiseCustomersCount[2].count.toDouble()
                : 0,
            color: riskCustColor,
          ),
          StatCard(
            image: "assets/images/lost.png",
            title: "Lost Customer",
            value: controller.categoryWiseCustomersCount.isNotEmpty
                ? controller.categoryWiseCustomersCount[3].count.toDouble()
                : 0,
            color: lostCustColor,
          ),
        ],
      ),
    );
  }
}
