import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/bank_cash/receipt/controllers/receipt_controller.dart';
import 'package:ai_setu/modules/bank_cash/payment/widgets/payment_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ReceiptController.instance;

    return Scaffold(
      appBar: DefAppBar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const QuickAction(),
            _buildSection(controller),
            PaymentTable(controller: controller),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(ReceiptController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingS,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Receipt',
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
          filters: [
            FilterOption(
              label: 'Party',
              filterKey: 'partyFilter',
              options: {
                for (var item in controller.customers) item.name: item.id,
              },
            ),
            FilterOption(
              label: 'Payment Type',
              filterKey: 'paymentTypeFilter',
              options: const {
                'Against Bill': 'against_bill',
                'Advance': 'advance',
                'On Account': 'on_account',
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
