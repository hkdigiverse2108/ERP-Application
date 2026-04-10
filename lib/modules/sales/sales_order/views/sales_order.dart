import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/sales/sales_order/controllers/sales_order_controller.dart';
import 'package:ai_setu/modules/sales/sales_order/widgets/sales_order_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesOrderPage extends StatelessWidget {
  const SalesOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SalesOrderController.instance;

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
              _buildSectionTitle('Sales Order List', controller),
              SalesOrderTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, SalesOrderController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: title,
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
          filters: [
            FilterOption(
              label: 'Customer',
              filterKey: 'customerFilter',
              options: {
                for (var item in controller.customers) item.name: item.id,
              },
            ),
            FilterOption(
              label: 'Status',
              filterKey: 'statusFilter',
              options: const {
                'Pending': 'pending',
                'Invoice Created': 'invoice_created',
                'Partial Invoice Created': 'partial_invoice_created',
                'Delivery Challan Created': 'delivery_challan_created',
                'Partial Delivery Challan Created':
                    'partial_delivery_challan_created',
                'Partially Cancelled': 'partially_cancelled',
                'Cancelled': 'cancelled',
              },
            ),
            FilterOption(
              label: 'Active Status',
              filterKey: 'activeFilter',
              options: const {'Active': 'true', 'Inactive': 'false'},
            ),
          ],
        ),
      ),
    );
  }
}
