import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/modules/sales/invoice/controllers/invoice_add_edit_controller.dart';
import 'package:ai_setu/modules/sales/invoice/widgets/invoice_item_card.dart';
import 'package:ai_setu/modules/sales/invoice/widgets/invoice_summary_section.dart';
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

class InvoiceAddEditView extends GetView<InvoiceAddEditController> {
  const InvoiceAddEditView({super.key});

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
                  _buildInvoiceInfoSection(context),
                  const Gap(Sizes.paddingM),
                  _buildItemsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildNotesSection(context),
                  const Gap(Sizes.paddingM),
                  _buildAdditionalChargesSection(context),
                  const Gap(Sizes.paddingM),
                  _buildTermsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildShippingDetailsSection(context),
                  const Gap(Sizes.paddingM),
                  InvoiceSummarySection(controller: controller),
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
                  controller.isEdit.value ? "Edit Invoice" : "Add Invoice",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage your sales invoices efficiently",
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

  Widget _buildInvoiceInfoSection(BuildContext context) {
    return EditSection(
      title: "Invoice Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'direct',
                    label: Text('Direct'),
                    icon: Icon(PhosphorIconsLight.lightning),
                  ),
                  ButtonSegment(
                    value: 'salesOrder',
                    label: Text('S.O.'),
                    icon: Icon(PhosphorIconsLight.shoppingCartSimple),
                  ),
                  ButtonSegment(
                    value: 'deliveryChallan',
                    label: Text('D.C.'),
                    icon: Icon(PhosphorIconsLight.truck),
                  ),
                ],
                selected: {controller.invoiceSource.value},
                onSelectionChanged: controller.isEdit.value
                    ? null
                    : (Set<String> newSelection) {
                        controller.invoiceSource.value = newSelection.first;
                      },
                style: SegmentedButton.styleFrom(
                  backgroundColor: context.appColors.surface,
                  selectedBackgroundColor: context.appColors.primary,
                  selectedForegroundColor: Colors.white,
                  side: BorderSide(color: context.appColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                ),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            if (controller.invoiceSource.value == 'direct') {
              return const SizedBox();
            }
            if (controller.invoiceSource.value == 'salesOrder') {
              final isCustomerNull = controller.selectedCustomer.value == null;
              return Column(
                children: [
                  if (!controller.isEdit.value)
                    CustomDropdown(
                      label: isCustomerNull
                          ? "Add Sales Order (Select Customer First)"
                          : "Add Sales Order",
                      value: null,
                      items: isCustomerNull
                          ? const <String>[]
                          : controller.salesOrders.map((e) => e.name).toList(),
                      searchable: true,
                      readOnly: isCustomerNull,
                      onChanged: (v) {
                        final order = controller.salesOrders.firstWhereOrNull(
                          (e) => e.name == v,
                        );
                        if (order != null) controller.addSalesOrder(order);
                      },
                    ),
                  if (controller.selectedSalesOrders.isNotEmpty) ...[
                    const Gap(Sizes.paddingS),
                    ...controller.selectedSalesOrders.asMap().entries.map((
                      entry,
                    ) {
                      return _buildSelectedDocItem(
                        context,
                        entry.value.name,
                        () => controller.removeSalesOrder(entry.key),
                        isRemovable: !controller.isEdit.value,
                      );
                    }),
                  ],
                ],
              );
            }
            if (controller.invoiceSource.value == 'deliveryChallan') {
              final isCustomerNull = controller.selectedCustomer.value == null;
              return Column(
                children: [
                  if (!controller.isEdit.value)
                    CustomDropdown(
                      label: isCustomerNull
                          ? "Add Delivery Challan (Select Customer First)"
                          : "Add Delivery Challan",
                      value: null,
                      items: isCustomerNull
                          ? const <String>[]
                          : controller.deliveryChallans
                                .map((e) => e.name)
                                .toList(),
                      searchable: true,
                      readOnly: isCustomerNull,
                      onChanged: (v) {
                        final challan = controller.deliveryChallans
                            .firstWhereOrNull((e) => e.name == v);
                        if (challan != null) {
                          controller.addDeliveryChallan(challan);
                        }
                      },
                    ),
                  if (controller.selectedDeliveryChallans.isNotEmpty) ...[
                    const Gap(Sizes.paddingS),
                    ...controller.selectedDeliveryChallans.asMap().entries.map((
                      entry,
                    ) {
                      return _buildSelectedDocItem(
                        context,
                        entry.value.name,
                        () => controller.removeDeliveryChallan(entry.key),
                        isRemovable: !controller.isEdit.value,
                      );
                    }),
                  ],
                ],
              );
            }
            return const SizedBox();
          }),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "Salesman",
            value: controller.selectedSalesman.value?.fullName,
            items: controller.salesmen.map((e) => e.fullName).toList(),
            searchable: true,
            onChanged: (v) {
              controller.selectedSalesman.value = controller.salesmen
                  .firstWhereOrNull((e) => e.fullName == v);
            },
          ),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "Customer",
            value: controller.selectedCustomer.value?.name,
            items: controller.customers.map((e) => e.name).toList(),
            searchable: true,
            onChanged: (v) {
              controller.selectedCustomer.value = controller.customers
                  .firstWhereOrNull((e) => e.name == v);
            },
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            final customer = controller.selectedCustomer.value;
            if (customer == null || customer.address.isEmpty) {
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
                    items: customer.address
                        .map((a) => _formatAddress(a))
                        .toList(),
                    onChanged: (v) {
                      controller.selectedBillingAddress.value = customer.address
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
                    items: customer.address
                        .map((a) => _formatAddress(a))
                        .toList(),
                    onChanged: (v) {
                      controller.selectedShippingAddress.value = customer
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
                  onTap: () => _selectDate(context, controller.invoiceDate),
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Date",
                      controller: TextEditingController(
                        text: DateFormat(
                          'dd/MM/yyyy',
                        ).format(controller.invoiceDate.value),
                      ),
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Invoice No",
                  controller: controller.invoiceNoController,
                  hintText: "Auto-generated",
                  readOnly: true,
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
                        PhosphorIconsLight.receipt,
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
                  (index) => InvoiceItemCard(
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

  Widget _buildNotesSection(BuildContext context) {
    return EditSection(
      title: "Notes",
      icon: PhosphorIconsLight.note,
      child: EditTextField(
        label: "Internal Notes",
        controller: controller.notesController,
        hintText: "Enter internal notes",
        maxLines: 3,
      ),
    );
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
              return const SizedBox();
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
    InvoiceAdditionalChargeState charge,
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
              ),
            ],
          ),
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
        title: const Text("Add New Term"),
        content: EditTextField(
          label: "Term Content",
          controller: contentController,
          maxLines: 5,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
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
              child: const Text("Save Term"),
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
                    label: "Transporter",
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
                  () => InkWell(
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
                    child: IgnorePointer(
                      child: EditTextField(
                        label: "Shipping Date",
                        controller: TextEditingController(
                          text: controller.shippingDate.value != null
                              ? DateFormat(
                                  'dd/MM/yyyy',
                                ).format(controller.shippingDate.value!)
                              : '',
                        ),
                        suffixIcon: const Icon(PhosphorIconsLight.calendar),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Ref No",
                  controller: controller.shippingReferenceNoController,
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
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Vehicle No",
                  controller: controller.vehicleNoController,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Weight",
            controller: controller.shippingWeightController,
            keyboardType: TextInputType.number,
          ),
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
                    : () => controller.saveInvoice(),
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
                            ? "Update Invoice"
                            : "Save Invoice",
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedDocItem(
    BuildContext context,
    String name,
    VoidCallback onRemove, {
    bool isRemovable = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.appColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
        border: Border.all(
          color: context.appColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIconsLight.fileText,
            size: 16,
            color: context.appColors.primary,
          ),
          const Gap(Sizes.paddingS),
          Expanded(
            child: Text(
              name,
              style: TextHelper.bodySmallStyle(context).copyWith(
                color: context.appColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isRemovable)
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                PhosphorIconsLight.x,
                size: 14,
                color: context.appColors.primary,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  String _formatAddress(ContactAddress? addr) {
    if (addr == null) return "";
    return "${addr.addressLine1}, ${addr.city?.name}";
  }

  void _selectDate(BuildContext context, Rx<DateTime> date) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) date.value = picked;
  }
}
