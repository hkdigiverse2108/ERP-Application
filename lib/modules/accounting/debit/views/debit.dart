import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/modules/accounting/debit/controllers/debit_controller.dart';
import 'package:ai_setu/modules/accounting/debit/widgets/debit_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebitPage extends StatelessWidget {
  const DebitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DebitController.instance;

    final perm = PermissionService.to.getPermissionForRoute(Routes.debit);
    debugPrint("--- Permission for Debit Note ---");
    debugPrint("View: ${perm?.view}");
    debugPrint("Add: ${perm?.add}");
    debugPrint("Edit: ${perm?.edit}");
    debugPrint("Delete: ${perm?.delete}");
    debugPrint("---------------------------------");

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
                _buildSectionTitle('Debit List', controller),
                DebitTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, DebitController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: title,
        route: Routes.debit,
        onAdd: () => Get.toNamed(Routes.addUpdateDebit),
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
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
