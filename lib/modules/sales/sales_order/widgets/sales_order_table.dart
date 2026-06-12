import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/modules/sales/sales_order/controllers/sales_order_controller.dart';
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

  final controller = SalesOrderController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        // Accessing isDarkMode to ensure Obx tracks theme changes
        context.isDarkMode;

        if (controller.isLodding.value && controller.salesOrders.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<SalesOrderModel>(
                isLoading: controller.isLodding.value,
                items: controller.salesOrders,
                route: Routes.salesOrder,
                onRowTap: (item) =>
                    Get.toNamed(Routes.salesOrderDetails, arguments: item),
                columns: [
                  TableColumn(
                    title: 'Sales Order No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.salesOrderNo ?? "",
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
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.date ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.dueDate ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Customer Name',
                    width: 180,
                    cellBuilder: (context, item, index) => Text(
                      "${item.customerId?.firstName ?? ""} ${item.customerId?.lastName ?? ""}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.transactionSummary?.grossAmount ?? 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Net Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.transactionSummary?.netAmount ?? 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Tax Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.transactionSummary?.taxAmount ?? 0}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.status ?? "", style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? "",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                canEdit: (item) => item.status?.toLowerCase() == 'pending',
                canDelete: (item) => item.status?.toLowerCase() == 'pending',
                onEditItem: (item) async {
                  final result = await Get.toNamed(
                    Routes.salesOrderAddEdit,
                    arguments: item,
                  );
                  if (result == true) {
                    controller.getSalesOrdersData();
                  }
                },
                onRemoveItem: (item) => controller.deleteSalesOrder(item.id),
                deleteTitle: 'Delete Sales Order',
                deleteMessage: (item) =>
                    'Are you sure you want to delete sales order ${item.salesOrderNo}?',
                onPageChanged: (page) => controller.goToPage(page),
                pageSize: controller.limit.value,
              ),
            ],
          ),
        );
      }),
    );
  }
}
