import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/modules/sales/delivery_challan/controllers/delivery_challan_add_edit_controller.dart';
import 'package:ai_setu/modules/sales/delivery_challan/widgets/delivery_challan_summary_section.dart';
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

class DeliveryChallanAddEditView
    extends GetView<DeliveryChallanAddEditController> {
  const DeliveryChallanAddEditView({super.key});

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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickAction(),
                const Gap(Sizes.paddingS),
                _buildHeader(context),
                const Gap(Sizes.paddingS),
                _buildChallanInfoSection(context),
                const Gap(Sizes.paddingM),
                _buildItemsSection(context),
                const Gap(Sizes.paddingM),
                _buildAdditionalChargesSection(context),
                const Gap(Sizes.paddingM),
                _buildShippingDetailsSection(context),
                const Gap(Sizes.paddingM),
                _buildTermsSection(context),
                const Gap(Sizes.paddingM),
                DeliveryChallanSummarySection(controller: controller),
                const Gap(Sizes.paddingXL),
              ],
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
                  : PhosphorIconsLight.truck,
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
                      ? "Edit Delivery Challan"
                      : "Add Delivery Challan",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage your delivery challans efficiently",
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

  Widget _buildChallanInfoSection(BuildContext context) {
    return EditSection(
      title: "Challan Information",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => SegmentedButton<String?>(
                segments: const [
                  ButtonSegment(
                    value: null,
                    label: Text('Direct'),
                    icon: Icon(PhosphorIconsLight.lightning),
                  ),
                  ButtonSegment(
                    value: 'sales-order',
                    label: Text('S.O.'),
                    icon: Icon(PhosphorIconsLight.shoppingCartSimple),
                  ),
                  ButtonSegment(
                    value: 'invoice',
                    label: Text('Invoice'),
                    icon: Icon(PhosphorIconsLight.fileText),
                  ),
                ],
                selected: {controller.createdFrom.value},
                onSelectionChanged: controller.isEdit.value
                    ? null
                    : (newSelection) {
                        controller.onSourceChanged(newSelection.first);
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
            final isCustomerNull = controller.selectedCustomer.value == null;
            if (controller.createdFrom.value == 'sales-order') {
              return Column(
                children: [
                  if (!controller.isEdit.value)
                    CustomDropdown(
                      label: isCustomerNull
                          ? "Add Sales Order (Select Customer First)"
                          : "Add Sales Order",
                      value: null,
                      readOnly: isCustomerNull,
                      items: isCustomerNull
                          ? const <String>[]
                          : controller.availableSalesOrders
                                .map((e) => e.name)
                                .toList(),
                      searchable: true,
                      onChanged: (v) {
                        final order = controller.availableSalesOrders
                            .firstWhereOrNull((e) => e.name == v);
                        if (order != null) {
                          controller.addSalesOrder(order);
                        }
                      },
                    ),
                  if (controller.selectedSalesOrders.isNotEmpty) ...[
                    const Gap(Sizes.paddingS),
                    ...controller.selectedSalesOrders.map(
                      (order) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.appColors.border),
                        ),
                        child: Row(
                          children: [
                            const Icon(PhosphorIconsLight.fileText, size: 16),
                            const Gap(8),
                            Expanded(child: Text(order.name)),
                            if (!controller.isEdit.value)
                              IconButton(
                                onPressed: () => controller.selectedSalesOrders
                                    .remove(order),
                                icon: const Icon(
                                  PhosphorIconsLight.x,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              );
            }
            if (controller.createdFrom.value == 'invoice') {
              return Column(
                children: [
                  if (!controller.isEdit.value)
                    CustomDropdown(
                      label: isCustomerNull
                          ? "Reference Invoice (Select Customer First)"
                          : "Reference Invoice",
                      value: null,
                      readOnly: isCustomerNull,
                      items: isCustomerNull
                          ? const <String>[]
                          : controller.availableInvoices
                                .map((e) => e.name)
                                .toList(),
                      searchable: true,
                      onChanged: (v) {
                        final invoice = controller.availableInvoices
                            .firstWhereOrNull((e) => e.name == v);
                        if (invoice != null) {
                          controller.addInvoice(invoice);
                        }
                      },
                    ),
                  if (controller.selectedInvoices.isNotEmpty) ...[
                    const Gap(Sizes.paddingS),
                    ...controller.selectedInvoices.map(
                      (invoice) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.appColors.border),
                        ),
                        child: Row(
                          children: [
                            const Icon(PhosphorIconsLight.fileText, size: 16),
                            const Gap(8),
                            Expanded(child: Text(invoice.name)),
                            if (!controller.isEdit.value)
                              IconButton(
                                onPressed: () =>
                                    controller.selectedInvoices.remove(invoice),
                                icon: const Icon(
                                  PhosphorIconsLight.x,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              );
            }
            return const SizedBox();
          }),
          const Gap(Sizes.paddingM),
          Obx(
            () => CustomDropdown(
              label: "Customer",
              isRequired: true,
              value: controller.selectedCustomer.value?.name,
              items: controller.availableCustomers.map((e) => e.name).toList(),
              searchable: true,
              readOnly:
                  controller.isEdit.value ||
                  controller.selectedSalesOrders.isNotEmpty,
              onChanged: (v) {
                final customer = controller.availableCustomers.firstWhereOrNull(
                  (e) => e.name == v,
                );
                if (customer != null) {
                  controller.selectedCustomer.value = customer;
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
                    controller.selectedBillingAddress.value,
                  ),
                  items: customer.address
                      .map((a) => _formatAddress(a))
                      .toList(),
                  onChanged: (v) {
                    final address = customer.address.firstWhereOrNull(
                      (a) => _formatAddress(a) == v,
                    );
                    if (address != null) {
                      controller.selectedBillingAddress.value = address;
                    }
                  },
                ),
                const Gap(Sizes.paddingM),
                CustomDropdown(
                  label: "Shipping Address",
                  value: _formatAddress(
                    controller.selectedShippingAddress.value,
                  ),
                  items: customer.address
                      .map((a) => _formatAddress(a))
                      .toList(),
                  onChanged: (v) {
                    final address = customer.address.firstWhereOrNull(
                      (a) => _formatAddress(a) == v,
                    );
                    if (address != null) {
                      controller.selectedShippingAddress.value = address;
                    }
                  },
                ),
              ],
            );
          }),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: InkWell(
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
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Date",
                      isRequired: true,
                      controller: controller.dateController,
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: InkWell(
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
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Due Date",
                      isRequired: true,
                      controller: controller.dueDateController,
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
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
                  () => CustomDropdown(
                    label: "Payment Term",
                    value: controller.availablePaymentTerms
                        .firstWhereOrNull(
                          (t) =>
                              t.id == controller.selectedPaymentTermsId.value,
                        )
                        ?.name,
                    items: controller.availablePaymentTerms
                        .map((e) => e.name)
                        .toList(),
                    onChanged: (v) {
                      final term = controller.availablePaymentTerms
                          .firstWhereOrNull((e) => e.name == v);
                      if (term != null) {
                        controller.selectedPaymentTermsId.value = term.id;
                      }
                    },
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: Obx(
                  () => CustomDropdown(
                    label: "Tax Type",
                    value: controller.taxType.value.capitalizeFirst,
                    items: const ['Default', 'Exclusive'],
                    onChanged: (v) {
                      controller.taxType.value = v.toLowerCase();
                    },
                  ),
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
      child: Column(
        children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
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
                            child: Obx(
                              () => CustomDropdown(
                                label: "Product",
                                value: item.productId.value?.name,
                                items: controller.availableProducts
                                    .map((e) => e.name)
                                    .toList(),
                                searchable: true,
                                onChanged: (v) {
                                  final product = controller.availableProducts
                                      .firstWhereOrNull((e) => e.name == v);
                                  if (product != null) {
                                    item.productId.value = product;
                                  }
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.removeItem(index),
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
                              label: "Qty",
                              controller: item.qtyController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: EditTextField(
                              label: "Price",
                              controller: item.priceController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: EditTextField(
                              label: "Disc Amt",
                              controller: item.discountController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Sizes.paddingM),
                      Row(
                        children: [
                          Expanded(
                            child: EditTextField(
                              label: "Free Qty",
                              controller: item.freeQtyController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: Obx(
                              () => EditTextField(
                                label: "Total",
                                readOnly: true,
                                controller: TextEditingController(
                                  text: item.totalAmount.value.toStringAsFixed(
                                    2,
                                  ),
                                ),
                              ),
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
          const Gap(Sizes.paddingM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => controller.addItem(),
              icon: const Icon(PhosphorIconsLight.plus, size: 16),
              label: const Text("Add Item"),
            ),
          ),
        ],
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomDropdown(
                            label: "Charge",
                            value: charge.chargeId.value?.name,
                            items: controller.availableCharges
                                .map((e) => e.name)
                                .toList(),
                            onChanged: (v) {
                              final c = controller.availableCharges
                                  .firstWhereOrNull((e) => e.name == v);
                              if (c != null) {
                                charge.chargeId.value = c;
                              }
                            },
                          ),
                        ),
                      ),
                      const Gap(Sizes.paddingM),
                      Expanded(
                        child: EditTextField(
                          label: "Amount",
                          controller: charge.amountController,
                          keyboardType: TextInputType.number,
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
                );
              },
            ),
          ),
          const Gap(Sizes.paddingM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => controller.addAdditionalCharge(),
              icon: const Icon(PhosphorIconsLight.plus, size: 16),
              label: const Text("Add Charge"),
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
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Ref No",
                  controller: controller.referenceNoController,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: InkWell(
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
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Shipping Date",
                      controller: controller.shippingDateController,
                      suffixIcon: const Icon(PhosphorIconsLight.calendar),
                    ),
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Weight",
                  controller: controller.weightController,
                  keyboardType: TextInputType.number,
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
                  final unselected = controller.availableTermsAndConditions
                      .where(
                        (t) => !controller.selectedTermsAndConditionIds
                            .contains(t.id),
                      )
                      .toList();
                  return CustomDropdown(
                    label: "Add Term",
                    value: null,
                    items: unselected.map((e) => e.termsCondition).toList(),
                    searchable: true,
                    onChanged: (v) {
                      final term = unselected.firstWhereOrNull(
                        (e) => e.termsCondition == v,
                      );
                      if (term != null) {
                        controller.selectedTermsAndConditionIds.add(term.id);
                      }
                    },
                  );
                }),
              ),
            ],
          ),
          Obx(() {
            if (controller.selectedTermsAndConditionIds.isEmpty) {
              return const SizedBox();
            }
            return Column(
              children: [
                const Gap(Sizes.paddingM),
                ...controller.selectedTermsAndConditionIds.map((id) {
                  final term = controller.availableTermsAndConditions
                      .firstWhereOrNull((t) => t.id == id);
                  if (term == null) return const SizedBox();
                  return Container(
                    margin: const EdgeInsets.only(bottom: Sizes.paddingS),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.paddingM,
                      vertical: Sizes.paddingS,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.surface,
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                      border: Border.all(color: context.appColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(PhosphorIconsLight.textT, size: 16),
                        const Gap(Sizes.paddingS),
                        Expanded(
                          child: Text(
                            term.termsCondition,
                            style: TextHelper.bodyMediumStyle(context),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.selectedTermsAndConditionIds.remove(id);
                          },
                          icon: Icon(
                            PhosphorIconsLight.trash,
                            color: context.appColors.error,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  );
                }),
              ],
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
                    : () => controller.saveDeliveryChallan(),
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
                            ? "Update Challan"
                            : "Save Challan",
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
}
