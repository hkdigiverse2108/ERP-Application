import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/controllers/purchase_debit_note_add_edit_controller.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/widgets/debit_note_item_card.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/widgets/debit_note_summary_section.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PurchaseDebitNoteAddEditView
    extends GetView<PurchaseDebitNoteAddEditController> {
  const PurchaseDebitNoteAddEditView({super.key});

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
                  _buildDebitNoteInfoSection(context),
                  const Gap(Sizes.paddingM),
                  _buildItemsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildReasonSection(context),
                  const Gap(Sizes.paddingM),
                  _buildAdditionalChargesSection(context),
                  const Gap(Sizes.paddingM),
                  _buildTermsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildShippingDetailsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildSummarySection(context),
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
      child: Row(
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
                      ? "Edit Purchase Debit Note"
                      : "Add Purchase Debit Note",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage purchase returns and price adjustments",
                  style: TextHelper.captionStyle(
                    context,
                  ).copyWith(color: context.appColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebitNoteInfoSection(BuildContext context) {
    return EditSection(
      title: "Debit Note Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          CustomDropdown(
            label: "Supplier",
            value: controller.selectedSupplier.value?.name,
            items: controller.suppliers.map((e) => e.name).toList(),
            searchable: true,
            onChanged: (v) {
              controller.selectedSupplier.value = controller.suppliers
                  .firstWhereOrNull((e) => e.name == v);
            },
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            final supplier = controller.selectedSupplier.value;
            if (supplier == null || supplier.address.isEmpty) {
              return const SizedBox();
            }
            return Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    label: "Billing Address",
                    value: _formatAddress(
                      controller.selectedBillingAddress.value,
                    ),
                    items: supplier.address
                        .map((a) => _formatAddress(a))
                        .toList(),
                    onChanged: (v) {
                      controller.selectedBillingAddress.value = supplier.address
                          .firstWhereOrNull((a) => _formatAddress(a) == v);
                    },
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: CustomDropdown(
                    label: "Shipping Address",
                    value: _formatAddress(
                      controller.selectedShippingAddress.value,
                    ),
                    items: supplier.address
                        .map((a) => _formatAddress(a))
                        .toList(),
                    onChanged: (v) {
                      controller.selectedShippingAddress.value = supplier
                          .address
                          .firstWhereOrNull((a) => _formatAddress(a) == v);
                    },
                  ),
                ),
              ],
            );
          }),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, controller.debitNoteDate),
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Date",
                      controller: TextEditingController(
                        text: DateFormat(
                          'dd/MM/yyyy',
                        ).format(controller.debitNoteDate.value),
                      ),
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Reference Bill No",
                  controller: controller.referenceBillNoController,
                  hintText: "Enter bill number",
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, controller.dueDate),
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Due Date",
                      controller: TextEditingController(
                        text: DateFormat(
                          'dd/MM/yyyy',
                        ).format(controller.dueDate.value),
                      ),
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: CustomDropdown(
                  label: "Payment Terms",
                  value: controller.selectedPaymentTerm.value?.name,
                  items: controller.paymentTerms.map((e) => e.name).toList(),
                  onChanged: (v) {
                    controller.selectedPaymentTerm.value = controller
                        .paymentTerms
                        .firstWhereOrNull((e) => e.name == v);
                  },
                ),
              ),
            ],
          ),
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
              items: controller.products.map((e) => e.name).toList(),
              onChanged: (v) {
                final product = controller.products.firstWhereOrNull(
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
                        style: TextHelper.bodyMedium.copyWith(
                          color: context.appColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Column(
                children: List.generate(
                  controller.items.length,
                  (index) => DebitNoteItemCard(
                    index: index,
                    item: controller.items[index],
                    controller: controller,
                    onRemove: () => controller.removeItem(index),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildReasonSection(BuildContext context) {
    return EditSection(
      title: "Reason & Notes",
      icon: PhosphorIconsLight.note,
      child: Column(
        children: [
          EditTextField(
            label: "Reason",
            controller: controller.reasonController,
            hintText: "Enter reason for debit note",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Notes",
            controller: controller.notesController,
            hintText: "Enter internal notes",
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return DebitNoteSummarySection(controller: controller);
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(top: BorderSide(color: context.appColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                side: BorderSide(color: context.appColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextHelper.bodyLarge.copyWith(
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
                    : () => controller.saveDebitNote(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                  ),
                  elevation: 0,
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
                        "Save Debit Note",
                        style: TextHelper.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, Rx<DateTime> date) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      date.value = picked;
    }
  }

  Widget _buildAdditionalChargesSection(BuildContext context) {
    return EditSection(
      title: "Additional Charges",
      icon: PhosphorIconsLight.plusCircle,
      isExpanded: false,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => controller.addAdditionalCharge(),
              icon: const Icon(PhosphorIconsLight.plus, size: 16),
              label: const Text("Add Charge"),
            ),
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            if (controller.additionalCharges.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.paddingXL,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        PhosphorIconsLight.receipt,
                        size: 40,
                        color: context.appColors.textSecondary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      const Gap(Sizes.paddingS),
                      Text(
                        "No additional charges",
                        style: TextHelper.captionStyle(context),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: List.generate(
                controller.additionalCharges.length,
                (index) => _buildAdditionalChargeCard(
                  context,
                  index,
                  controller.additionalCharges[index],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAdditionalChargeCard(
    BuildContext context,
    int index,
    DebitNoteAdditionalCharge charge,
  ) {
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
                  value: charge.name.isEmpty ? null : charge.name,
                  items: controller.availableAdditionalCharges
                      .map((e) => e.name)
                      .toList(),
                  searchable: true,
                  onChanged: (v) {
                    final selected = controller.availableAdditionalCharges
                        .firstWhereOrNull((e) => e.name == v);
                    if (selected != null) {
                      final tax = controller.taxes.firstWhereOrNull(
                        (t) => t.id == selected.taxId.id,
                      );
                      controller.updateAdditionalCharge(
                        index,
                        charge.copyWith(
                          id: selected.id,
                          name: selected.name,
                          amount: selected.defaultValue.toDouble(),
                          taxId: selected.taxId.id,
                          taxPercent: tax?.percentage.toDouble() ?? 0,
                        ),
                      );
                    }
                  },
                ),
              ),
              const Gap(Sizes.paddingS),
              IconButton(
                onPressed: () => controller.removeAdditionalCharge(index),
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
                  controller: TextEditingController(
                    text: charge.amount.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    controller.updateAdditionalCharge(
                      index,
                      charge.copyWith(amount: double.tryParse(v) ?? 0),
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
                  items: controller.taxes.map((e) => e.name).toList(),
                  onChanged: (v) {
                    final selected = controller.taxes.firstWhereOrNull(
                      (t) => t.name == v,
                    );
                    if (selected != null) {
                      controller.updateAdditionalCharge(
                        index,
                        charge.copyWith(
                          taxId: selected.id,
                          taxPercent: selected.percentage.toDouble(),
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
  }

  Widget _buildTermsSection(BuildContext context) {
    return EditSection(
      title: "Terms & Conditions",
      icon: PhosphorIconsLight.scroll,
      isExpanded: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(() {
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
              ),
              const Gap(Sizes.paddingM),
              OutlinedButton.icon(
                onPressed: () => _showAddTermDialog(context),
                icon: const Icon(PhosphorIconsLight.plus, size: 18),
                label: const Text("New"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            if (controller.selectedTerms.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.paddingM),
                  child: Text(
                    "No terms selected",
                    style: TextHelper.captionStyle(
                      context,
                    ).copyWith(color: context.appColors.textSecondary),
                  ),
                ),
              );
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
                      Icon(
                        PhosphorIconsLight.fileText,
                        size: 18,
                        color: context.appColors.textSecondary,
                      ),
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

  void _showAddTermDialog(BuildContext context) {
    final contentController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: context.appColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        ),
        title: Text(
          "Add New Term",
          style: TextHelper.h6Style(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditTextField(
              label: "Term Content",
              controller: contentController,
              hintText: "Enter term and condition content",
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: TextStyle(color: context.appColors.textSecondary),
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isAddingTerm.value
                  ? null
                  : () async {
                      if (contentController.text.isNotEmpty) {
                        await controller.addNewTerm("", contentController.text);
                        Get.back();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              child: controller.isAddingTerm.value
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Save Term"),
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
                child: Obx(
                  () => CustomDropdown(
                    label: "Transporter Name",
                    items: controller.transporters.map((e) => e.name).toList(),
                    value: controller.selectedTransporter.value?.name,
                    searchable: true,
                    onChanged: (v) {
                      controller.selectedTransporter.value = controller
                          .transporters
                          .firstWhereOrNull((e) => e.name == v);
                    },
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: Obx(
                  () => CustomDropdown(
                    label: "Shipping Type",
                    items: const ["delivery", "pickup", "courier", "other"],
                    value: controller.shippingType.value,
                    onChanged: (v) => controller.shippingType.value = v,
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => EditTextField(
                    label: "Shipping Date",
                    controller: TextEditingController(
                      text: controller.shippingDate.value != null
                          ? controller.shippingDate.value!
                                .toLocal()
                                .toString()
                                .split(' ')[0]
                          : "",
                    ),
                    suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate:
                            controller.shippingDate.value ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        controller.shippingDate.value = picked;
                      }
                    },
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Reference No",
                  controller: controller.shippingReferenceNoController,
                  hintText: "Enter reference no",
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => EditTextField(
                    label: "Transport Date",
                    controller: TextEditingController(
                      text: controller.transportDate.value
                          .toLocal()
                          .toString()
                          .split(' ')[0],
                    ),
                    suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    readOnly: true,
                    onTap: () => _selectDate(context, controller.transportDate),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Mode Of Transport",
                  controller: controller.modeOfTransportController,
                  hintText: "e.g. Road, Air, Sea",
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Vehicle No",
                  controller: controller.vehicleNoController,
                  hintText: "Enter vehicle no",
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Weight",
                  controller: controller.shippingWeightController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter weight",
                ),
              ),
            ],
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
}
