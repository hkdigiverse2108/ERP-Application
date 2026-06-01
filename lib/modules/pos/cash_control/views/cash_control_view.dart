import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/pos/cash_control/controllers/cash_control_controller.dart';
import 'package:ai_setu/modules/pos/cash_control/widgets/cash_control_card.dart';
import 'package:ai_setu/shared/widgets/buttons/common_button.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashControlView extends GetView<CashControlController> {
  const CashControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      appBar: AppBar(
        title: Text("Cash Control", style: TextHelper.h3Style(context)),
        backgroundColor: context.appColors.surface,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(PhosphorIconsLight.caretLeft, color: context.appColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildForm(context),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingL),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
                controller.isRegisterOpen.value
                    ? "Register: ${controller.registerDetails.value?['registerNo'] ?? 'N/A'}"
                    : "Register: Closed",
                style: TextHelper.bodySmallStyle(context),
              )),
          const SizedBox(height: 8),
          Obx(() => Text(
                "Today's opening Cash In Hand : ₹ ${controller.totalOpeningBalance.value.toStringAsFixed(2)}",
                style: TextHelper.bodyBoldStyle(context).copyWith(color: context.appColors.primary),
              )),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: EditTextField(
                  label: "Amount",
                  controller: controller.amountController,
                  isRequired: true,
                  hintText: "0.00",
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: EditTextField(
                  label: "Remark",
                  controller: controller.remarkController,
                  hintText: "Enter remark",
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => CommonButton(
                text: "SAVE",
                isLoading: controller.isSaving.value,
                onPressed: () => controller.addCashControl(),
              )),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.cashControlList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.cashControlList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsLight.wallet,
                  size: 48,
                  color: Colors.grey.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "No cash control entries found",
                style: TextHelper.bodyMediumStyle(context).copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                "Add an opening balance to get started",
                style: TextHelper.captionStyle(context),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.fetchCashControl,
        child: ListView.builder(
          padding: const EdgeInsets.all(Sizes.paddingL),
          itemCount: controller.cashControlList.length,
          itemBuilder: (context, index) {
            return CashControlCard(data: controller.cashControlList[index]);
          },
        ),
      );
    });
  }
}
