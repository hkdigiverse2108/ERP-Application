import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportCart extends StatelessWidget {
  const ReportCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vipCustColor = context.appColors.sectionSell;

      final regularCustColor = context.appColors.sectionSellPurchase;

      final riskCustColor = context.appColors.sectionPaid;

      final lostCustColor = context.appColors.sectionProfit;

      return GridView(
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
            value: 0,
            color: vipCustColor,
          ),
          StatCard(
            image: "assets/images/regular.png",
            title: "Regular Customer",
            value: 0,
            color: regularCustColor,
          ),
          StatCard(
            image: "assets/images/risk.png",
            title: "Risk Customer",
            value: 0,
            color: riskCustColor,
          ),
          StatCard(
            image: "assets/images/lost.png",
            title: "Lost Customer",
            value: 0,
            color: lostCustColor,
          ),
        ],
      );
    });
  }
}
