import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PosActionDrawer extends StatelessWidget {
  const PosActionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PosNewController>();

    final List<Map<String, dynamic>> actions = [
      {
        'label': 'Hold Bill',
        'icon': PhosphorIcons.handPalm(PhosphorIconsStyle.bold),
        'onTap': () {
          Get.back();
          Get.toNamed(Routes.posHoldBill);
        },
      },
      {
        'label': 'Payments',
        'icon': PhosphorIconsLight.money,
        'onTap': () {
          Get.back();
          Get.toNamed(Routes.posTransactions);
        },
      },
      {
        'label': 'Redeem Loyalty',
        'icon': PhosphorIconsLight.gift,
        'onTap': () {
          Get.back();
          controller.openLoyaltySheet();
        },
      },
      {
        'label': 'Add Payment',
        'icon': PhosphorIconsLight.creditCard,
        'onTap': () {
          Get.back();
          _showPaymentSelection(context);
        },
      },
      {
        'label': 'Credit Notes',
        'icon': PhosphorIconsLight.fileText,
        'onTap': () {
          Get.back();
          Get.toNamed(Routes.posCreditNoteList);
        },
      },
      {
        'label': 'Orders',
        'icon': PhosphorIconsLight.receipt,
        'onTap': () {
          Get.back();
          Get.toNamed(Routes.posOrderList);
        },
      },
      {
        'label': 'Cash Control',
        'icon': PhosphorIconsLight.wallet,
        'onTap': () {
          Get.back();
          Get.toNamed(Routes.cashControl);
        },
      },
    ];

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: context.appColors.surface,
      child: Column(
        children: [
          AppBar(
            title: const Text('Actions'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: actions.length,
                    itemBuilder: (context, index) {
                      final action = actions[index];
                      // Checkerboard pattern
                      final bool isGray = (index % 2 == 0);

                      return InkWell(
                        onTap: action['onTap'],
                        child: Container(
                          decoration: BoxDecoration(
                            color: isGray
                                ? context.appColors.border.withValues(
                                    alpha: 0.1,
                                  )
                                : context.appColors.surface,
                            border: Border.all(
                              color: context.appColors.border.withValues(
                                alpha: 0.2,
                              ),
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                action['icon'],
                                size: 32,
                                color: context.appColors.textPrimary.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                action['label'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: context.appColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(() {
                    if (controller.selectedCustomer.value != null) {
                      return _buildCustomerDetailsCard(context, controller);
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentSelection(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.appColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                // margin: const EdgeInsets.bottom(20),
                decoration: BoxDecoration(
                  color: context.appColors.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                "Choose Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryItem(
                      context,
                      label: "Sales",
                      icon: PhosphorIconsLight.receipt,
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.addUpdateReceipt,
                          arguments: {'voucherType': VoucherType.sales},
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCategoryItem(
                      context,
                      label: "Expense",
                      icon: PhosphorIconsLight.money,
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.addUpdateExpense);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: context.appColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.appColors.primary.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: context.appColors.primary),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.appColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerDetailsCard(
    BuildContext context,
    PosNewController controller,
  ) {
    return Obx(() {
      if (controller.isCustomerPosLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final data = controller.customerPosDetails.value;
      if (data == null) return const SizedBox.shrink();

      final lastBill = data['lastBill'] as Map<String, dynamic>?;
      final customer = data['customer'] as Map<String, dynamic>?;
      final mostPurchased =
          data['mostPurchasedProduct'] as Map<String, dynamic>?;

      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.appColors.border.withValues(alpha: 0.5),
          ),
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
            Text(
              'Customer Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.appColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _detailRow(
              context,
              'Last Visited:',
              _formatTimeAgo(lastBill?['createdAt']),
            ),
            _detailRow(
              context,
              'Last Bill Amount:',
              '₹${lastBill?['totalAmount'] ?? 0}',
            ),
            _detailRow(
              context,
              'Most Purchased:',
              mostPurchased?['name'] ?? 'N/A',
            ),
            _detailRow(
              context,
              'Payment Mode:',
              lastBill?['paymentMethod'] ?? 'N/A',
            ),
            _detailRow(
              context,
              'Due Payment:',
              '₹${data['totalDueAmount'] ?? 0}',
            ),
            _detailRow(
              context,
              'Total Purchase:',
              '₹${data['totalPurchaseAmount'] ?? 0}',
            ),
            _detailRow(
              context,
              'Loyalty Points:',
              '${customer?['loyaltyPoints'] ?? 0}',
            ),
          ],
        ),
      );
    });
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.appColors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(String? dateStr) {
    if (dateStr == null) return 'Never';
    final date = DateTime.tryParse(dateStr);
    if (date == null) return 'N/A';

    final diff = DateTime.now().difference(date);
    if (diff.inDays > 7) return '${(diff.inDays / 7).floor()} weeks ago';
    if (diff.inDays > 0) return '${diff.inDays} days ago';
    if (diff.inHours > 0) return '${diff.inHours} hours ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes} mins ago';
    return 'Just now';
  }
}
