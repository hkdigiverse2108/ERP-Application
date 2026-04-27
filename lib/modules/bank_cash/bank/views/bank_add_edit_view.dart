import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/bank_cash/bank/controllers/bank_add_edit_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BankAddEditView extends GetView<BankAddEditController> {
  const BankAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickAction(),
                const Gap(Sizes.paddingS),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.paddingM,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.appColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusL,
                          ),
                        ),
                        child: Icon(
                          controller.isEdit.value
                              ? PhosphorIconsLight.pencilSimple
                              : PhosphorIconsLight.bank,
                          color: context.appColors.primary,
                          size: 28,
                        ),
                      ),
                      const Gap(Sizes.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.isEdit.value ? "Edit Bank" : "Add Bank",
                              style: TextHelper.h5Style(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.appColors.textPrimary,
                              ),
                            ),
                            Text(
                              "Configure bank details and account information",
                              style: TextHelper.captionStyle(context).copyWith(
                                color: context.appColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Sizes.paddingS),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // --- BANK INFORMATION ---
                      EditSection(
                        title: "Bank Information",
                        icon: PhosphorIconsLight.info,
                        child: Column(
                          children: [
                            EditTextField(
                              label: "Bank Name",
                              controller: controller.nameController,
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Account Holder Name",
                              controller: controller.accountHolderController,
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "Account Number",
                                    controller:
                                        controller.accountNumberController,
                                    validator: (v) =>
                                        v!.isEmpty ? "Required" : null,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "IFSC Code",
                                    controller: controller.ifscController,
                                    validator: (v) =>
                                        v!.isEmpty ? "Required" : null,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "Swift Code",
                                    controller: controller.swiftCodeController,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "UPI ID",
                                    controller: controller.upiIdController,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Branch Name",
                              controller: controller.branchNameController,
                            ),
                          ],
                        ),
                      ),

                      // --- OPENING BALANCE ---
                      EditSection(
                        title: "Opening Balance",
                        icon: PhosphorIconsLight.currencyCircleDollar,
                        child: Row(
                          children: [
                            Expanded(
                              child: EditTextField(
                                label: "Credit Balance",
                                controller: controller.creditBalanceController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const Gap(Sizes.paddingM),
                            Expanded(
                              child: EditTextField(
                                label: "Debit Balance",
                                controller: controller.debitBalanceController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- ADDRESS DETAILS ---
                      EditSection(
                        title: "Address Details",
                        icon: PhosphorIconsLight.mapPin,
                        child: Column(
                          children: [
                            EditTextField(
                              label: "Address Line 1",
                              controller: controller.addressLine1Controller,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Address Line 2",
                              controller: controller.addressLine2Controller,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Obx(
                              () => CustomDropdown(
                                label: "Country",
                                items: controller.countryList
                                    .map((e) => e.name)
                                    .toList(),
                                value: controller.selectedCountry.value.isEmpty
                                    ? null
                                    : controller.selectedCountry.value,
                                onChanged: (val) =>
                                    controller.onCountryChanged(val),
                                searchable: true,
                              ),
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Obx(
                              () => CustomDropdown(
                                label: "State",
                                items: controller.stateList
                                    .map((e) => e.name)
                                    .toList(),
                                value: controller.selectedState.value.isEmpty
                                    ? null
                                    : controller.selectedState.value,
                                onChanged: (val) =>
                                    controller.onStateChanged(val),
                                searchable: true,
                              ),
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Obx(
                              () => CustomDropdown(
                                label: "City",
                                items: controller.cityList
                                    .map((e) => e.name)
                                    .toList(),
                                value: controller.selectedCity.value.isEmpty
                                    ? null
                                    : controller.selectedCity.value,
                                onChanged: (val) =>
                                    controller.onCityChanged(val),
                                searchable: true,
                              ),
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            EditTextField(
                              label: "Zip Code",
                              controller: controller.zipCodeController,
                            ),
                          ],
                        ),
                      ),

                      // --- BRANCH SELECTION ---
                      EditSection(
                        title: "Branches",
                        icon: PhosphorIconsLight.gitFork,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown(
                              label: "Select Branch",
                              items: controller.branches
                                  .map((e) => e.name)
                                  .toList(),
                              onChanged: (val) {
                                final branch = controller.branches.firstWhere(
                                  (e) => e.name == val,
                                );
                                if (!controller.branchIds.any(
                                  (e) => e.id == branch.id,
                                )) {
                                  controller.branchIds.add(branch);
                                }
                              },
                              searchable: true,
                            ),
                            const Gap(Sizes.paddingM),
                            Obx(
                              () => Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: controller.branchIds.map((branch) {
                                  return InputChip(
                                    label: Text(
                                      branch.name,
                                      style: TextHelper.bodySmallStyle(context)
                                          .copyWith(
                                            color: context.appColors.textPrimary,
                                          ),
                                    ),
                                    backgroundColor: context.appColors.primary
                                        .withValues(alpha: 0.1),
                                    onDeleted: () =>
                                        controller.branchIds.remove(branch),
                                    deleteIcon: Icon(
                                      Icons.close,
                                      size: 14,
                                      color: context.appColors.textSecondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide.none,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Gap(Sizes.paddingL),

                      // --- STATUS ---
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingM,
                        ),
                        child: Obx(
                          () => SwitchListTile(
                            title: const Text("Is Active"),
                            value: controller.isActive.value,
                            onChanged: (v) => controller.isActive.value = v,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),

                      const Gap(Sizes.paddingL),

                      // --- SAVE BUTTON ---
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingM,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isSaving.value
                                ? null
                                : () => controller.saveBank(),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.borderRadiusM,
                                ),
                              ),
                            ),
                            child: controller.isSaving.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    controller.isEdit.value
                                        ? "Update Bank"
                                        : "Add Bank",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(Sizes.paddingXL),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
