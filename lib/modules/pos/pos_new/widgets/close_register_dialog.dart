import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CloseRegisterDialog extends StatefulWidget {
  final Map<String, dynamic> registerData;

  const CloseRegisterDialog({super.key, required this.registerData});

  @override
  State<CloseRegisterDialog> createState() => _CloseRegisterDialogState();
}

class _CloseRegisterDialogState extends State<CloseRegisterDialog> {
  final controller = PosNewController.instance;

  // Controllers
  final bankTransferController = TextEditingController(text: '0');
  final physicalDrawerController = TextEditingController(text: '0');
  final closingNoteController = TextEditingController();

  IdNameModel? selectedBank;

  // Denominations State
  final List<int> denominationValues = [1, 2, 5, 10, 20, 50, 100, 200, 500];
  final Map<int, int> counts = {};

  @override
  void initState() {
    super.initState();
    // Initialize counts to 0
    for (var val in denominationValues) {
      counts[val] = 0;
    }

    // Attach listeners to trigger recalculations
    bankTransferController.addListener(() {
      setState(() {});
    });
    physicalDrawerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    bankTransferController.dispose();
    physicalDrawerController.dispose();
    closingNoteController.dispose();
    super.dispose();
  }

  // Derived Values
  double get totalDenominationsAmount {
    double total = 0;
    counts.forEach((currency, count) {
      total += currency * count;
    });
    return total;
  }

  double get totalCashInDrawer {
    final summary = widget.registerData['summary'] ?? {};
    return double.tryParse(summary['totalCashInDrawer']?.toString() ?? '0') ??
        0.0;
  }

  double get bankTransferAmount {
    return double.tryParse(bankTransferController.text) ?? 0.0;
  }

  double get totalCashLeftInDrawer {
    double calculated = totalCashInDrawer - bankTransferAmount;
    return calculated < 0 ? 0.0 : calculated;
  }

  double get physicalDrawerCash {
    return double.tryParse(physicalDrawerController.text) ?? 0.0;
  }

  double get discrepancy {
    return physicalDrawerCash - totalCashLeftInDrawer;
  }

  void _applyDenominationsToDrawer() {
    setState(() {
      physicalDrawerController.text = totalDenominationsAmount
          .toInt()
          .toString();
    });
    AppSnackbar.success("Denomination total applied to Physical Drawer Cash!");
  }

  Future<void> _submitCloseRegister() async {
    final registerId = widget.registerData['registerId']?.toString();
    if (registerId == null || registerId.isEmpty) {
      AppSnackbar.error("Invalid Register Session ID.");
      return;
    }

    // Prepare Denominations Payload
    List<Map<String, dynamic>> denominationsPayload = [];
    counts.forEach((currency, count) {
      if (count > 0) {
        denominationsPayload.add({
          "currency": currency,
          "count": count,
          "amount": currency * count,
        });
      }
    });

    final summary = widget.registerData['summary'] ?? {};
    num getSummaryVal(String key) =>
        num.tryParse(summary[key]?.toString() ?? '0') ?? 0;

    final payload = {
      "posCashRegisterId": registerId,
      "status": "closed",
      "cashFlow": totalCashLeftInDrawer.toStringAsFixed(2),
      "totalCashInDrawer":
          num.tryParse(summary['totalCashInDrawer']?.toString() ?? '0') ?? 0,
      "physicalDrawerCash": physicalDrawerCash.toStringAsFixed(2),
      "closingNote": closingNoteController.text.trim(),

      // Summary fields
      "openingCash": getSummaryVal('openingCash'),
      "cashPayment": getSummaryVal('cashPayment'),
      "chequePayment": getSummaryVal('chequePayment'),
      "cardPayment": getSummaryVal('cardPayment'),
      "bankPayment": getSummaryVal('bankPayment'),
      "upiPayment": getSummaryVal('upiPayment'),
      "salesReturn": getSummaryVal('salesReturn'),
      "cashRefund": getSummaryVal('cashRefund'),
      "bankRefund": getSummaryVal('bankRefund'),
      "creditAdvanceRedeemed": getSummaryVal('creditAdvanceRedeemed'),
      "payLater": getSummaryVal('payLater'),
      "expense": getSummaryVal('expense'),
      "purchasePayment": getSummaryVal('purchasePayment'),
      "totalSales": getSummaryVal('totalSales'),
      "numberOfBills": getSummaryVal('numberOfBills'),
      "numberOfItems": getSummaryVal('numberOfItems'),
      "totalDiscount": getSummaryVal('totalDiscount'),
      "taxAmount": getSummaryVal('taxAmount'),

      // Denominations
      "denominations": denominationsPayload,

      // Optional extra fields for bank reconciliation
      "bankAccountId": selectedBank?.id,
      "bankTransferAmount": bankTransferAmount.toInt(),
    };

    final success = await controller.closeActiveRegister(payload);
    if (success) {
      Get.back(); // Close dialog
      Get.offAllNamed(Routes.dashboard); // Redirect straight to Cash Control
      AppSnackbar.success("Register Closed successfully.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = widget.registerData['summary'] ?? {};
    final registerNo = widget.registerData['registerNo'] ?? 'N/A';

    // Parse Dates
    DateTime openTime =
        DateTime.tryParse(widget.registerData['createdAt']?.toString() ?? '') ??
        DateTime.now();
    String openTimeStr = DateFormat('dd/MM/yyyy hh:mm a').format(openTime);
    String currTimeStr = DateFormat(
      'dd/MM/yyyy hh:mm a',
    ).format(DateTime.now());

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: context.appColors.background,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
            border: Border.all(color: context.appColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sticky Header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: context.appColors.border),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(PhosphorIconsFill.cashRegister, size: 24),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Register ($registerNo)",
                            style: TextHelper.h3,
                          ),
                          const Gap(2),
                          Text(
                            "$openTimeStr - $currTimeStr",
                            style: TextHelper.bodySmall.copyWith(
                              color: context.appColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        hoverColor: context.appColors.border.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Section 1: Financial Overview Grid
                      _buildSessionSummarySection(summary),
                      const Gap(24),

                      // Responsive Grid for Denominations & Reconciliation
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 580) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildDenominationSection()),
                                const Gap(24),
                                Expanded(child: _buildReconciliationSection()),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                _buildDenominationSection(),
                                const Gap(24),
                                _buildReconciliationSection(),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Sticky Footer Buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: context.appColors.border),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                    const Gap(12),
                    ElevatedButton.icon(
                      onPressed: _submitCloseRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      icon: const Icon(PhosphorIconsBold.power, size: 18),
                      label: const Text(
                        "CLOSE REGISTER",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Financial Metrics Segment
  Widget _buildSessionSummarySection(Map<String, dynamic> sum) {
    // Helper to format values
    String val(dynamic v) {
      final double valDouble = double.tryParse(v?.toString() ?? '0') ?? 0.0;
      return "₹${valDouble.toStringAsFixed(2)}";
    }

    final gridItems = [
      _SummaryItem(
        "Opening Cash",
        val(sum['openingCash']),
        PhosphorIconsLight.money,
      ),
      _SummaryItem(
        "Cash Receive",
        val(sum['cashPayment']),
        PhosphorIconsLight.handCoins,
      ),
      _SummaryItem(
        "Cheque Payment",
        val(sum['chequePayment']),
        PhosphorIconsLight.signature,
      ),
      _SummaryItem(
        "Card Payment",
        val(sum['cardPayment']),
        PhosphorIconsLight.creditCard,
      ),
      _SummaryItem(
        "Bank Payment",
        val(sum['bankPayment']),
        PhosphorIconsLight.bank,
      ),
      _SummaryItem(
        "UPI Receive",
        val(sum['upiPayment']),
        PhosphorIconsLight.qrCode,
      ),
      _SummaryItem(
        "Sales Return",
        val(sum['salesReturn']),
        PhosphorIconsLight.arrowCounterClockwise,
        isRed: true,
      ),
      _SummaryItem(
        "Cash Refund",
        val(sum['cashRefund']),
        PhosphorIconsLight.coins,
        isRed: true,
      ),
      _SummaryItem(
        "Bank Refund",
        val(sum['bankRefund']),
        PhosphorIconsLight.arrowCircleLeft,
        isRed: true,
      ),
      _SummaryItem(
        "Credit/Advance",
        val(sum['creditAdvanceRedeemed']),
        PhosphorIconsLight.bookmark,
      ),
      _SummaryItem("Pay Later", val(sum['payLater']), PhosphorIconsLight.clock),
      _SummaryItem(
        "Expense",
        val(sum['expense']),
        PhosphorIconsLight.trendDown,
        isRed: true,
      ),
      _SummaryItem(
        "Purchase Payment",
        val(sum['purchasePayment']),
        PhosphorIconsLight.shoppingBag,
        isRed: true,
      ),
      _SummaryItem(
        "Total Sales",
        val(sum['totalSales']),
        PhosphorIconsLight.chartBar,
        isGreen: true,
      ),
    ];

    return Card(
      elevation: 0,
      color: context.appColors.border.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        side: BorderSide(
          color: context.appColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Session Overview", style: TextHelper.h4),
            const Gap(16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemCount: gridItems.length,
              itemBuilder: (context, index) {
                final item = gridItems[index];
                Color valColor = context.appColors.textPrimary;
                if (item.isRed) valColor = Colors.red;
                if (item.isGreen) valColor = Colors.green;

                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.appColors.background,
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                    border: Border.all(
                      color: context.appColors.border.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: context.appColors.textSecondary,
                      ),
                      const Gap(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.label,
                              style: TextHelper.bodySmall.copyWith(
                                color: context.appColors.textSecondary,
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.value,
                              style: TextHelper.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: valColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Denominations Segment
  Widget _buildDenominationSection() {
    return Card(
      elevation: 0,
      color: context.appColors.border.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        side: BorderSide(
          color: context.appColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Denominations", style: TextHelper.h4),
                IconButton(
                  tooltip: "Copy Denominations Total to Physical Drawer",
                  onPressed: totalDenominationsAmount > 0
                      ? _applyDenominationsToDrawer
                      : null,
                  icon: const Icon(PhosphorIconsBold.copy, size: 18),
                  color: context.appColors.primary,
                ),
              ],
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: context.appColors.background,
                border: Border(
                  bottom: BorderSide(color: context.appColors.border),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Currency",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Nos",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Amount",
                        style: TextHelper.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: denominationValues.length,
              itemBuilder: (context, index) {
                final val = denominationValues[index];
                final countController = TextEditingController(
                  text: counts[val] == 0 ? '' : counts[val].toString(),
                );

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: context.appColors.border.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "₹$val",
                          style: TextHelper.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 36,
                          child: TextField(
                            controller: countController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextHelper.bodyMedium,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.borderRadiusS,
                                ),
                                borderSide: BorderSide(
                                  color: context.appColors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.borderRadiusS,
                                ),
                                borderSide: BorderSide(
                                  color: context.appColors.primary,
                                ),
                              ),
                              hintText: "0",
                            ),
                            onChanged: (text) {
                              setState(() {
                                counts[val] = int.tryParse(text) ?? 0;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "₹${(val * (counts[val] ?? 0)).toStringAsFixed(2)}",
                            style: TextHelper.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.appColors.background,
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                border: Border.all(color: context.appColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Denominations",
                    style: TextHelper.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹${totalDenominationsAmount.toStringAsFixed(2)}",
                    style: TextHelper.h4.copyWith(
                      color: context.appColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reconciliation & Notes Segment
  Widget _buildReconciliationSection() {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: context.appColors.border.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            side: BorderSide(
              color: context.appColors.border.withValues(alpha: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reconciliation & Drawer", style: TextHelper.h4),
                const Gap(16),

                // Bank Account selection
                Text(
                  "Bank Account",
                  style: TextHelper.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(6),
                Obx(() {
                  if (controller.isBankLoading.value) {
                    return const LinearProgressIndicator();
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.appColors.background,
                      border: Border.all(color: context.appColors.border),
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<IdNameModel>(
                        isExpanded: true,
                        value: selectedBank,
                        hint: const Text("Select Bank Account"),
                        items: controller.bankAccounts.map((account) {
                          return DropdownMenuItem(
                            value: account,
                            child: Text(account.name),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedBank = val;
                          });
                        },
                      ),
                    ),
                  );
                }),
                const Gap(16),

                // Bank Transfer Input
                EditTextField(
                  controller: bankTransferController,
                  label: "Bank Transfer Amount",
                  hintText: "0.00",
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixIcon: const Icon(PhosphorIconsLight.bank, size: 20),
                ),
                const Gap(16),

                // Read-only Drawer Cash details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Cash Flow in Drawer", style: TextHelper.bodyMedium),
                    Text(
                      "₹${totalCashInDrawer.toStringAsFixed(2)}",
                      style: TextHelper.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expected Cash Left", style: TextHelper.bodyMedium),
                    Text(
                      "₹${totalCashLeftInDrawer.toStringAsFixed(2)}",
                      style: TextHelper.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Physical Drawer Cash Input
                EditTextField(
                  controller: physicalDrawerController,
                  label: "Physical Drawer Cash *",
                  hintText: "Enter physical cash in drawer",
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixIcon: const Icon(PhosphorIconsLight.money, size: 20),
                ),
                const Gap(16),

                // Short / Over Alert
                _buildShortOverAlertCard(),
              ],
            ),
          ),
        ),
        const Gap(16),

        // Closing Notes Card
        Card(
          elevation: 0,
          color: context.appColors.border.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
            side: BorderSide(
              color: context.appColors.border.withValues(alpha: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Closing Notes", style: TextHelper.h4),
                const Gap(12),
                EditTextField(
                  controller: closingNoteController,
                  label: "Note",
                  hintText: "Write closing comments/remarks here...",
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShortOverAlertCard() {
    final diff = discrepancy;
    Color cardColor;
    Color textColor;
    String statusText;
    IconData icon;

    if (diff == 0) {
      cardColor = Colors.green.withValues(alpha: 0.1);
      textColor = Colors.green;
      statusText = "Drawer Balanced";
      icon = PhosphorIconsFill.checkCircle;
    } else if (diff > 0) {
      cardColor = Colors.green.withValues(alpha: 0.1);
      textColor = Colors.green;
      statusText = "Over by ₹${diff.toStringAsFixed(2)}";
      icon = PhosphorIconsFill.arrowCircleUp;
    } else {
      cardColor = Colors.red.withValues(alpha: 0.1);
      textColor = Colors.red;
      statusText = "Short by ₹${diff.abs().toStringAsFixed(2)}";
      icon = PhosphorIconsFill.warningCircle;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        border: Border.all(color: textColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 24),
          const Gap(12),
          Expanded(
            child: Text(
              statusText,
              style: TextHelper.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem {
  final String label;
  final String value;
  final IconData icon;
  final bool isRed;
  final bool isGreen;

  _SummaryItem(
    this.label,
    this.value,
    this.icon, {
    this.isRed = false,
    this.isGreen = false,
  });
}
