import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/pos/order_list/controllers/order_list_controller.dart';
import 'package:ai_setu/modules/pos/order_list/widgets/order_list_table.dart';
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
    final controller = OrderListController.instance;

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
                _buildSectionTitle(controller),
                const OrderListTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(OrderListController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: 'Order List',
        route: Routes.posOrderList,
        filters: [
          FilterOption(
            label: 'Select Status',
            filterKey: 'statusFilter',
            options: {
              for (var e in OrderStatus.values)
                ?e.name.replaceAll('_', ' ').capitalizeFirst: e.name,
            },
          ),
          // FilterOption(
          //   label: 'Branch',
          //   filterKey: 'branchId',
          //   options: {
          //     for (var e in controller.orderList)
          //       e.branchId.name: e.branchId.id,
          //   },
          // ),
          FilterOption(
            label: 'Active Status',
            filterKey: 'activeFilter',
            options: const {'Active': 'true', 'Inactive': 'false'},
          ),
        ],
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
      ),
    );
  }
}
