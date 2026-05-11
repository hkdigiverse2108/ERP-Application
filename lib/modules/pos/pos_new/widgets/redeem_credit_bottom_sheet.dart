import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RedeemCreditBottomSheet extends StatefulWidget {
  const RedeemCreditBottomSheet({super.key});

  @override
  State<RedeemCreditBottomSheet> createState() =>
      _RedeemCreditBottomSheetState();
}

class _RedeemCreditBottomSheetState extends State<RedeemCreditBottomSheet> {
  final controller = PosNewController.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.creditNotes.isEmpty &&
          controller.advancePayments.isEmpty) {
        controller.fetchRedeemables();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              _buildTabBar(context),
              Flexible(
                child: SizedBox(
                  // Set a reasonable minimum height for the TabBarView area
                  height: 300,
                  child: TabBarView(
                    children: [
                      _buildRedeemList(
                        items: controller.creditNotes,
                        type: 'credit_note',
                      ),
                      _buildRedeemList(
                        items: controller.advancePayments,
                        type: 'advance_payment',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Redeem Credit",
            style: TextHelper.h6Style(
              context,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      labelColor: context.appColors.primary,
      unselectedLabelColor: context.appColors.textSecondary,
      indicatorColor: context.appColors.primary,
      tabs: const [
        Tab(text: "Credit Note"),
        Tab(text: "Advance Payment"),
      ],
    );
  }

  Widget _buildRedeemList({
    required RxList<dynamic> items,
    required String type,
  }) {
    return Obx(() {
      if (controller.isRedeemLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (items.isEmpty) {
        return _buildEmptyState(context, type);
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: CommonTable<dynamic>(
          items: items,
          isLoading: controller.isRedeemLoading.value,
          columns: [
            TableColumn(
              title: "Code",
              width: 150,
              cellBuilder: (context, item, index) => Text(
                item['no']?.toString() ?? "-",
                style: TextHelper.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TableColumn(
              title: "Branch",
              width: 150,
              cellBuilder: (context, item, index) => Text(
                item['branchId']?['name']?.toString() ?? "-",
                style: TextHelper.bodySmall,
              ),
            ),
            TableColumn(
              title: "Action",
              width: 100,
              alignment: TextAlign.center,
              cellBuilder: (context, item, index) {
                final itemCode = item['no']?.toString() ?? '';
                final isApplied =
                    controller.appliedRedemption.value?.code == itemCode &&
                    controller.appliedRedemption.value?.type == type;

                if (isApplied) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: context.appColors.success),
                    ),
                    child: Text(
                      "Applied",
                      style: TextStyle(
                        color: context.appColors.success,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ElevatedButton(
                  onPressed: () => controller.applyRedemption(item, type),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(80, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text("Redeem", style: TextStyle(fontSize: 12)),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEmptyState(BuildContext context, String type) {
    final label = type == 'credit_note' ? "Credit Notes" : "Advance Payments";
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsLight.folder,
            size: 48,
            color: context.appColors.textSecondary.withValues(alpha: 0.5),
          ),
          const Gap(12),
          Text(
            "No $label Available",
            style: TextHelper.bodyMedium.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
