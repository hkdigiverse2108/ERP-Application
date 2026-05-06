import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/controllers/sales_credit_note_add_edit_controller.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/widgets/sales_credit_note_item_card.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/widgets/sales_credit_note_summary_section.dart';
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

class SalesCreditNoteAddEditView
    extends GetView<SalesCreditNoteAddEditController> {
  const SalesCreditNoteAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        bottomNavigationBar: _buildBottomActions(context),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const QuickAction(),
                  const Gap(Sizes.paddingS),
                  _buildHeader(context),
                  const Gap(Sizes.paddingS),
                  _buildCreditNoteInfoSection(context),
                  const Gap(Sizes.paddingM),
                  _buildItemsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildAdditionalChargesSection(context),
                  const Gap(Sizes.paddingM),
                  _buildShippingDetailsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildNotesSection(context),
                  const Gap(Sizes.paddingM),
                  _buildTermsSection(context),
                  const Gap(Sizes.paddingM),
                  SalesCreditNoteSummarySection(controller: controller),
                  const Gap(Sizes.paddingXL),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Obx(
        () => Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
              ),
              child: Icon(
                controller.isEdit.value
                    ? PhosphorIconsLight.pencilSimple
                    : PhosphorIconsLight.receipt,
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
                    controller.isEdit.value
                        ? "Edit Credit Note"
                        : "Add Credit Note",
                    style: TextHelper.h5Style(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.textPrimary,
                    ),
                  ),
                  Text(
                    "Manage your sales credit notes efficiently",
                    style: TextHelper.captionStyle(
                      context,
                    ).copyWith(color: context.appColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditNoteInfoSection(BuildContext context) {
    return EditSection(
      title: "General Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          Obx(
            () => CustomDropdown(
              label: "Customer",
              value: controller.selectedCustomer.value?.name,
              items: controller.customers.map((e) => e.name).toList(),
              searchable: true,
              isRequired: true,
              onChanged: (v) {
                final customer = controller.customers.firstWhereOrNull(
                  (e) => e.name == v,
                );
                if (customer != null) controller.onCustomerSelected(customer);
              },
            ),
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Date",
                  controller: controller.dateController,
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate:
                          controller.selectedDate.value ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) controller.onDateSelected(date);
                  },
                  suffixIcon: const Icon(PhosphorIconsRegular.calendar),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Due Date",
                  controller: controller.dueDateController,
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate:
                          controller.selectedDueDate.value ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) controller.onDueDateSelected(date);
                  },
                  suffixIcon: const Icon(PhosphorIconsRegular.calendar),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Reason",
            controller: controller.reasonController,
            hintText: "Enter reason for credit note",
          ),
          const Gap(Sizes.paddingM),
          Obx(
            () => CustomDropdown(
              label: "Salesman",
              value: controller.selectedSalesman.value?.fullName,
              items: controller.salesmen.map((e) => e.fullName).toList(),
              searchable: true,
              onChanged: (v) {
                final salesman = controller.salesmen.firstWhereOrNull(
                  (e) => e.fullName == v,
                );
                if (salesman != null) {
                  controller.selectedSalesman.value = salesman;
                }
              },
            ),
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Place of Supply",
            controller: controller.placeOfSupplyController,
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            final customer = controller.selectedCustomer.value;
            if (customer == null || customer.address.isEmpty) {
              return const SizedBox();
            }
            return Column(
              children: [
                CustomDropdown(
                  label: "Billing Address",
                  value: _formatAddress(
                    _convertToContactAddress(
                      controller.selectedBillingAddress.value,
                    ),
                  ),
                  items: customer.address
                      .map((a) => _formatAddress(a))
                      .toList(),
                  onChanged: (v) {
                    final address = customer.address.firstWhereOrNull(
                      (a) => _formatAddress(a) == v,
                    );
                    if (address != null) {
                      controller.selectedBillingAddress.value =
                          SalesCreditNoteAddress(
                            id: address.id,
                            addressLine1: address.addressLine1 ?? "",
                            addressLine2: address.addressLine2,
                            pinCode: address.pinCode ?? 0,
                            city: address.city != null
                                ? IdNameModel(
                                    id: address.city!.id,
                                    name: address.city!.name,
                                  )
                                : null,
                            state: address.state != null
                                ? IdNameModel(
                                    id: address.state!.id,
                                    name: address.state!.name,
                                  )
                                : null,
                            country: address.country != null
                                ? IdNameModel(
                                    id: address.country!.id,
                                    name: address.country!.name,
                                  )
                                : null,
                          );
                    }
                  },
                ),
                const Gap(Sizes.paddingM),
                CustomDropdown(
                  label: "Shipping Address",
                  value: _formatAddress(
                    _convertToContactAddress(
                      controller.selectedShippingAddress.value,
                    ),
                  ),
                  items: customer.address
                      .map((a) => _formatAddress(a))
                      .toList(),
                  onChanged: (v) {
                    final address = customer.address.firstWhereOrNull(
                      (a) => _formatAddress(a) == v,
                    );
                    if (address != null) {
                      controller.selectedShippingAddress.value =
                          SalesCreditNoteAddress(
                            id: address.id,
                            addressLine1: address.addressLine1 ?? "",
                            addressLine2: address.addressLine2,
                            pinCode: address.pinCode ?? 0,
                            city: address.city != null
                                ? IdNameModel(
                                    id: address.city!.id,
                                    name: address.city!.name,
                                  )
                                : null,
                            state: address.state != null
                                ? IdNameModel(
                                    id: address.state!.id,
                                    name: address.state!.name,
                                  )
                                : null,
                            country: address.country != null
                                ? IdNameModel(
                                    id: address.country!.id,
                                    name: address.country!.name,
                                  )
                                : null,
                          );
                    }
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context) {
    return EditSection(
      title: "Items",
      icon: PhosphorIconsLight.package,
      child: Obx(() {
        return Column(
          children: [
            CustomDropdown(
              label: "Search & Add Product",
              searchable: true,
              items: controller.availableProducts.map((e) => e.name).toList(),
              onChanged: (v) {
                final product = controller.availableProducts.firstWhereOrNull(
                  (e) => e.name == v,
                );
                if (product != null) {
                  controller.addItem(product);
                }
              },
            ),
            const Gap(Sizes.paddingM),
            if (controller.items.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.paddingXL,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        PhosphorIconsLight.shoppingCartSimple,
                        size: 48,
                        color: context.appColors.textSecondary.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      const Gap(Sizes.paddingS),
                      Text(
                        "No items added yet",
                        style: TextHelper.bodyMediumStyle(
                          context,
                        ).copyWith(color: context.appColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return SalesCreditNoteItemCard(
                    index: index,
                    item: controller.items[index],
                    controller: controller,
                  );
                },
              ),
          ],
        );
      }),
    );
  }

  Widget _buildAdditionalChargesSection(BuildContext context) {
    return EditSection(
      title: "Additional Charges",
      icon: PhosphorIconsLight.plusCircle,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: controller.addAdditionalCharge,
                icon: const Icon(PhosphorIconsLight.plus, size: 18),
                label: const Text("Add Charge"),
              ),
            ],
          ),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.additionalCharges.length,
              itemBuilder: (context, index) {
                final charge = controller.additionalCharges[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: Sizes.paddingM),
                  padding: const EdgeInsets.all(Sizes.paddingM),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                    border: Border.all(color: context.appColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown(
                              label: "Charge Name",
                              value: charge.name.isNotEmpty
                                  ? charge.name
                                  : null,
                              items: controller.availableCharges
                                  .map((e) => e.name)
                                  .toList(),
                              onChanged: (v) {
                                final selected = controller.availableCharges
                                    .firstWhereOrNull((e) => e.name == v);
                                if (selected != null) {
                                  controller.updateAdditionalCharge(
                                    index,
                                    charge.copyWith(
                                      id: selected.id,
                                      name: selected.name,
                                      amount: selected.defaultValue.toDouble(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                controller.removeAdditionalCharge(index),
                            icon: Icon(
                              PhosphorIconsLight.trash,
                              color: context.appColors.error,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.paddingM),
                      Row(
                        children: [
                          Expanded(
                            child: EditTextField(
                              label: "Amount",
                              initialValue: charge.amount.toString(),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                controller.updateAdditionalCharge(
                                  index,
                                  charge.copyWith(
                                    amount: double.tryParse(v) ?? 0,
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: CustomDropdown(
                              label: "Tax",
                              value: controller.taxes
                                  .firstWhereOrNull((t) => t.id == charge.taxId)
                                  ?.name,
                              items: controller.taxes
                                  .map((e) => e.name)
                                  .toList(),
                              onChanged: (v) {
                                final selected = controller.taxes
                                    .firstWhereOrNull((t) => t.name == v);
                                if (selected != null) {
                                  controller.updateAdditionalCharge(
                                    index,
                                    charge.copyWith(
                                      taxId: selected.id,
                                      taxPercent: selected.percentage
                                          .toDouble(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingDetailsSection(BuildContext context) {
    return EditSection(
      title: "Shipping Details",
      icon: PhosphorIconsLight.truck,
      isExpanded: false,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Shipping Type",
                  controller: controller.shippingTypeController,
                  onChanged: (v) => controller.shippingType.value = v,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Reference No",
                  controller: controller.referenceNoController,
                  onChanged: (v) => controller.referenceNo.value = v,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Shipping Date",
                  controller: controller.shippingDateController,
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate:
                          controller.shippingDate.value ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) controller.onShippingDateSelected(date);
                  },
                  suffixIcon: const Icon(PhosphorIconsRegular.calendar),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Transport Date",
                  controller: controller.transportDateController,
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate:
                          controller.transportDate.value ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) controller.onTransportDateSelected(date);
                  },
                  suffixIcon: const Icon(PhosphorIconsRegular.calendar),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Mode of Transport",
                  controller: controller.modeOfTransportController,
                  onChanged: (v) => controller.modeOfTransport.value = v,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Vehicle No",
                  controller: controller.vehicleNoController,
                  onChanged: (v) => controller.vehicleNo.value = v,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => CustomDropdown(
                    label: "Transporter",
                    value: controller.selectedTransporter.value?.name,
                    items: controller.availableTransporters
                        .map((e) => e.name)
                        .toList(),
                    onChanged: (v) {
                      final transporter = controller.availableTransporters
                          .firstWhereOrNull((e) => e.name == v);
                      controller.selectedTransporter.value = transporter;
                    },
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Weight",
                  controller: controller.weightController,
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      controller.weight.value = double.tryParse(v) ?? 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return EditSection(
      title: "Additional Info & Notes",
      icon: PhosphorIconsLight.notebook,
      isExpanded: false,
      child: Column(
        children: [
          EditTextField(
            label: "SEZ",
            controller: controller.sezController,
            onChanged: (v) => controller.sez.value = v,
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Notes",
            controller: controller.notesController,
            maxLines: 3,
            onChanged: (v) => controller.notes.value = v,
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection(BuildContext context) {
    return EditSection(
      title: "Terms & Conditions",
      icon: PhosphorIconsLight.scroll,
      isExpanded: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final unselected = controller.termsAndConditions
                .where((t) => !controller.isTermSelected(t.id))
                .toList();

            return CustomDropdown(
              label: "Select Terms",
              items: unselected.map((e) => e.termsCondition).toList(),
              value: null,
              searchable: true,
              onChanged: (v) {
                final selected = unselected.firstWhere(
                  (t) => t.termsCondition == v,
                );
                controller.toggleTerm(selected);
              },
            );
          }),
          const Gap(Sizes.paddingM),
          Obx(() {
            if (controller.selectedTerms.isEmpty) {
              return const SizedBox();
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.selectedTerms.length,
              itemBuilder: (context, index) {
                final term = controller.selectedTerms[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: Sizes.paddingM),
                  padding: const EdgeInsets.all(Sizes.paddingM),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    border: Border.all(color: context.appColors.border),
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                  child: Row(
                    children: [
                      const Icon(PhosphorIconsLight.fileText, size: 18),
                      const Gap(Sizes.paddingM),
                      Expanded(
                        child: Text(
                          term.termsCondition,
                          style: TextHelper.bodyMediumStyle(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.toggleTerm(term),
                        icon: Icon(
                          PhosphorIconsLight.trash,
                          color: context.appColors.error,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.appColors.border),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextHelper.bodyMediumStyle(context).copyWith(
                  color: context.appColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Expanded(
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : () => controller.saveSalesCreditNote(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                ),
                child: controller.isSaving.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        controller.isEdit.value
                            ? "Update Credit Note"
                            : "Save Credit Note",
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(ContactAddress? address) {
    if (address == null) return "Select Address";
    final parts = [
      address.addressLine1,
      address.addressLine2,
      address.city?.name,
      address.state?.name,
      address.pinCode?.toString(),
    ].where((e) => e != null && e.toString().isNotEmpty).toList();
    return parts.join(", ");
  }

  ContactAddress? _convertToContactAddress(SalesCreditNoteAddress? address) {
    if (address == null) return null;
    return ContactAddress(
      id: address.id,
      addressLine1: address.addressLine1,
      addressLine2: address.addressLine2,
      pinCode: address.pinCode,
      city: address.city != null
          ? ContactLocation(id: address.city!.id, name: address.city!.name)
          : null,
      state: address.state != null
          ? ContactLocation(id: address.state!.id, name: address.state!.name)
          : null,
      country: address.country != null
          ? ContactLocation(
              id: address.country!.id,
              name: address.country!.name,
            )
          : null,
    );
  }
}
