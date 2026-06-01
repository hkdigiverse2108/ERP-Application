import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/pos_credit_note_model.dart';
import 'package:ai_setu/modules/pos/pos_credit_note/controllers/pos_credit_note_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PosCreditNoteView extends GetView<PosCreditNoteController> {
  const PosCreditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const QuickAction(),
              _buildHeader(context),
              _buildTable(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: FilterSection(
        title: 'POS Credit Notes',
        route: Routes.posCreditNoteList,
        onSearchChanged: controller.onSearch,
        filters: [
          FilterOption(
            label: 'Status',
            filterKey: 'statusFilter',
            options: const {'Available': 'available', 'Used': 'used'},
          ),
          FilterOption(
            label: 'Active',
            filterKey: 'activeFilter',
            options: const {'Active': 'true', 'Inactive': 'false'},
          ),
        ],
        onFiltersChanged: (filters) {
          controller.onStatusChanged(filters['statusFilter']);
          controller.onActiveChanged(filters['activeFilter']);
        },
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.creditNotes.isEmpty) {
          return const TableShimmer();
        }

        if (controller.creditNotes.isEmpty) {
          return BorderContainer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingL),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: context.theme.disabledColor.withValues(alpha: 0.5),
                    ),
                    const Gap(12),
                    Text(
                      "No Credit Notes Found",
                      style: TextHelper.bodyMedium.copyWith(
                        color: context.theme.disabledColor,
                      ),
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
                initialDateRange: controller.selectedDateRange.value,
                onChanged: controller.onDateRangeChanged,
              ),
              const Gap(16),
              CommonTable<PosCreditNoteModel>(
                isLoading: controller.isLoading.value,
                items: controller.creditNotes.toList(),
                columns: [
                  TableColumn(
                    title: 'Credit Note No.',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.creditNoteNo,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Customer',
                    width: 160,
                    cellBuilder: (context, item, index) => Text(
                      "${item.customerId.firstName} ${item.customerId.lastName}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Total',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.totalAmount.toStringAsFixed(2)}",
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Remaining',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      "₹${item.creditsRemaining.toStringAsFixed(2)}",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: item.creditsRemaining > 0
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          item.status,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status.capitalizeFirst!,
                        style: TextHelper.bodySmall.copyWith(
                          color: _getStatusColor(item.status),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd MMM yyyy').format(item.createdAt),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onPageChanged: controller.onPageChanged,
                customActions: [
                  TableAction<PosCreditNoteModel>(
                    icon: Icons.visibility_outlined,
                    tooltip: 'View Details',
                    onTap: (item) {
                      // Handle view details
                    },
                  ),
                  TableAction<PosCreditNoteModel>(
                    icon: Icons.currency_rupee,
                    tooltip: 'Refund',
                    color: Colors.orange,
                    onTap: (item) {
                      // Handle refund
                    },
                  ),
                ],
                onRemoveItem: (item) {
                  // Handle delete
                },
                onRowTap: (item) {},
              ),
            ],
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'used':
        return Colors.blue;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
