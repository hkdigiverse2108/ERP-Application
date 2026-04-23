import 'package:ai_setu/core/services/showcase_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/shared/widgets/stat_card.dart';
import 'package:ai_setu/shared/widgets/app_showcase_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class DashboardStatWidget extends StatelessWidget {
  const DashboardStatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final selseColor = context.appColors.sectionSell;
    final purchaseColor = context.appColors.sectionSellPurchase;
    final transectionColor = context.appColors.sectionPaid;
    final profitColor = context.appColors.sectionProfit;

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
          // Section 1: Sales
          Showcase.withWidget(
            key: ShowcaseService.to.salesKey,
            container: AppShowcaseTooltip(
              title: Strings.showcaseSalesTitle,
              description: Strings.showcaseSalesDesc,
              onNext: () => ShowcaseView.getNamed(ShowcaseService.homeScope).next(),
              onSkip: () => ShowcaseView.getNamed(ShowcaseService.homeScope).dismiss(),
            ),
            targetPadding: const EdgeInsets.all(8),
            child: StatCard(
              key: const ValueKey('total_sales'),
              title: "Total Sales",
              value: controller.topSectionData.value.totalSales,
              tag: "₹",
              color: selseColor,
              isLoading: controller.topSectionLoading.value,
            ),
          ),
          StatCard(
            key: const ValueKey('total_invoice'),
            title: "Total Invoice",
            value: controller.topSectionData.value.totalInvoice.toDouble(),
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('sold_qty'),
            title: "Sold Qty",
            value: controller.topSectionData.value.soldQty,
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('total_customer'),
            title: "Total Customer",
            value: controller.topSectionData.value.totalCustomers.toDouble(),
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('to_receive'),
            title: "To Receive",
            value: controller.topSectionData.value.toReceive,
            tag: "₹",
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('total_sales_return'),
            title: "Total Sales Return",
            value: controller.topSectionData.value.totalSalesReturn,
            tag: "₹",
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),

          // Section 2: Purchase
          Showcase.withWidget(
            key: ShowcaseService.to.purchaseKey,
            container: AppShowcaseTooltip(
              title: Strings.showcasePurchaseTitle,
              description: Strings.showcasePurchaseDesc,
              onNext: () => ShowcaseView.getNamed(ShowcaseService.homeScope).next(),
              onSkip: () => ShowcaseView.getNamed(ShowcaseService.homeScope).dismiss(),
            ),
            targetPadding: const EdgeInsets.all(8),
            child: StatCard(
              key: const ValueKey('total_purchase'),
              title: "Total Purchase",
              value: controller.topSectionData.value.totalPurchase,
              tag: "₹",
              color: purchaseColor,
              isLoading: controller.topSectionLoading.value,
            ),
          ),
          StatCard(
            key: const ValueKey('total_bills'),
            title: "Total Bills",
            value: controller.topSectionData.value.totalBills.toDouble(),
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('purchase_qty'),
            title: "Purchase Qty",
            value: controller.topSectionData.value.purchaseQty,
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('total_suppliers'),
            title: "Total Suppliers",
            value: controller.topSectionData.value.totalSuppliers.toDouble(),
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('to_pay'),
            title: "To Pay",
            value: controller.topSectionData.value.toPay,
            tag: "₹",
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('total_purchase_return'),
            title: "Total Purchase Return",
            value: controller.topSectionData.value.totalPurchaseReturn,
            tag: "₹",
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),

          // Section 3: Finance / Stock
          StatCard(
            key: const ValueKey('total_paid'),
            title: "Total Paid",
            value: controller.topSectionData.value.totalPaid,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('total_expense'),
            title: "Total Expense",
            value: controller.topSectionData.value.totalExpense,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('total_products'),
            title: "Total Products",
            value: controller.topSectionData.value.totalProducts.toDouble(),
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('stock_qty'),
            title: "Stock Qty",
            value: controller.topSectionData.value.stockQty,
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('stock_value'),
            title: "Stock Value",
            value: controller.topSectionData.value.stockValue,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('cash_in_hand'),
            title: "Cash in Hand",
            value: controller.topSectionData.value.cashInHand,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),

          // Section 4: Profit Analysis
          StatCard(
            key: const ValueKey('gross_profit'),
            title: "Gross Profit",
            value: controller.topSectionData.value.grossProfit,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('avg_profit_margin_amount'),
            title: "Avg. Profit Margin",
            value: controller.topSectionData.value.avgProfitMarginAmount,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('avg_profit_margin_percent'),
            title: "Avg. Profit margin (%)",
            value: controller.topSectionData.value.avgProfitMarginPercent,
            showDecimal: true,
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('avg_cart_value'),
            title: "Avg. Cart Value",
            value: controller.topSectionData.value.avgCartValue,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('avg_bills_count'),
            title: "Avg. Bills (Nos.)",
            value: controller.topSectionData.value.avgBillsCount,
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            key: const ValueKey('bank_balance'),
            title: "Bank Balance",
            value: controller.topSectionData.value.bankAccountsBalance,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
        ],
      ),
    );
  }
}
