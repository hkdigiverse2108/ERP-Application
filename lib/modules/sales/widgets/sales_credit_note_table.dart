import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/modules/sales/controllers/sales_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesCreditNoteTable extends StatelessWidget {
  SalesCreditNoteTable({super.key});

  final salesController = Get.find<SalesController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (salesController.isLoading.value &&
            salesController.creditNoteList.isEmpty) {
          return const TableShimmer();
        }

        final items = salesController.creditNoteList;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: salesController.selectedDateRange.value,
                onChanged: (range) {
                  salesController.selectedDateRange.value = range;
                  salesController.currentPage.value = 1;
                  salesController.fetchCreditNotes();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<SalesCreditNoteDatum>(
                items: items,
                columns: [
                  TableColumn(
                    title: 'Credit Note No.',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.creditNoteNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Credit Note Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.creditNoteDate),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Due Date',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.dueDate ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Customer Name',
                    width: 180,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.customerId.firstName,
                          style: TextHelper.bodySmall,
                        ),
                        Text(
                          " ${item.customerId.lastName}",
                          style: TextHelper.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  TableColumn(
                    title: 'Net Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.summary.netAmount}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Tax Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.summary.taxAmount}",
                      style: TextHelper.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Credit Used',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.summary.netAmount - item.summary.taxAmount}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Credit Remaining',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.summary.netAmount - item.summary.taxAmount}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.status.toUpperCase(),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy.fullName,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: salesController.currentPage.value,
                totalPages: salesController.totalPages.value,
                totalItems: salesController.totalItems.value,
                pageSize: 10,
                onPageChanged: (page) {
                  salesController.currentPage.value = page;
                  salesController.fetchCreditNotes(page: page);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
