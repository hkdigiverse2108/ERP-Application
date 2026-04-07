import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/controllers/bill_of_live_product_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillLiveProductTable extends StatelessWidget {
  BillLiveProductTable({super.key});
  final controller = BillOfLiveProductController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value &&
            controller.billOfLiveProducts.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) =>
                    controller.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<BillOfLiveProductModel>(
                isLoading: controller.isLoading.value,
                items: controller.billOfLiveProducts,
                columns: [
                  TableColumn(
                    title: 'Bill of Live Product No.',
                    width: 180,
                    cellBuilder: (context, item, index) => Text(
                      item.number,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Bill of Live Product Date',
                    width: 180,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.date),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.isActive ? 'Active' : 'Inactive',
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        color: item.isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
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
