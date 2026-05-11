import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/services/theme_service.dart';
import '../../../shared/widgets/dialogs/confirm_dialog.dart';
import '../../../shared/widgets/text_fields/search_field.dart';
import 'pos_hold_controller.dart';

class PosHoldView extends GetView<PosHoldController> {
  const PosHoldView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.appColors.background,
        appBar: AppBar(
          title: const Text('Hold Bills'),
          centerTitle: true,
          backgroundColor: context.appColors.surface,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: context.appColors.textPrimary,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppSearchBar(
                hint: "Search by Order No or Customer Name",
                onChanged: (val) {
                  controller.onSearch(val);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.holdOrders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: context.appColors.textSecondary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No hold orders found",
                          style: TextStyle(
                            fontSize: 16,
                            color: context.appColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.holdOrders.length,
                  itemBuilder: (context, index) {
                    final order = controller.holdOrders[index];
                    return _buildOrderCard(context, order);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    final colors = context.appColors;
    final customer = order['customerId'] as Map<String, dynamic>?;
    final customerName = customer != null
        ? "${customer['firstName'] ?? ''} ${customer['lastName'] ?? ''}".trim()
        : 'Unknown Customer';
    final phone = customer?['phoneNo']?['phoneNo']?.toString() ?? 'N/A';
    final date = DateTime.tryParse(order['holdDate'] ?? '');
    final formattedDate = date != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(date)
        : 'N/A';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => controller.onOrderTap(order['_id']),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      order['orderNo'] ?? "N/A",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹${order['totalAmount'] ?? 0}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          PhosphorIconsLight.trash,
                          color: colors.error,
                          size: 22,
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          ConfirmDialog.show(
                            title: "Remove Order",
                            message:
                                "Are you sure you want to remove this hold order?",
                            confirmText: "Remove",
                            confirmColor: colors.error,
                            onConfirm: () =>
                                controller.removeHoldOrder(order['_id']),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: context.appColors.border.withValues(
                      alpha: 0.3,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 20,
                      color: context.appColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customerName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: context.appColors.textPrimary,
                          ),
                        ),
                        Text(
                          phone,
                          style: TextStyle(
                            fontSize: 13,
                            color: context.appColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: context.appColors.textSecondary.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: context.appColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.appColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        size: 14,
                        color: context.appColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['branchId']?['name'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: context.appColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
