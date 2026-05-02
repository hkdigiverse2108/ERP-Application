import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:ai_setu/modules/contact/widgets/contact_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/modules/contact/controllers/contact_controller.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ContactController.instance;

    return Scaffold(
      appBar: DefAppBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuickAction(),
            _buildSectionTitle(context, "Contact List", controller),
            ContactTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    ContactController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: FilterSection(
        title: title,
        onAdd: () => Get.toNamed(Routes.addUpdateContact),
        searchController: controller.searchController,
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        filters: [
          FilterOption(
            label: "Contact Type",
            filterKey: "typeFilter",
            options: {
              "Customer": "customer",
              "Supplier": "supplier",
              "Transporter": "transporter",
            },
          ),
          FilterOption(
            label: "Active Status",
            filterKey: "activeFilter",
            options: {"Active": "true", "Inactive": "false"},
          ),
        ],
      ),
    );
  }
}
