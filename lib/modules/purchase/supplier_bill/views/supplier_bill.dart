import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/controllers/supplier_bill_controller.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/widgets/supplier_bill_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierBillPage extends StatelessWidget {
  const SupplierBillPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SupplierBillController.instance;

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
              _buildSectionTitle('Supplier Bill', controller),
              SupplierBillTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, SupplierBillController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: title,
          onAdd: () => Get.toNamed(Routes.supplierBillAddEdit),
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
          filters: [
            FilterOption(
              label: 'Supplier',
              filterKey: 'supplierFilter',
              options: {
                for (var item in controller.suppliers) item.name: item.id,
              },
            ),
            FilterOption(
              label: 'Payment Status',
              filterKey: 'paymentStatus',
              options: {
                for (var item in BillStatus.values)
                  item.name.capitalizeFirst!: item.name,
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
