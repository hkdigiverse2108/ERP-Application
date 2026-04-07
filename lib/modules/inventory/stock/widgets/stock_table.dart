import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/stock_model.dart';
import 'package:ai_setu/modules/inventory/stock/controllers/stock_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StockTable extends StatelessWidget {
  StockTable({super.key});
  final controller = StockController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.stocks.isEmpty) {
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
              CommonTable<StockItemModel>(
                isLoading: controller.isLoading.value,
                items: controller.stocks,
                columns: [
                  TableColumn(
                    title: 'Product Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.name,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Category',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      item.categoryId?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sub-Category',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      item.subCategoryId?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Brand',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      item.brandId?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sub-Brand',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.subBrandId?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Available Qty',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.availableQty.toString(),
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      textAlign: TextAlign.center,
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
