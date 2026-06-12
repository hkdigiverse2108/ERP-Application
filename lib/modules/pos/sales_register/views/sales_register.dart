import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/pos/sales_register/controllers/sales_register_controller.dart';
import 'package:ai_setu/modules/pos/sales_register/widgets/sales_register_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesRegisterPage extends StatelessWidget {
  const SalesRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SalesRegisterController.instance;

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
                const SalesRegisterTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(SalesRegisterController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Sales Register List',
          route: Routes.posSalesRegister,
          filters: [
            FilterOption(
              label: 'Select Salesman',
              filterKey: 'salesManFilter',
              options: {for (var e in controller.users) e.fullName: e.id},
            ),
            FilterOption(
              label: 'Status',
              filterKey: 'statusFilter',
              options: {
                for (var e in SalesRegisterStatus.values)
                  ?e.name.capitalizeFirst: e.name,
              },
            ),
            FilterOption(
              label: 'Active Status',
              filterKey: 'activeFilter',
              options: const {'Active': 'true', 'Inactive': 'false'},
            ),
          ],
          onSearchChanged: (query) => controller.onSearch(query),
          onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        ),
      ),
    );
  }
}
