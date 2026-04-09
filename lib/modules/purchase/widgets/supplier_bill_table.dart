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
import 'package:intl/intl.dart';

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
        if (items.isEmpty && !purchaseController.isLoading.value) {
          return BorderContainer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                    const Gap(12),
                    Text("No Supplier Bills Found", style: TextHelper.bodyMedium.copyWith(color: Colors.grey)),
                    const Gap(16),
                    TextButton.icon(
                      onPressed: () => purchaseController.fetchSupplierBills(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
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
                        item.paymentStatus.isNotEmpty
                            ? item.paymentStatus
                            : "Pending",
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Bill No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.supplierBillNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Supplier',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.supplierId.companyName.isNotEmpty
                          ? item.supplierId.companyName
                          : "${item.supplierId.firstName} ${item.supplierId.lastName}",
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
                    cellBuilder: (context, item, index) {
                      return Text(
                        DateFormat('dd MMM yyyy').format(item.supplierBillDate),
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Bill Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.summary.netAmount.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Paid Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.paidAmount.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Amount',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.balanceAmount.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Tax Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.summary.taxAmount}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) {
                      return Text(
                        DateFormat(
                          'dd MMM yyyy',
                        ).format(item.dueDate ?? DateTime.now()),
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Notes',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.notes ?? ""),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.createdBy.fullName),
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
