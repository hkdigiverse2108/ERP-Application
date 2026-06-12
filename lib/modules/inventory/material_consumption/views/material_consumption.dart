import 'package:ai_setu/app/app_routes.dart' show Routes;
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/inventory/material_consumption/controllers/material_consumption_controller.dart';
import 'package:ai_setu/modules/inventory/material_consumption/widgets/material_consumption_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialConsumption extends StatelessWidget {
  const MaterialConsumption({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MaterialConsumptionController.instance;

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
                MaterialConsumptionTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(MaterialConsumptionController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Material Consumption',
          onAdd: () {
            Get.toNamed(Routes.addUpdateMaterialConsumption);
          },
          filters: [
            FilterOption(
              label: 'Branch',
              filterKey: 'branchFilter',
              options: {
                for (var e in controller.branches) e.name.formatEnum(): e.id,
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
