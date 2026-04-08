import 'package:ai_setu/modules/purchase/widgets/purchase_debit_note_table.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:ai_setu/modules/purchase/controllers/purchase_controller.dart';

class PurchaseDebitNotePage extends StatefulWidget {
  const PurchaseDebitNotePage({super.key});

  @override
  State<PurchaseDebitNotePage> createState() => _PurchaseDebitNotePageState();
}

class _PurchaseDebitNotePageState extends State<PurchaseDebitNotePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.put(PurchaseController());
      controller.resetPagination();
      controller.fetchPurchaseDebitNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuickAction(),
            _buildSectionTitle('Purchase Debit Note'),
            PurchaseDebitNoteTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: Text(
        title,
        style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
