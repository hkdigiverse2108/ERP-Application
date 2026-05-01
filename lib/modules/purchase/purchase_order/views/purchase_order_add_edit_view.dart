import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/purchase/purchase_order/controllers/purchase_order_add_edit_controller.dart';
import 'package:ai_setu/modules/purchase/purchase_order/widgets/po_item_card.dart';
import 'package:ai_setu/modules/purchase/purchase_order/widgets/po_summary_section.dart';
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

class PurchaseOrderAddEditView extends GetView<PurchaseOrderAddEditController> {
  const PurchaseOrderAddEditView({super.key});

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
                  _buildOrderInfoSection(context),
                  const Gap(Sizes.paddingM),
                  _buildItemsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildTermsAndNotesSection(context),
                  // const Gap(Sizes.paddingM),
                  // _buildAdditionalChargesSection(context),
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
                  : PhosphorIconsLight.shoppingCartSimple,
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
                      ? "Edit Purchase Order"
                      : "Add Purchase Order",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage purchase orders and item requests",
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

  Widget _buildOrderInfoSection(BuildContext context) {
    return EditSection(
      title: "Order Information",
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
          Obx(() {
            final supplier = controller.selectedSupplier.value;
            if (supplier == null || supplier.address.isEmpty) {
              return const SizedBox();
            }
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: "Billing Address",
                        value: _formatAddress(
                            controller.selectedBillingAddress.value),
                        items: supplier.address
                            .map((a) => _formatAddress(a))
                            .toList(),
                        onChanged: (v) {
                          controller.selectedBillingAddress.value =
                              supplier.address.firstWhereOrNull(
                                  (a) => _formatAddress(a) == v);
                        },
                      ),
                    ),
                    const Gap(Sizes.paddingM),
                    Expanded(
                      child: CustomDropdown(
                        label: "Shipping Address",
                        value: _formatAddress(
                            controller.selectedShippingAddress.value),
                        items: supplier.address
                            .map((a) => _formatAddress(a))
                            .toList(),
                        onChanged: (v) {
                          controller.selectedShippingAddress.value =
                              supplier.address.firstWhereOrNull(
                                  (a) => _formatAddress(a) == v);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(Sizes.paddingM),
              ],
            );
          }),
          InkWell(
            onTap: () => _selectDate(context, controller.orderDate),
            child: IgnorePointer(
              child: EditTextField(
                label: "Order Date",
                controller: TextEditingController(
                  text: DateFormat(
                    'dd/MM/yyyy',
                  ).format(controller.orderDate.value),
                ),
                suffixIcon: const Icon(PhosphorIconsLight.calendar),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "GSTIN",
                  controller: TextEditingController(
                    text: controller.gstIn.value,
                  ),
                  readOnly: true,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: InkWell(
                  onTap: () =>
                      _selectDateNullable(context, controller.shippingDate),
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Expected Delivery Date",
                      controller: TextEditingController(
                        text: controller.shippingDate.value != null
                            ? DateFormat(
                                'dd/MM/yyyy',
                              ).format(controller.shippingDate.value!)
                            : "",
                      ),
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
                child: CustomDropdown(
                  label: "Tax Type",
                  value: controller.taxType.value.label,
                  items: TaxType.values.map((e) => e.label).toList(),
                  onChanged: (v) {
                    controller.taxType.value = TaxType.values.firstWhere(
                      (e) => e.label == v,
                    );
                    controller.calculateTotals();
                  },
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Place of Supply",
                  controller: TextEditingController(
                    text: controller.placeOfSupply.value,
                  ),
                  onChanged: (v) => controller.placeOfSupply.value = v,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Shipping Note",
            controller: controller.shippingNoteController,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditSection(
          title: "Select Product",
          icon: PhosphorIconsLight.magnifyingGlass,
          child: CustomDropdown(
            label: "Search & Add Product",
            items: controller.products.map((e) => e.name).toList(),
            onChanged: (v) {
              final product = controller.products.firstWhereOrNull(
                (e) => e.name == v,
              );
              if (product != null) controller.addOrderItem(product);
            },
            searchable: true,
          ),
        ),
        const Gap(Sizes.paddingM),
        if (controller.orderItems.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  PhosphorIconsLight.listBullets,
                  size: 18,
                  color: context.appColors.primary,
                ),
                const Gap(8),
                Text(
                  "Added Items (${controller.orderItems.length})",
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Gap(Sizes.paddingS),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.orderItems.length,
              itemBuilder: (context, index) {
                final item = controller.orderItems[index];
                return POItemCard(
                  index: index,
                  item: item,
                  controller: controller,
                  onRemove: () => controller.removeOrderItem(index),
                );
              },
            ),
          ),
        ] else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Sizes.paddingXL),
              decoration: BoxDecoration(
                color: context.appColors.surface,
                borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                border: Border.all(
                  color: context.appColors.border.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    PhosphorIconsLight.package,
                    size: 48,
                    color: context.appColors.textSecondary.withValues(
                      alpha: 0.3,
                    ),
                  ),
                  const Gap(Sizes.paddingM),
                  Text(
                    "No products added yet",
                    style: TextHelper.bodyMedium.copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTermsAndNotesSection(BuildContext context) {
    return Column(
      children: [
        EditSection(
          title: "Terms & Conditions",
          icon: PhosphorIconsLight.fileText,
          isExpanded: false,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Obx(() {
                      final unselected = controller.termsAndConditions
                          .where((t) => !controller.isTermSelected(t.id))
                          .toList();

                      return CustomDropdown(
                        label: "Terms & Conditions",
                        items: unselected.map((e) => e.termsCondition).toList(),
                        value: null,
                        searchable: true,
                        searchHint: "Search terms...",
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
                    label: const Text("New Term"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadiusM,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(Sizes.paddingM),
              Obx(
                () => controller.selectedTerms.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(Sizes.paddingM),
                        child: Center(
                          child: Text(
                            "No terms selected",
                            style: TextHelper.captionStyle(context),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.selectedTerms.length,
                        itemBuilder: (context, index) {
                          final term = controller.selectedTerms[index];
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: Sizes.paddingM,
                            ),
                            padding: const EdgeInsets.all(Sizes.paddingM),
                            decoration: BoxDecoration(
                              color: context.appColors.surface,
                              border: Border.all(
                                color: context.appColors.border,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusM,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Icon(
                                    PhosphorIconsLight.fileText,
                                    size: 18,
                                    color: context.appColors.textSecondary,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: Text(
                                    term.termsCondition,
                                    style: TextHelper.bodyMediumStyle(
                                      context,
                                    ).copyWith(height: 1.4),
                                  ),
                                ),
                                const Gap(Sizes.paddingS),
                                InkWell(
                                  onTap: () => controller.toggleTerm(term),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: context.appColors.error.withValues(
                                        alpha: 0.1,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      PhosphorIconsLight.trash,
                                      color: context.appColors.error,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        const Gap(Sizes.paddingM),
        EditSection(
          title: "Internal Notes",
          icon: PhosphorIconsLight.note,
          child: EditTextField(
            label: "Note",
            controller: controller.notesController,
            maxLines: 4,
          ),
        ),
      ],
    );
  }

  // Widget _buildAdditionalChargesSection(BuildContext context) {
  //   return EditSection(
  //     title: "Additional Charges",
  //     icon: PhosphorIconsLight.plusCircle,
  //     isExpanded: false,
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           width: double.infinity,
  //           child: OutlinedButton.icon(
  //             onPressed: () => controller.addAdditionalCharge(),
  //             icon: const Icon(PhosphorIconsLight.plus, size: 16),
  //             label: const Text("Add Charge"),
  //           ),
  //         ),
  //         const Gap(Sizes.paddingM),
  //         Obx(() {
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: controller.additionalCharges.length,
  //             itemBuilder: (context, index) {
  //               final item = controller.additionalCharges[index];
  //               return _buildAdditionalChargeCard(context, index, item);
  //             },
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildAdditionalChargeCard(
  //   BuildContext context,
  //   int index,
  //   POAdditionalCharge item,
  // ) {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: Sizes.paddingM),
  //     child: Padding(
  //       padding: const EdgeInsets.all(Sizes.paddingM),
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: CustomDropdown(
  //                   label: "Charge Type",
  //                   items: controller.availableAdditionalCharges
  //                       .map((e) => e.name)
  //                       .toList(),
  //                   value: item.name,
  //                   onChanged: (v) {
  //                     final charge = controller.availableAdditionalCharges
  //                         .firstWhereOrNull((e) => e.name == v);
  //                     controller.updateAdditionalChargeSelection(index, charge);
  //                   },
  //                 ),
  //               ),
  //               IconButton(
  //                 onPressed: () => controller.removeAdditionalCharge(index),
  //                 icon: const Icon(PhosphorIconsLight.trash),
  //               ),
  //             ],
  //           ),
  //           const Gap(Sizes.paddingM),
  //           EditTextField(
  //             label: "Amount",
  //             controller: TextEditingController(text: item.amount.toString()),
  //             keyboardType: TextInputType.number,
  //             onChanged: (v) => controller.updateAdditionalChargeAmount(
  //               index,
  //               double.tryParse(v) ?? 0,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSummarySection(BuildContext context) {
    return POSummarySection(controller: controller);
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
                onPressed: () => controller.saveOrder(),
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
                        "Save Order",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
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
    if (picked != null) date.value = picked;
  }

  Future<void> _selectDateNullable(
    BuildContext context,
    Rxn<DateTime> date,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) date.value = picked;
  }

  void _showAddTermDialog(BuildContext context) {
    final textController = TextEditingController();
    final isDefault = false.obs;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: context.appColors.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.paddingL,
                        vertical: Sizes.paddingM,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: context.appColors.border),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: context.appColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  PhosphorIconsLight.fileText,
                                  color: context.appColors.primary,
                                  size: 20,
                                ),
                              ),
                              const Gap(Sizes.paddingM),
                              Text(
                                "Add New Term",
                                style: TextHelper.h6Style(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(PhosphorIconsLight.x),
                            style: IconButton.styleFrom(
                              backgroundColor: context.appColors.background,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Body
                    Padding(
                      padding: const EdgeInsets.all(Sizes.paddingL),
                      child: Column(
                        children: [
                          EditTextField(
                            label: "Term Description",
                            controller: textController,
                            maxLines: 4,
                            hintText: "Enter terms and conditions...",
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                          const Gap(Sizes.paddingM),
                          Obx(
                            () => CheckboxListTile(
                              title: const Text("Set as Default"),
                              subtitle: const Text(
                                "Automatically include in new orders",
                              ),
                              value: isDefault.value,
                              onChanged: (v) => isDefault.value = v ?? false,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: context.appColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Footer
                    Container(
                      padding: const EdgeInsets.all(Sizes.paddingL),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: context.appColors.border),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text("Cancel"),
                            ),
                          ),
                          const Gap(Sizes.paddingM),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await controller.addNewTerm(
                                    textController.text,
                                    isDefault.value,
                                  );
                                  Get.back();
                                }
                              },
                              child: const Text("Save Item"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatAddress(ContactAddress? address) {
    if (address == null) return "Select Address";
    final parts = [
      address.addressLine1,
      address.addressLine2,
      address.city?.name,
      address.state?.name,
      address.pinCode?.toString()
    ].where((e) => e != null && e.toString().isNotEmpty).toList();
    return parts.join(", ");
  }
}
