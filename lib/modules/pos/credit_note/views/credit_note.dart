import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/modules/pos/credit_note/controllers/credit_note_controller.dart';
import 'package:ai_setu/modules/pos/credit_note/widgets/credit_note_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditNotePage extends StatelessWidget {
  const CreditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreditNoteController.instance;

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
              const CreditNoteTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(CreditNoteController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.paddingM,
        right: Sizes.paddingM,
        top: Sizes.paddingM,
      ),
      child: FilterSection(
        title: 'Credit Note List',
        filters: [
          FilterOption(
            label: 'Select Status',
            filterKey: 'statusFilter',
            options: {
              for (var e in CreditNoteStatus.values)
                ?e.name.replaceAll('_', ' ').capitalizeFirst: e.name,
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
    );
  }
}
