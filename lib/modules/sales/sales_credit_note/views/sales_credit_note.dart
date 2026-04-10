import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/controllers/sales_credit_note_controller.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/widgets/sales_credit_note_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesCreditNotePage extends StatelessWidget {
  const SalesCreditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SalesCreditNoteController.instance;

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
              _buildSectionTitle('Sales Credit Note', controller),
              SalesCreditNoteTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    SalesCreditNoteController controller,
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
              options: const {'Open': 'open', 'Paid': 'paid', 'Due': 'due'},
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
