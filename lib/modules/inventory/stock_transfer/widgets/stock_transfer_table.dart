import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/invetory/stock_transfer_model.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StockTransferTable extends StatelessWidget {
  StockTransferTable({super.key});

  final controller = StockTransferController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.transfers.isEmpty) {
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
              CommonTable<StockTransferModel>(
                isLoading: controller.isLoading.value,
                items: controller.transfers,
                columns: [
                  TableColumn(
                    title: 'Transfer No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.transferNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'From Branch',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.requestedByBranchId?.name ?? '-',
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'To Branch',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.requestedToBranchId?.name ?? '-',
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          item.status,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status.capitalizeFirst ?? item.status,
                        style: TextHelper.bodySmall.copyWith(
                          color: _getStatusColor(item.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Type',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.type.capitalizeFirst ?? item.type,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onRowTap: (item) {
                  Get.toNamed(Routes.stockTransferDetails, arguments: item);
                },
                canEdit: (item) {
                  return item.status.toLowerCase() == "pending";
                },
                onEditItem: (item) {
                  Get.toNamed(Routes.addUpdateStockTransfer, arguments: item);
                },
                deleteTitle: 'Delete Stock Transfer',
                deleteMessage: (item) =>
                    'Are you sure you want to delete stock transfer ${item.transferNo}?',
                onPageChanged: (page) => controller.goToPage(page),
                pageSize: controller.limit.value,
              ),
            ],
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
