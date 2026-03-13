import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/category_model.dart';
import 'package:ai_setu/data/model/coupons_model.dart';
import 'package:ai_setu/data/model/customers_model.dart';
import 'package:ai_setu/data/model/expenses_model.dart';
import 'package:ai_setu/data/model/login_log_model.dart';
import 'package:ai_setu/data/model/payable_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/modules/home/widgets/dashboard_stat_widget.dart';
import 'package:ai_setu/modules/home/widgets/report_cart.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/data/model/product_item_model.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/charts/app_bar_chart.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuickAction(),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: BorderContainer(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Gap(10),
                                  Text("Select Location"),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(PhosphorIconsLight.caretDown),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(Sizes.smallSpace),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Gap(10),
                                  Text("Select Channel"),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(PhosphorIconsLight.caretDown),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(Sizes.defHorizontalSpace),
                      Obx(
                        () => RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                      ),
                      Gap(Sizes.defHorizontalSpace),

                      // Section Container
                      DashboardStatWidget(),

                      // Gap(Sizes.defHorizontalSpace),
                    ],
                  ),
                ),
              ),

              _buildSectionTitle('Sales and Purchase'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),

                child: Obx(() {
                  // Explicitly access the observable to register the listener
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.lgHorizontalSpace),
                        AppBarChart(
                          values: [45, 80, 65, 30, 90, 50, 70],
                          labels: [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun',
                          ],
                        ),
                        Gap(Sizes.lgVerticalSpace),
                      ],
                    ),
                  );
                }),
              ),

              _buildSectionTitle('Transaction'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),

                child: Obx(() {
                  // Explicitly access the observable to register the listener
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.lgHorizontalSpace),
                        AppBarChart(
                          values: [15, 60, 65, 45, 62, 20, 40],
                          labels: [
                            '1 Mar',
                            '5 Mar',
                            '10 Mar',
                            '15 Mar',
                            '20 Mar',
                            '25 Mar',
                            '30 Mar',
                          ],
                        ),
                        Gap(Sizes.lgVerticalSpace),
                      ],
                    ),
                  );
                }),
              ),

              _buildSectionTitle('Top Selling Items'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),

                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<ProductItemModel>(
                          items: [
                            ProductItemModel(
                              name: 'Wireless Mouse',
                              sku: 'MS-001',
                              price: 500,
                              quantity: 2,
                              discount: 10,
                              tax: 18,
                            ),
                            ProductItemModel(
                              name: 'Mechanical Keyboard',
                              sku: 'KB-002',
                              price: 2500,
                              quantity: 1,
                              discount: 5,
                              tax: 18,
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Item',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextHelper.bodySmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (item.sku.isNotEmpty)
                                    Text(
                                      item.sku,
                                      style: TextHelper.caption,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                            TableColumn(
                              title: 'Qty',
                              width: 80,
                              alignment: TextAlign.center,
                              cellBuilder: (context, item, index) => Text(
                                '${item.quantity} ${item.unit}',
                                textAlign: TextAlign.center,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Price',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.price.toStringAsFixed(2)}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.subtotal.toStringAsFixed(2)}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Discount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.discount > 0
                                    ? '${item.discount.toStringAsFixed(1)}%'
                                    : '-',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  color: item.discount > 0
                                      ? AppColors.success
                                      : null,
                                ),
                              ),
                            ),
                            TableColumn(
                              title: 'Tax',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.tax > 0
                                    ? '${item.tax.toStringAsFixed(1)}%'
                                    : '-',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Total',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.total.toStringAsFixed(2)}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
              ),

              _buildSectionTitle("Customer Report"),

              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: BorderContainer(child: Column(children: [ReportCart()])),
              ),

              _buildSectionTitle('Category Sales'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<CategoryModel>(
                          items: [
                            CategoryModel(
                              categoryName: 'Electronics',
                              noofBill: '2',
                              salesQty: '500',
                              salesAmount: '2500',
                              profit: '2500',
                              salePer: '2500',
                            ),
                            CategoryModel(
                              categoryName: 'Clothing',
                              noofBill: '17',
                              salesQty: '2500',
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
              ),

              _buildSectionTitle('Best Selling Product'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<CategoryModel>(
                          items: [
                            CategoryModel(
                              categoryName: 'Electronics',
                              noofBill: '2',
                              salesQty: '500',
                              salesAmount: '2500',
                              profit: '2500',
                              salePer: '2500',
                            ),
                            CategoryModel(
                              categoryName: 'Clothing',
                              noofBill: '17',
                              salesQty: '2500',
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
              ),

              _buildSectionTitle('Least Selling Product'),

              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<CategoryModel>(
                          items: [
                            CategoryModel(
                              categoryName: 'Electronics',
                              noofBill: '2',
                              salesQty: '500',
                              salesAmount: '2500',
                              profit: '2500',
                              salePer: '2500',
                            ),
                            CategoryModel(
                              categoryName: 'Clothing',
                              noofBill: '17',
                              salesQty: '2500',
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
              ),

              _buildSectionTitle('Top Expenses'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<ExpensesModel>(
                          items: [
                            ExpensesModel(
                              expensename: 'Electronics',
                              expansescount: '2',
                              expansesamount: '2500',
                            ),
                            ExpensesModel(
                              expensename: 'Clothing',
                              expansescount: '17',
                              expansesamount: '2500',
                            ),
                            ExpensesModel(
                              expensename: 'Books',
                              expansescount: '11',
                              expansesamount: '2500',
                            ),
                            ExpensesModel(
                              expensename: 'Toys',
                              expansescount: '15',
                              expansesamount: '2500',
                            ),
                            ExpensesModel(
                              expensename: 'Furniture',
                              expansescount: '5',
                              expansesamount: '2500',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Expenses Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.expensename,
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
                              title: 'Expenses Count',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.expansescount,
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Expenses Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.expansesamount,
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
              ),
              _buildSectionTitle('Top Coupons'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<CouponsModel>(
                          items: [
                            CouponsModel(
                              couponname: 'Electronics',
                              noOfBills: '2',
                              uniqueCouponsCount: '500',
                              totalAmount: '2500',
                            ),
                            CouponsModel(
                              couponname: 'Clothing',
                              noOfBills: '17',
                              uniqueCouponsCount: '2500',
                              totalAmount: '2500',
                            ),
                            CouponsModel(
                              couponname: 'Books',
                              noOfBills: '11',
                              uniqueCouponsCount: '2500',
                              totalAmount: '2500',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Coupon Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.couponname,
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
                              title: 'No of Bills',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.noOfBills,
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'UsedCount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.uniqueCouponsCount,
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Total Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.totalAmount}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
              ),
              _buildSectionTitle("Today's Receivable"),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<CustomersModel>(
                          items: [
                            CustomersModel(
                              customerName: '0',
                              invoiceNo: '0',
                              noofBill: '0',
                              pendingAmount: '0',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Customer Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.customerName ?? '',
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
                              title: 'Invoice No',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.invoiceNo ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'No of Bills',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.noofBill ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Total Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.totalAmount ?? '0.00'}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
              ),
              _buildSectionTitle("Today's Payable"),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<PayableModel>(
                          items: [
                            PayableModel(
                              vendorName: 'Electronics',
                              noOfBills: '2',
                              pendingAmount: '500',
                            ),
                            PayableModel(
                              vendorName: 'Clothing',
                              noOfBills: '17',
                              pendingAmount: '2500',
                            ),
                            PayableModel(
                              vendorName: 'Books',
                              noOfBills: '11',
                              pendingAmount: '2500',
                            ),
                            PayableModel(
                              vendorName: 'Toys',
                              noOfBills: '15',
                              pendingAmount: '2500',
                            ),
                            PayableModel(
                              vendorName: 'Furniture',
                              noOfBills: '5',
                              pendingAmount: '2500',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Vendor Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.vendorName ?? '',
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
                              title: 'No of Bills',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.noOfBills ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Pending Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.pendingAmount ?? '',
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
              ),
              _buildSectionTitle("To Receive"),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<CustomersModel>(
                          items: [
                            CustomersModel(
                              customerName: 'John Doe',
                              date: '2022-01-01',
                              invoiceNo: '123456',
                              pendingAmount: '2500',
                            ),
                            CustomersModel(
                              customerName: 'John Doe',
                              date: '2022-01-01',
                              invoiceNo: '123456',
                              pendingAmount: '2500',
                            ),
                            CustomersModel(
                              customerName: 'John Doe',
                              date: '2022-01-01',
                              invoiceNo: '123456',
                              pendingAmount: '2500',
                            ),
                            CustomersModel(
                              customerName: 'John Doe',
                              date: '2022-01-01',
                              invoiceNo: '123456',
                              pendingAmount: '2500',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Customer Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.customerName ?? '',
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
                              title: 'Date',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.date ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Invoice No',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.invoiceNo ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Pending Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.pendingAmount}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
              ),

              _buildSectionTitle('To Pay'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<PayableModel>(
                          items: [
                            PayableModel(
                              vendorName: 'Electronics',
                              date: '2022-01-01',
                              noOfBills: '1234567890',
                              pendingAmount: '2500',
                            ),
                            PayableModel(
                              vendorName: 'Clothing',
                              date: '2022-01-01',
                              noOfBills: '1234567890',
                              pendingAmount: '2500',
                            ),
                            PayableModel(
                              vendorName: 'Books',
                              date: '2022-01-01',
                              noOfBills: '1234567890',
                              pendingAmount: '2500',
                            ),
                            PayableModel(
                              vendorName: 'Toys',
                              date: '2022-01-01',
                              noOfBills: '1234567890',
                              pendingAmount: '2500',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'Supplier Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.vendorName ?? '',
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
                              title: 'Date',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.date ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Bill No',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.noOfBills ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Pending Amount',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                '₹${item.pendingAmount}',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
              ),
              _buildSectionTitle('Login Log'),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<LoginLogModel>(
                          items: [
                            LoginLogModel(
                              userName: 'Electronics',
                              date: '2022-01-01',
                              time: '10:00 AM',
                              device: 'Mobile',
                              ipAddress: '[IP_ADDRESS]',
                            ),
                            LoginLogModel(
                              userName: 'Clothing',
                              date: '2022-01-01',
                              time: '10:00 AM',
                              device: 'Mobile',
                              ipAddress: '[IP_ADDRESS]',
                            ),
                          ],
                          columns: [
                            TableColumn(
                              title: 'User Name',
                              width: 140,
                              cellBuilder: (context, item, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.userName ?? '',
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
                              title: 'Date',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.date ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Time',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.time ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall,
                              ),
                            ),
                            TableColumn(
                              title: 'Device',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.device ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TableColumn(
                              title: 'IP Address',
                              width: 100,
                              alignment: TextAlign.right,
                              cellBuilder: (context, item, index) => Text(
                                item.ipAddress ?? '',
                                textAlign: TextAlign.right,
                                style: TextHelper.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: Obx(
        () => Text(
          title,
          style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
