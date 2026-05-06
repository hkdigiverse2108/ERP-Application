
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/settings/prefix/controllers/prefix_controller.dart';
import 'package:ai_setu/modules/settings/prefix/widgets/prefix_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrefixPage extends GetView<PrefixController> {
  const PrefixPage({super.key});

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
              const PrefixTable(),
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
        title: "Prefix",
        searchController: TextEditingController(
          text: controller.searchQuery.value,
        ),
        onSearchChanged: (query) => controller.onSearch(query),
        onFiltersChanged: (filters) {},
        filters: const [],
      ),
    );
  }
}
