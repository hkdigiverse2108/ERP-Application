import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StockTable extends StatelessWidget {
  StockTable({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: homeController.selectedDateRange.value,
                onChanged: (range) =>
                    homeController.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<ProductItemModel>(
                items: [],
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
                    title: 'Category Name',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      item.categoryId?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Brand Name',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      item.brandId?.name ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Available Qty',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.qty.toString(),
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: homeController.currentPage.value,
                totalPages: 1,
                totalItems: 0,
                onPageChanged: (page) =>
                    homeController.currentPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
