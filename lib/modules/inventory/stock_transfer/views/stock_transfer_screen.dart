import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_controller.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/widgets/stock_transfer_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTransferScreen extends StatelessWidget {
  const StockTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StockTransferController());

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () async => controller.refreshData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickAction(),
                _buildSectionTitle('Stock Transfer List', controller),
                StockTransferTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, StockTransferController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: title,
        onAdd: () async {
          final result = await Get.toNamed(Routes.addUpdateStockTransfer);
          if (result == true) {
            controller.getStockTransfers();
          }
        },
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        filters: [
          FilterOption(
            label: 'Status',
            filterKey: 'statusFilter',
            options: const {
              'Pending': 'pending',
              'Approved': 'approved',
              'Rejected': 'rejected',
            },
          ),
          FilterOption(
            label: 'Type',
            filterKey: 'typeFilter',
            options: const {'Internal': 'internal', 'External': 'external'},
          ),
          FilterOption(
            label: 'Active Status',
            filterKey: 'activeFilter',
            options: const {'Active': 'true', 'Inactive': 'false'},
          ),
        ],
      ),
    );
  }
}
