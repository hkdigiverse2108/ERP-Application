import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory_model/product_item_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

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
                items: [
                  ProductItemModel(
                    name: 'Hp Laptop',
                    category: 'Electronics',
                    subCategory: 'Laptops',
                    brand: 'Hp',
                    subBrand: 'Hp',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Hp Laptop',
                    category: 'Electronics',
                    subCategory: 'Laptops',
                    brand: 'Hp',
                    subBrand: 'Hp',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Hp Laptop',
                    category: 'Electronics',
                    subCategory: 'Laptops',
                    brand: 'Hp',
                    subBrand: 'Hp',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Hp Laptop',
                    printName: 'Hp Laptop',
                    category: 'Electronics',
                    subCategory: 'Laptops',
                    brand: 'Hp',
                    subBrand: 'Hp',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Hp Laptop',
                    category: 'Electronics',
                    subCategory: 'Laptops',
                    brand: 'Hp',
                    subBrand: 'Hp',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Hp Laptop',
                    category: 'Electronics',
                    subCategory: 'Laptops',
                    brand: 'Hp',
                    subBrand: 'Hp',
                    qty: 10,
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Product Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? '',
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
                    title: 'Category Name',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.category ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sub Category Name',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.subCategory ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Brand Name',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.brand ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Sub Brand Name',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.subBrand ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
