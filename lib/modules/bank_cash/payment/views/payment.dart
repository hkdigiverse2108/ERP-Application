import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/bank_cash/payment/controllers/payment_controller.dart';
import 'package:ai_setu/modules/bank_cash/payment/widgets/payment_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PaymentController.instance;

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
              _buildSectionTitle('Payment List', controller),
              PaymentTable(controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, PaymentController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: title,
          onAdd: () => Get.toNamed(
            Routes.addUpdatePayment,
            arguments: {'voucherType': VoucherType.purchase},
          ),
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
