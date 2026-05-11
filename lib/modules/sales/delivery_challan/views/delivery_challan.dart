import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/sales/delivery_challan/controllers/delivery_challan_controller.dart';
import 'package:ai_setu/modules/sales/delivery_challan/widgets/delivery_challan_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryChallanPage extends StatelessWidget {
  const DeliveryChallanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DeliveryChallanController.instance;

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
              _buildSectionTitle('Delivery Challan', controller),
              DeliveryChallanTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    DeliveryChallanController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: title,
          route: Routes.deliveryChallan,
          onAdd: () async {
            final result = await Get.toNamed(Routes.deliveryChallanAddEdit);
            if (result == true) controller.refreshData();
          },
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
                'Invoice Created': 'invoice_created',
                'Delivered': 'delivered',
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
