import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/settings/payment_terms/controllers/payment_terms_controller.dart';
import 'package:ai_setu/modules/settings/payment_terms/widgets/payment_terms_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentTermsPage extends GetView<PaymentTermsController> {
  const PaymentTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () async => controller.refreshData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                QuickAction(),
                _buildSectionTitle(context),
                const PaymentTermsTable(),
              ],
            ),
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
        title: "Payment Terms",
        searchController: TextEditingController(
          text: controller.searchQuery.value,
        ),
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) => controller.onFiltersChanged(filters),
        onAdd: () => Get.toNamed(Routes.settingsPaymentTermsAddEdit),
        filters: [
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
