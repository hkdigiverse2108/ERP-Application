import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/crm/discount/controllers/discount_controller.dart';
import 'package:ai_setu/modules/crm/discount/widgets/discount_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DiscountController.instance;

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
                _buildSectionTitle(controller),
                const DiscountTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(DiscountController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: 'Discount List',
        route: Routes.discount,
        onAdd: () async {
          final res = await Get.toNamed(Routes.addUpdateDiscount);
          if (res == true) controller.getDiscountData();
        },
        filters: [
          FilterOption(
            label: 'Active Status',
            filterKey: 'activeFilter',
            options: const {'Active': 'true', 'Inactive': 'false'},
          ),
        ],
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
      ),
    );
  }
}
