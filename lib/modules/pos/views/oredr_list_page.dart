import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/pos/controllers/pos_controller.dart';
import 'package:ai_setu/modules/pos/widgets/oredr_list_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PosController.instance;

    // Set active module after build to avoid setState() during build error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setActiveModule('orderList');
    });

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
              OrderListTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(PosController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Order List',
          filters: [
            FilterOption(
              label: 'Select Status',
              filterKey: 'status',
              options: {for (var e in controller.posOrders) e.status: e.status},
            ),
            FilterOption(
              label: 'Branch',
              filterKey: 'branchId',
              options: {
                for (var e in controller.posOrders)
                  e.branchId.name: e.branchId.id,
              },
            ),
          ],
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        ),
      ),
    );
  }
}
