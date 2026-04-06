import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_controller.dart';
import 'package:ai_setu/modules/inventory/product/widgets/product_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  Product({super.key});
  final controller = ProductController.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuickAction(),
              _buildSectionTitle('Product List'),
              ProductTable(),
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
        onSearchChanged: (query) {},
        onFiltersChanged: (filters) {},
        // onSearchChanged: (query) => controller.searchQuery.value = query,
        // onFiltersChanged: (filters) => controller.activeFilters.value = filters,
      ),
    );
  }
}
