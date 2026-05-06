import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/settings/additional_charge/controllers/additional_charge_controller.dart';
import 'package:ai_setu/modules/settings/additional_charge/widgets/additional_charge_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalChargePage extends GetView<AdditionalChargeController> {
  const AdditionalChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              QuickAction(),
              _buildSectionTitle(context),
              const AdditionalChargeTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: FilterSection(
        title: "Additional Charge",
        onAdd: () => Get.toNamed(
          Routes.settingsAdditionalChargeAddEdit,
          arguments: {'isEdit': false},
        ),
        searchController: TextEditingController(
          text: controller.searchQuery.value,
        ),
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        filters: [
          FilterOption(
            label: "Active Status",
            filterKey: "activeFilter",
            options: {"Active": "true", "Inactive": "false"},
          ),
          // FilterOption(
          //   label: "Charge Type",
          //   filterKey: "typeFilter",
          //   options: {"Purchase": "Purchase", "Sales": "Sales"},
          // ),
        ],
      ),
    );
  }
}
