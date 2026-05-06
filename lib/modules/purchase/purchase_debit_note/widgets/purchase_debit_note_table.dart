import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/purchase/purchase_debit_note_model.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_controller.dart';
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

  final controller = PurchaseDebitNoteController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        // Accessing isDarkMode to ensure Obx tracks theme changes
        context.isDarkMode;

        if (controller.isLodding.value &&
            controller.purchaseDebitNotes.isEmpty) {
          return const TableShimmer();
        }

        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) => controller.updateDateRange(range),
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<PurchaseDebitNoteModel>(
                isLoading: controller.isLodding.value,
                items: controller.purchaseDebitNotes,
                onRowTap: (item) => Get.toNamed(
                  Routes.purchaseDebitNoteDetails,
                  arguments: item,
                ),
                columns: [
                  TableColumn(
                    title: 'Debit Note No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.debitNoteNo ?? '-',
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Supplier',
                    width: 180,
                    cellBuilder: (context, item, index) => Text(
                      item.supplierId?.companyName.isNotEmpty == true
                          ? item.supplierId!.companyName
                          : (item.supplierId != null
                                ? "${item.supplierId!.firstName} ${item.supplierId!.lastName}"
                                : "N/A"),
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(item.debitNoteDate ?? DateTime.now()),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Amount',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      '₹${(item.summary?.netAmount ?? 0).toStringAsFixed(2)}',
                      style: TextHelper.bodySmall,
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
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (item.status?.isNotEmpty == true)
                            ? item.status!
                            : "Pending",
                        style: TextHelper.bodySmall.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Created By',
                    width: 150,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.createdBy?.fullName ?? '-',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onEditItem: (item) => Get.toNamed(
                  Routes.purchaseDebitNoteAddEdit,
                  arguments: item,
                ),
                onRemoveItem: (item) =>
                    controller.deletePurchaseDebitNote(item.id),
                confirmDelete: true,
                onPageChanged: (page) => controller.goToPage(page),
                pageSize: controller.limit.value,
              ),
            ],
          ),
        );
      }),
    );
  }
}
