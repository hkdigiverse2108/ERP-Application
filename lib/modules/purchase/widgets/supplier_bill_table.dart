import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart';
import 'package:ai_setu/modules/purchase/controllers/purchase_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SupplierBillTable extends StatelessWidget {
  SupplierBillTable({super.key});

  final purchaseController = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (purchaseController.isLoading.value &&
            purchaseController.supplierBillList.isEmpty) {
          return const TableShimmer();
        }

        final items = purchaseController.supplierBillList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: purchaseController.selectedDateRange.value,
                onChanged: (range) {
                  purchaseController.selectedDateRange.value = range;
                  purchaseController.currentPage.value = 1;
                  purchaseController.fetchSupplierBills();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<SupplierBillModel>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Bill No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.billNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.billDate,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.dueDate.isNotEmpty ? item.dueDate : 'N/A',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Supplier',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.supplier,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.billAmount}',
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status.isNotEmpty ? item.status : "Pending",
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
                currentPage: purchaseController.currentPage.value,
                totalPages: purchaseController.totalPages.value,
                totalItems: purchaseController.totalItems.value,
                pageSize: 10,
                onPageChanged: (page) {
                  purchaseController.currentPage.value = page;
                  purchaseController.fetchSupplierBills();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
