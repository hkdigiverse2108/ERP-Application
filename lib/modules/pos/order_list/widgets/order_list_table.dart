import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/order_list_model.dart';
import 'package:ai_setu/modules/pos/order_list/controllers/order_list_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderListTable extends StatelessWidget {
  const OrderListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderListController.instance;

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.orderList.isEmpty) {
          return const TableShimmer();
        }

        final items = controller.orderList;
        if (items.isEmpty && !controller.isLoading.value) {
          return BorderContainer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.list_alt_outlined,
                      size: 64,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    const Gap(12),
                    Text(
                      "No Orders Found",
                      style: TextHelper.bodyMedium.copyWith(color: Colors.grey),
                    ),
                    const Gap(16),
                    TextButton.icon(
                      onPressed: () => controller.getOrderListData(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<OrderListModel>(
                isLoading: controller.isLoading.value,
                items: controller.orderList.toList(),
                columns: [
                  TableColumn(
                    title: 'Invoice No',
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
                    title: 'Date',
                    width: 120,
                    cellBuilder: (context, item, index) {
                      return Text(
                        DateFormat('dd-MM-yyyy').format(item.holdDate ?? DateTime.now()),
                        style: TextHelper.bodySmall,
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 110,
                    cellBuilder: (context, item, index) {
                      return Text(
                        item.payLater.dueDate != null
                            ? DateFormat('dd-MM-yyyy').format(item.payLater.dueDate!)
                            : "N/A",
                        style: TextHelper.bodySmall,
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Customer Name',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      "${item.customerId?.firstName ?? ''} ${item.customerId?.lastName ?? ''}".trim(),
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Total Amount',
                    width: 110,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.totalAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Due Amount',
                    width: 110,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.dueAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(color: Colors.red),
                    ),
                  ),
                  TableColumn(
                    title: 'Payment Mode',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      item.paymentMethod ?? "N/A",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Payment Status',
                    width: 110,
                    cellBuilder: (context, item, index) =>
                        Text(item.paymentStatus, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Credit Applied Amt',
                    width: 110,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.redeemCreditAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Order Type',
                    width: 110,
                    cellBuilder: (context, item, index) =>
                        Text(item.orderType, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Sales Man',
                    width: 110,
                    cellBuilder: (context, item, index) => Text(
                      item.salesManId.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 110,
                    cellBuilder: (context, item, index) =>
                        Text(item.status, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                pageSize: controller.limit.value,
                onPageChanged: (page) => controller.goToPage(page),
              ),
            ],
          ),
        );
      }),
    );
  }
}
