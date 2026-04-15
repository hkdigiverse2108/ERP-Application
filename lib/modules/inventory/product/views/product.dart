import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_controller.dart';
import 'package:ai_setu/modules/inventory/product/widgets/product_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Obx(
        () => FilterSection(
          title: title,
          onAdd: () => Get.toNamed(Routes.addUpdateProduct),
          filters: [
            FilterOption(
              label: 'Active Status',
              filterKey: 'activeFilter',
              options: {'Active': 'true', 'Inactive': 'false'},
            ),
            FilterOption(
              label: 'Category',
              filterKey: 'categoryFilter',
              options: {
                for (var e in controller.category) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Sub Category',
              filterKey: 'subCategoryFilter',
              options: {
                for (var e in controller.subCategory) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Brand',
              filterKey: 'brandFilter',
              options: {
                for (var e in controller.brand) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Sub Brand',
              filterKey: 'subBrandFilter',
              options: {
                for (var e in controller.subBrand) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Purchase Tax',
              filterKey: 'purchaseTaxFilter',
              options: {
                for (var e in controller.tax) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Sales Tax',
              filterKey: 'salesTaxFilter',
              options: {
                for (var e in controller.tax) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Product Type',
              filterKey: 'productTypeFilter',
              options: {
                for (var e in ProductType.values) e.name.formatEnum(): e.name,
              },
            ),
          ],
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        ),
      ),
    );
  }
}
