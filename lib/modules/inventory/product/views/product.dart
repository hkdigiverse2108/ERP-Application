import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/showcase_service.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_controller.dart';
import 'package:ai_setu/modules/inventory/product/widgets/product_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
// ignore: implementation_imports
import 'package:showcaseview/src/showcase/showcase_service.dart' as sp;

class Product extends StatelessWidget {
  Product({super.key});
  final controller = ProductController.instance;

  @override
  Widget build(BuildContext context) {
    return _ProductBody(controller: controller);
  }
}

class _ProductBody extends StatefulWidget {
  final ProductController controller;
  const _ProductBody({required this.controller});

  @override
  State<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<_ProductBody> {
  @override
  void initState() {
    super.initState();

    ShowcaseService.to.resetKeys();

    ShowcaseView.register(
      scope: ShowcaseService.inventoryScope,
      onFinish: () {
        ShowcaseService.to.markTourAsSeen();
        ShowcaseService.to.endProductTour();
      },
      blurValue: 1,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ShowcaseService.to.isNavigatingFromTour.value) {
        ShowcaseView.getNamed(ShowcaseService.inventoryScope).startShowCase([
          ShowcaseService.to.productSearchKey,
          ShowcaseService.to.productFilterKey,
          ShowcaseService.to.dateRangeKey,
          ShowcaseService.to.tableRowKey,
        ]);
      }
    });
  }

  @override
  void dispose() {
    ShowcaseView.getNamed(ShowcaseService.inventoryScope).unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sync the current scope to this page for shared widget tour targeting.
    sp.ShowcaseService.instance.updateCurrentScope(
      ShowcaseService.inventoryScope,
    );

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
          route: Routes.product,
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
                for (var e in widget.controller.category)
                  e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Sub Category',
              filterKey: 'subCategoryFilter',
              options: {
                for (var e in widget.controller.subCategory)
                  e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Brand',
              filterKey: 'brandFilter',
              options: {
                for (var e in widget.controller.brand)
                  e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Sub Brand',
              filterKey: 'subBrandFilter',
              options: {
                for (var e in widget.controller.subBrand)
                  e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Purchase Tax',
              filterKey: 'purchaseTaxFilter',
              options: {
                for (var e in widget.controller.tax) e.name.formatEnum(): e.id,
              },
            ),
            FilterOption(
              label: 'Sales Tax',
              filterKey: 'salesTaxFilter',
              options: {
                for (var e in widget.controller.tax) e.name.formatEnum(): e.id,
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
          onSearchChanged: (query) => widget.controller.onSearch(query),
          onFiltersChanged: (filters) =>
              widget.controller.onFiltersChanged(filters),
        ),
      ),
    );
  }
}
