import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/product_item_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductTable extends StatelessWidget {
  ProductTable({super.key});
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
                    name: 'Apple',
                    printName: 'Apple',
                    category: 'Fruits',
                    brand: 'Apple',
                    purchaseTax: '10',
                    saleTax: '10',
                    purchasePrice: '10',
                    mrp: '10',
                    salePrice: '10',
                    saleDiscount: '10',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Apple',
                    printName: 'Apple',
                    category: 'Fruits',
                    brand: 'Apple',
                    purchaseTax: '10',
                    saleTax: '10',
                    purchasePrice: '10',
                    mrp: '10',
                    salePrice: '10',
                    saleDiscount: '10',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Apple',
                    printName: 'Apple',
                    category: 'Fruits',
                    brand: 'Apple',
                    purchaseTax: '10',
                    saleTax: '10',
                    purchasePrice: '10',
                    mrp: '10',
                    salePrice: '10',
                    saleDiscount: '10',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Apple',
                    printName: 'Apple',
                    category: 'Fruits',
                    brand: 'Apple',
                    purchaseTax: '10',
                    saleTax: '10',
                    purchasePrice: '10',
                    mrp: '10',
                    salePrice: '10',
                    saleDiscount: '10',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Apple',
                    printName: 'Apple',
                    category: 'Fruits',
                    brand: 'Apple',
                    purchaseTax: '10',
                    saleTax: '10',
                    purchasePrice: '10',
                    mrp: '10',
                    salePrice: '10',
                    saleDiscount: '10',
                    qty: 10,
                  ),
                  ProductItemModel(
                    name: 'Apple',
                    printName: 'Apple',
                    category: 'Fruits',
                    brand: 'Apple',
                    purchaseTax: '10',
                    saleTax: '10',
                    purchasePrice: '10',
                    mrp: '10',
                    salePrice: '10',
                    saleDiscount: '10',
                    qty: 10,
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Name',
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
                    title: 'Print Name',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.printName ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Category',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.category ?? '',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Brand',
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
                    title: 'Purchase Tax',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.purchaseTax}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Sale Tax',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.saleTax}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Purchase Price',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.purchasePrice}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'MRP',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.mrp}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sale Price',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.salePrice}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Sale Discount',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.saleDiscount}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Qty',
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
