import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/modules/sales/controllers/sales_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesOrderTable extends StatelessWidget {
  SalesOrderTable({super.key});

  final salesController = Get.find<SalesController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (salesController.isLoading.value &&
            salesController.salesOrderList.isEmpty) {
          return const TableShimmer();
        }

        final items = salesController.salesOrderList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: salesController.selectedDateRange.value,
                onChanged: (range) {
                  salesController.selectedDateRange.value = range;
                  salesController.currentPage.value = 1;
                  salesController.fetchSalesOrders();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<SalesOrderDatum>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Sales Order No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.salesOrderNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Sales Order Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.date),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.dueDate),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Customer Name',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Row(
                      children: [
                        Text(
                          item.customerId.firstName,
                          style: TextHelper.bodySmall,
                        ),
                        Text(
                          " ${item.customerId.lastName}",
                          style: TextHelper.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.additionalCharges.isNotEmpty ? item.additionalCharges.first.amount : 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Net Amount',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.additionalCharges.isNotEmpty ? (item.additionalCharges.first.amount + item.additionalCharges.last.amount) : 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Tax Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.additionalCharges.isNotEmpty ? item.additionalCharges.last.amount : 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text("${item.status}", style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: salesController.currentPage.value,
                totalPages: salesController.totalPages.value,
                totalItems: salesController.totalItems.value,
                pageSize: 10,
                onPageChanged: (page) {
                  salesController.currentPage.value = page;
                  salesController.fetchSalesOrders(page: page);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
