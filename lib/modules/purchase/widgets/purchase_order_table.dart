import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/modules/purchase/controllers/purchase_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PurchaseOrderTable extends StatelessWidget {
  PurchaseOrderTable({super.key});

  final purchaseController = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (purchaseController.isLoading.value &&
            purchaseController.purchaseOrderList.isEmpty) {
          return const TableShimmer();
        }

        final items = purchaseController.purchaseOrderList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: purchaseController.selectedDateRange.value,
                onChanged: (range) {
                  purchaseController.selectedDateRange.value = range;
                  purchaseController.currentPage.value = 1;
                  purchaseController.fetchPurchaseOrders();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<PurchaseOrderModel>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Purchase Order No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.orderNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Order Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.orderDate, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Supplier',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.supplier, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.amount}',
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status.isNotEmpty ? item.status : "Pending",
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
                currentPage: purchaseController.currentPage.value,
                totalPages: purchaseController.totalPages.value,
                totalItems: purchaseController.totalItems.value,
                pageSize: 10,
                onPageChanged: (page) {
                  purchaseController.currentPage.value = page;
                  purchaseController.fetchPurchaseOrders();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
