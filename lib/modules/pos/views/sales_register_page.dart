import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/pos/controllers/pos_controller.dart';
import 'package:ai_setu/modules/pos/widgets/sales_register_table.dart';
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
    final controller = PosController.instance;

    // Set active module after build to avoid setState() during build error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setActiveModule('salesRegister');
    });

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
              _buildSectionTitle(controller),
              SalesRegisterTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(PosController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: Obx(
        () => FilterSection(
          title: 'Sales Register List',
          filters: [
            FilterOption(
              label: 'Select Salesman',
              filterKey: 'salesmanId',
              options: {
                for (var e in controller.salesRegisters)
                  if (e.salesManId != null)
                    e.salesManId!.fullName: e.salesManId!.id,
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
