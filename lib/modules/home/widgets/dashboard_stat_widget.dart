import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          StatCard(
            title: "Total Sales",
            value: controller.topSectionData.value.totalSales,
            tag: "₹",
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Invoice",
            value: controller.topSectionData.value.totalInvoice,
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Sold Qty",
            value: controller.topSectionData.value.soldQty,
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Customer",
            value: controller.topSectionData.value.totalCustomers,
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "To Receive",
            value: controller.topSectionData.value.toReceive,
            tag: "₹",
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Sales Return",
            value: controller.topSectionData.value.totalSalesReturn,
            tag: "₹",
            color: selseColor,
            isLoading: controller.topSectionLoading.value,
          ),

          // Section 2: Purchase
          StatCard(
            title: "Total Purchase",
            value: controller.topSectionData.value.totalPurchase,
            tag: "₹",
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Bills",
            value: controller.topSectionData.value.totalBills,
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Purchase Qty",
            value: controller.topSectionData.value.purchaseQty,
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Suppliers",
            value: controller.topSectionData.value.totalSuppliers,
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "To Pay",
            value: controller.topSectionData.value.toPay,
            tag: "₹",
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Purchase Return",
            value: controller.topSectionData.value.totalPurchaseReturn,
            tag: "₹",
            color: purchaseColor,
            isLoading: controller.topSectionLoading.value,
          ),

          // Section 3: Finance / Stock
          StatCard(
            title: "Total Paid",
            value: controller.topSectionData.value.totalPaid,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Expense",
            value: controller.topSectionData.value.totalExpense,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Total Products",
            value: controller.topSectionData.value.totalProducts,
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Stock Qty",
            value: controller.topSectionData.value.stockQty,
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Stock Value",
            value: controller.topSectionData.value.stockValue,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Cash in Hand",
            value: controller.topSectionData.value.cashInHand,
            tag: "₹",
            color: transectionColor,
            isLoading: controller.topSectionLoading.value,
          ),

          // Section 4: Profit Analysis
          StatCard(
            title: "Gross Profit",
            value: controller.topSectionData.value.grossProfit,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Avg. Profit Margin",
            value: controller.topSectionData.value.avgProfitMarginAmount,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Avg. Profit margin (%)",
            value: controller.topSectionData.value.avgProfitMarginPercent,
            showDecimal: true,
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Avg. Cart Value",
            value: controller.topSectionData.value.avgCartValue,
            tag: "₹",
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
            title: "Avg. Bills (Nos.)",
            value: controller.topSectionData.value.avgBillsCount,
            color: profitColor,
            isLoading: controller.topSectionLoading.value,
          ),
          StatCard(
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
