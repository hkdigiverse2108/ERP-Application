import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardStatWidget extends StatelessWidget {
  const DashboardStatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
