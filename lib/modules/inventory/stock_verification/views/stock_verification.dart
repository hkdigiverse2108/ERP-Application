import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/inventory/stock_verification/controllers/stock_verification_controller.dart';
import 'package:ai_setu/modules/inventory/stock_verification/widgets/stock_verification_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockVerification extends StatelessWidget {
  const StockVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StockVerificationController.instance;

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuickAction(),
              _buildSectionTitle(controller),
              StockVerificationTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(StockVerificationController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Stock Verification List',
          onAdd: () async {
            final result = await Get.toNamed(Routes.addUpdateStockVerification);
            if (result == true) {
              controller.refreshData();
            }
          },
          filters: [
            FilterOption(
              label: 'Branch',
              filterKey: 'branchFilter',
              options: {
                for (var e in controller.branches) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Status',
              filterKey: 'statusFilter',
              options: StockVerificationStatus.values.asMap().map(
                (key, value) => MapEntry(value.name.formatEnum(), value.name),
              ),
            ),
          ],
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        ),
      ),
    );
  }
}
