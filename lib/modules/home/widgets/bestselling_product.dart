import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/category_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class BestsellingProduct extends StatelessWidget {
  BestsellingProduct({super.key});
  final HomeController homeController = Get.find<HomeController>();

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
              CommonTable<CategoryModel>(
                items: [
                  CategoryModel(
                    categoryName: 'Electronics',
                    noofBill: '5',
                    salesQty: '25',
                    salesAmount: '2500',
                    profit: '2500',
                    salePer: '2500',
                  ),
                  CategoryModel(
                    categoryName: 'Clothing',
                    noofBill: '17',
                    salesQty: '5',
                    salesAmount: '2500',
                    profit: '2500',
                    salePer: '2500',
                  ),
                  CategoryModel(
                    categoryName: 'Books',
                    noofBill: '11',
                    salesQty: '2500',
                    salesAmount: '2500',
                    profit: '2500',
                    salePer: '2500',
                  ),
                  CategoryModel(
                    categoryName: 'Toys',
                    noofBill: '15',
                    salesQty: '2500',
                    salesAmount: '2500',
                    profit: '2500',
                    salePer: '2500',
                  ),
                  CategoryModel(
                    categoryName: 'Furniture',
                    noofBill: '5',
                    salesQty: '2500',
                    salesAmount: '2500',
                    profit: '2500',
                    salePer: '2500',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Category Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.categoryName,
                          style: TextHelper.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  TableColumn(
                    title: 'No of Bill',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.noofBill,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sales Qty',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.salesQty,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sales Amount',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.salesAmount}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Profit',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.profit}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Sale %',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.salePer,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: homeController.currentPage.value,
                totalPages: 5,
                totalItems: 43,
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
