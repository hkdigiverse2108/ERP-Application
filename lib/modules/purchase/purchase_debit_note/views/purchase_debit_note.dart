import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_controller.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/widgets/purchase_debit_note_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseDebitNotePage extends StatelessWidget {
  const PurchaseDebitNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PurchaseDebitNoteController.instance;

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
              _buildSectionTitle('Purchase Debit Note', controller),
              PurchaseDebitNoteTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    PurchaseDebitNoteController controller,
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
          onAdd: () => Get.toNamed(Routes.purchaseDebitNoteAddEdit),
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
              label: 'Status',
              filterKey: 'statusFilter',
              options: const {
                'Open': 'open',
                'Closed': 'close',
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
