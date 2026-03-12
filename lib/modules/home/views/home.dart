import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/home/controllers/home_conteroller.dart';
import 'package:ai_setu/modules/home/widgets/dashboard_stat_widget.dart';
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
                      DateSection(),
                      Gap(Sizes.defHorizontalSpace),

                      // Section Container
                      DashboardStatWidget(),

                      // Gap(Sizes.defHorizontalSpace),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.paddingM,
                  left: Sizes.paddingM,
                  right: Sizes.paddingM,
                ),
                child: Obx(
                  () => Text(
                    "Sales and Purchase",
                    style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),

                child: Obx(() {
                  // Explicitly access the observable to register the listener
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        DateSection(),
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

              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.paddingM,
                  left: Sizes.paddingM,
                  right: Sizes.paddingM,
                ),
                child: Obx(
                  () => Text(
                    "Top Selling Items",
                    style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Sizes.paddingM),

                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        DateSection(),
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

              Gap(Sizes.defHorizontalSpace),

              // ProductItemModel(name: "Aman  ", price: 100, quantity: 1)
            ],
          ),
        ),
      ),
    );
  }
}
