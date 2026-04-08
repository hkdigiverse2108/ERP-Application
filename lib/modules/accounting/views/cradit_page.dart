import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/accounting/widgets/cradit_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:flutter/material.dart';

import 'package:ai_setu/modules/accounting/controllers/accounting_controller.dart';
import 'package:get/get.dart';

class CraditPage extends StatefulWidget {
  const CraditPage({super.key});

  @override
  State<CraditPage> createState() => _CraditPageState();
}

class _CraditPageState extends State<CraditPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AccountingController>().fetchCreditNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuickAction(),
            _buildSectionTitle('Credit List'),
            CraditTable(),
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
