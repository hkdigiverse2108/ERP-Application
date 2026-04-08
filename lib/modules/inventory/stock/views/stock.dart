import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/inventory/stock/controllers/stock_controller.dart';
import 'package:ai_setu/modules/inventory/stock/widgets/stock_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Obx(
        () => FilterSection(
          title: 'Stock list',
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
          filters: [
            FilterOption(
              label: 'Category',
              filterKey: 'categoryFilter',
              options: {for (var e in controller.category) e.name: e.id},
            ),
            if (controller.subCategory.isNotEmpty)
              FilterOption(
                label: 'Sub Category',
                filterKey: 'subCategoryFilter',
                options: {for (var e in controller.subCategory) e.name: e.id},
              ),
            FilterOption(
              label: 'Brand',
              filterKey: 'brandFilter',
              options: {for (var e in controller.brand) e.name: e.id},
            ),
            if (controller.subBrand.isNotEmpty)
              FilterOption(
                label: 'Sub Brand',
                filterKey: 'subBrandFilter',
                options: {for (var e in controller.subBrand) e.name: e.id},
              ),
            FilterOption(
              label: 'Stock Status',
              filterKey: 'stockStatus',
              options: const {
                'In stock': 'In stock',
                'Low stock': 'Low stock',
                'Out of stock': 'Out of stock',
              },
            ),
          ],
        ),
      ),
    );
  }
}
