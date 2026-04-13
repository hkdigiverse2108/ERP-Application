import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/bank_cash/expense/controllers/expense_controller.dart';
import 'package:ai_setu/modules/bank_cash/expense/widgets/expense_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ExpenseController.instance;

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
              _buildSectionTitle('Expense List', controller),
              ExpenseTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ExpenseController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: title,
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        filters: [
          FilterOption(
            label: 'Type',
            filterKey: 'typeFilter',
            options: const {'Income': 'income', 'Expense': 'expense'},
          ),
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
