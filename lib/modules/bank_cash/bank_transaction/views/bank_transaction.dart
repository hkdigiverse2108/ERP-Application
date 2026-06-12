import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/bank_cash/bank_transaction/controllers/bank_transaction_controller.dart';
import 'package:ai_setu/modules/bank_cash/bank_transaction/widgets/bank_transaction_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankTransactionPage extends StatelessWidget {
  const BankTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BankTransactionController.instance;

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
                _buildSectionTitle('Bank Transaction', controller),
                BankTransactionTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BankTransactionController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: title,
        route: Routes.bankTransaction,
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        onAdd: () async {
          final res = await Get.toNamed(Routes.addUpdateBankTransaction);
          if (res == true) {
            controller.getTransactionsData();
          }
        },
        filters: [
          FilterOption(
            label: 'Active Status',
            filterKey: 'activeFilter',
            options: const {'Active': 'true', 'Inactive': 'false'},
          ),
        ],
      ),
    );
  }
}
