import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class PurchaseOrderTable extends StatelessWidget {
  PurchaseOrderTable({super.key});
  final homeController = Get.find<HomeController>();

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
              CommonTable<PurchaseOrderModel>(
                items: [
                  PurchaseOrderModel(
                    orderNo: '1',
                    orderDate: '2022-01-01',
                    supplier: 'Supplier 1',
                    status: 'Pending',
                    amount: '100',
                    notes: 'Notes 1',
                    action: 'Action 1',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Order No',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.orderNo,
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
                    title: 'Supplier',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.supplier,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Order Date',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.orderDate,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.amount,
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
                    title: 'Notes',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.notes,
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Action',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.action,
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
