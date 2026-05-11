import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/normal_field.dart';
import 'package:ai_setu/shared/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuickAddCustomerSheet extends StatelessWidget {
  final PosNewController controller;

  const QuickAddCustomerSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Determine mode
    final bool isEdit = controller.selectedCustomer.value != null;

    return PopScope(
      canPop: !controller.isCustomerFormDirty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showDiscardDialog(context);
      },
      child: SafeArea(
        top: false,
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEdit ? "Edit Customer" : "Add New Customer",
                          style: TextHelper.h6Style(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.appColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (controller.isCustomerFormDirty) {
                              _showDiscardDialog(context);
                            } else {
                              Get.back();
                            }
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Scrollable Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: NormalField(
                                  labelText: "First Name",
                                  labelFloating: true,
                                  controller: controller.firstNameController,
                                  hintText: "Enter first name",
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: NormalField(
                                  labelText: "Last Name",
                                  labelFloating: true,
                                  controller: controller.lastNameController,
                                  hintText: "Enter last name",
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: NormalField(
                                  labelText: "Code",
                                  labelFloating: true,
                                  controller: controller.countryCodeController,
                                  hintText: "+91",
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: NormalField(
                                  labelText: "Phone Number",
                                  labelFloating: true,
                                  controller: controller.phoneController,
                                  hintText: "Enter number",
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          NormalField(
                            labelText: "Address Line 1",
                            labelFloating: true,
                            controller: controller.addressLine1Controller,
                            hintText: "House No, Street name...",
                          ),
                          const Gap(16),
                          Obx(
                            () => CustomDropdown<LocationDropdown>(
                              label: "Country",
                              items: controller.countries,
                              value: controller.selectedCountry.value,
                              searchable: true,
                              onChanged: (val) {
                                controller.selectedCountry.value = val;
                                controller.fetchStates(val.id);
                              },
                            ),
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => CustomDropdown<LocationDropdown>(
                                    label: "State",
                                    items: controller.states,
                                    value: controller.selectedState.value,
                                    searchable: true,
                                    onChanged: (val) {
                                      controller.selectedState.value = val;
                                      controller.fetchCities(val.id);
                                    },
                                  ),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: Obx(
                                  () => CustomDropdown<LocationDropdown>(
                                    label: "City",
                                    items: controller.cities,
                                    value: controller.selectedCity.value,
                                    searchable: true,
                                    onChanged: (val) {
                                      controller.selectedCity.value = val;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Footer Action - Fixed
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isSavingCustomer.value
                              ? null
                              : () => controller.quickAddCustomer(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff536DFE),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: controller.isSavingCustomer.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  isEdit ? "Update Customer" : "Save Customer",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDiscardDialog(BuildContext context) {
    ConfirmDialog.show(
      title: "Discard Changes",
      message:
          "You have unsaved changes. Are you sure you want to discard them?",
      confirmText: "Discard",
      confirmColor: Colors.red,
      onConfirm: () => Get.back(),
    );
  }
}
