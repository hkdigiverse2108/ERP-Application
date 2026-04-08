import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/purchase/purchase_debit_note_model.dart';
import 'package:ai_setu/modules/purchase/controllers/purchase_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurchaseDebitNoteTable extends StatelessWidget {
  PurchaseDebitNoteTable({super.key});

  final purchaseController = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (purchaseController.isLoading.value &&
            purchaseController.purchaseDebitNoteList.isEmpty) {
          return const TableShimmer();
        }
        final items = purchaseController.purchaseDebitNoteList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: purchaseController.selectedDateRange.value,
                onChanged: (range) {
                  purchaseController.selectedDateRange.value = range;
                  purchaseController.currentPage.value = 1;
                  purchaseController.fetchPurchaseDebitNotes();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<PurchaseDebitNoteModel>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Debit Note No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.debitNoteNo,
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
                      item.supplierId?.companyName.isNotEmpty == true
                          ? item.supplierId!.companyName
                          : (item.supplierId != null
                                ? "${item.supplierId!.firstName} ${item.supplierId!.lastName}"
                                : "N/A"),
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
                        DateFormat('dd MMM yyyy').format(item.debitNoteDate),
                        style: TextHelper.bodySmall,
                      );
                    },
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
                  TableColumn(
                    title: 'Debit Note Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.debitNoteDate),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Debit Note Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.summary.netAmount.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Tax Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${item.summary.taxAmount.toStringAsFixed(2)}',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Notes',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.notes ?? "",
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: purchaseController.currentPage.value,
                totalPages: purchaseController.totalPages.value,
                totalItems: purchaseController.totalItems.value,
                pageSize: 10,
                onPageChanged: (page) {
                  purchaseController.currentPage.value = page;
                  purchaseController.fetchPurchaseDebitNotes();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
