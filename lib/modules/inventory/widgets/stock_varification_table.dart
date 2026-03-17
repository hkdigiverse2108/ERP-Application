import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory_model/stock_var_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class StockVarificationTable extends StatelessWidget {
  StockVarificationTable({super.key});
  final homeController = Get.put(HomeController());

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
              CommonTable<StockVarModel>(
                items: [
                  StockVarModel(
                    StockVarNo: '1',
                    stockVarDate: '2022-01-01',
                    totalProducts: '10',
                    totalQty: '10',
                    differenceAmount: '10',
                    status: 'Pending',
                    action: 'Action',
                  ),
                  StockVarModel(
                    StockVarNo: '2',
                    stockVarDate: '2022-01-01',
                    totalProducts: '10',
                    totalQty: '10',
                    differenceAmount: '10',
                    status: 'Pending',
                    action: 'Action',
                  ),
                  StockVarModel(
                    StockVarNo: '3',
                    stockVarDate: '2022-01-01',
                    totalProducts: '10',
                    totalQty: '10',
                    differenceAmount: '10',
                    status: 'Pending',
                    action: 'Action',
                  ),
                  StockVarModel(
                    StockVarNo: '4',
                    stockVarDate: '2022-01-01',
                    totalProducts: '10',
                    totalQty: '10',
                    differenceAmount: '10',
                    status: 'Pending',
                    action: 'Action',
                  ),
                  StockVarModel(
                    StockVarNo: '5',
                    stockVarDate: '2022-01-01',
                    totalProducts: '10',
                    totalQty: '10',
                    differenceAmount: '10',
                    status: 'Pending',
                    action: 'Action',
                  ),
                  StockVarModel(
                    StockVarNo: '6',
                    stockVarDate: '2022-01-01',
                    totalProducts: '10',
                    totalQty: '10',
                    differenceAmount: '10',
                    status: 'Pending',
                    action: 'Action',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Stock Vri No',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.StockVarNo,
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
                    title: 'Stock Vri Date',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.stockVarDate,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Total Products',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.totalProducts,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Total Qty',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.totalQty,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Difference Amount',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.differenceAmount}',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.status,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Action',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.action,
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
    );
  }
}
