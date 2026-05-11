import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CardPaymentBottomSheet extends StatefulWidget {
  final double totalAmount;
  final Function(String holderName, String transNo, String accountId) onConfirm;

  const CardPaymentBottomSheet({
    super.key,
    required this.totalAmount,
    required this.onConfirm,
  });

  @override
  State<CardPaymentBottomSheet> createState() => _CardPaymentBottomSheetState();
}

class _CardPaymentBottomSheetState extends State<CardPaymentBottomSheet> {
  final holderController = TextEditingController();
  final transController = TextEditingController();
  IdNameModel? selectedAccount;
  final controller = PosNewController.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Sizes.borderRadiusXL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.appColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Icon(PhosphorIconsLight.creditCard, size: 28),
                  const Gap(12),
                  Text("Card Payment", style: TextHelper.h3),
                  const Spacer(),
                  Text(
                    "Total: ₹${widget.totalAmount.toStringAsFixed(2)}",
                    style: TextHelper.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Obx(() {
                    if (controller.isBankLoading.value) {
                      return const LinearProgressIndicator();
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.appColors.border),
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadiusM,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<IdNameModel>(
                          isExpanded: true,
                          value: selectedAccount,
                          hint: const Text("Select Bank Account"),
                          items: controller.bankAccounts.map((account) {
                            return DropdownMenuItem(
                              value: account,
                              child: Text(account.name),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedAccount = val;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                  const Gap(16),
                  EditTextField(
                    controller: holderController,
                    label: "Card Holder Name",
                    hintText: "Enter name",
                    prefixIcon: const Icon(PhosphorIconsLight.user, size: 20),
                  ),
                  const Gap(16),
                  EditTextField(
                    controller: transController,
                    label: "Transaction Number",
                    hintText: "Enter transaction ID",
                    prefixIcon: const Icon(PhosphorIconsLight.hash, size: 20),
                  ),
                ],
              ),
            ),
            const Gap(32),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedAccount == null) {
                          AppSnackbar.error("Please select a bank account");
                          return;
                        }
                        if (holderController.text.isEmpty) {
                          AppSnackbar.error("Please enter card holder name");
                          return;
                        }
                        widget.onConfirm(
                          holderController.text,
                          transController.text,
                          selectedAccount!.id,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      child: const Text("Confirm Payment"),
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
}
