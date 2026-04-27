import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/controllers/bill_of_live_product_controller.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/widgets/bill_of_live_product_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillOfLive extends StatelessWidget {
  const BillOfLive({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BillOfLiveProductController.instance;

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
              BillLiveProductTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BillOfLiveProductController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Bill of Live Product List',
          filters: [
            FilterOption(
              filterKey: 'branchFilter',
              label: 'Branch',
              options: {for (var e in controller.branches) e.name: e.id},
            ),
          ],
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
          onAdd: () => Get.toNamed(Routes.addUpdateBillOfLiveProduct),
        ),
      ),
    );
  }
}
