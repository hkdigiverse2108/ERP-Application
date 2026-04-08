import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/sales/widgets/delivery_challan_table.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:ai_setu/modules/sales/controllers/sales_controller.dart';
import 'package:get/get.dart';

class DeliveryChallanPage extends StatefulWidget {
  const DeliveryChallanPage({super.key});

  @override
  State<DeliveryChallanPage> createState() => _DeliveryChallanPageState();
}

class _DeliveryChallanPageState extends State<DeliveryChallanPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SalesController>().fetchDeliveryChallans();
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
            _buildSectionTitle('Delivery Challan'),
            DeliveryChallanTable(),
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
