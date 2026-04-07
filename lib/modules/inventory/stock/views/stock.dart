import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/inventory/stock/controllers/stock_controller.dart';
import 'package:ai_setu/modules/inventory/stock/widgets/stock_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  Stock({super.key});
  final controller = StockController.instance;

  @override
  Widget build(BuildContext context) {
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
              _buildSectionTitle('Stock List'),
              StockTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: 'Product list',
        filters: [
          FilterOption(
            label: 'Category',
            options: ['Fruits', 'Dairy', 'Beverages'],
          ),
          FilterOption(label: 'Brand', options: ['Amul', 'Nestle', 'Local']),
          FilterOption(
            label: 'Stock',
            options: ['In stock', 'Low stock', 'Out of stock'],
          ),
        ],
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
      ),
    );
  }
}
