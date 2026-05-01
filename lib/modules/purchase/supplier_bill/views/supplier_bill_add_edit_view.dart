import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/controllers/supplier_bill_add_edit_controller.dart';
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
import 'package:ai_setu/modules/purchase/supplier_bill/widgets/bill_item_card.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/widgets/bill_summary_section.dart';

class SupplierBillAddEditView extends GetView<SupplierBillAddEditController> {
  const SupplierBillAddEditView({super.key});

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
                  _buildBillInfoSection(context),
                  const Gap(Sizes.paddingM),
                  _buildItemsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildReturnsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildTermsAndNotesSection(context),
                  const Gap(Sizes.paddingM),
                  _buildAdditionalChargesSection(context),
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
                      ? "Edit Supplier Bill"
                      : "Add Supplier Bill",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage supplier invoice and item details",
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

  Widget _buildBillInfoSection(BuildContext context) {
    return EditSection(
      title: "Bill Information",
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
            onTap: () => _selectDate(context, controller.billDate),
            child: IgnorePointer(
              child: EditTextField(
                label: "Bill Date",
                controller: TextEditingController(
                  text: DateFormat(
                    'dd/MM/yyyy',
                  ).format(controller.billDate.value),
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
                  label: "Ref. Bill No",
                  controller: controller.referenceBillNoController,
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "GSTIN",
                  controller: TextEditingController(
                    text: controller.gstIn.value,
                  ),
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
                child: InkWell(
                  onTap: () =>
                      _selectDateNullable(context, controller.shippingDate),
                  child: IgnorePointer(
                    child: EditTextField(
                      label: "Shipping Date",
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
                  label: "Reverse Charge",
                  value: controller.reverseCharge.value,
                  items: const ["No", "Yes"],
                  onChanged: (v) => controller.reverseCharge.value = v,
                ),
              ),
              const Gap(Sizes.paddingM),
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
            ],
          ),
          const Gap(Sizes.paddingM),
          Row(
            children: [
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
          Row(
            children: [
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
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Invoice Amount",
                  controller: controller.invoiceAmountController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildReturnsSection(BuildContext context) {
    return EditSection(
      title: "Return Products",
      icon: PhosphorIconsLight.arrowCounterClockwise,
      isExpanded: false,
      child: Column(
        children: [
          CustomDropdown(
            label: "Search & Add Return Product",
            items: controller.products.map((e) => e.name).toList(),
            onChanged: (v) {
              final product = controller.products.firstWhereOrNull(
                (e) => e.name == v,
              );
              if (product != null) controller.addReturnItem(product);
            },
            searchable: true,
          ),
          const Gap(Sizes.paddingM),
          Obx(() {
            if (controller.returnItems.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.paddingXL,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        PhosphorIconsLight.package,
                        size: 40,
                        color: context.appColors.textSecondary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      const Gap(Sizes.paddingS),
                      Text(
                        "No return items added",
                        style: TextHelper.captionStyle(context),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.returnItems.length,
              itemBuilder: (context, index) {
                final item = controller.returnItems[index];
                return _buildReturnItemCard(context, index, item);
              },
            );
          }),
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
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.additionalCharges.length,
              itemBuilder: (context, index) {
                final item = controller.additionalCharges[index];
                return _buildAdditionalChargeCard(context, index, item);
              },
            );
          }),
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
              if (product != null) controller.addBillItem(product);
            },
            searchable: true,
          ),
        ),
        const Gap(Sizes.paddingM),
        if (controller.billItems.isNotEmpty) ...[
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
                  "Added Items (${controller.billItems.length})",
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
              itemCount: controller.billItems.length,
              itemBuilder: (context, index) {
                final item = controller.billItems[index];
                return BillItemCard(
                  index: index,
                  item: item,
                  controller: controller,
                  onRemove: () => controller.removeBillItem(index),
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
                  Text(
                    "Select a product from the dropdown above to begin",
                    style: TextHelper.captionStyle(context),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return BillSummarySection(controller: controller);
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
              onPressed: () {
                Get.back();
              },
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
                onPressed: () => controller.saveBill(),
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
                        "Save Bill",
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      date.value = picked;
    }
  }

  Future<void> _selectDateNullable(
    BuildContext context,
    Rxn<DateTime> date,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      date.value = picked;
    }
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
                          Text(
                            "Add Terms & Conditions",
                            style: TextHelper.h6Style(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.appColors.textPrimary,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(PhosphorIconsLight.x, size: 20),
                            onPressed: () => Get.back(),
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),

                    // Body
                    Padding(
                      padding: const EdgeInsets.all(Sizes.paddingL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditTextField(
                            label: "Terms & Conditions *",
                            controller: textController,
                            maxLines: 4,
                            hintText:
                                "Enter the specific terms and conditions here...",
                            validator: (v) =>
                                v!.trim().isEmpty ? "Required" : null,
                          ),
                          const Gap(Sizes.paddingL),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.paddingM,
                              vertical: Sizes.paddingS,
                            ),
                            decoration: BoxDecoration(
                              color: context.appColors.surface,
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusM,
                              ),
                              border: Border.all(
                                color: context.appColors.border,
                              ),
                            ),
                            child: Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Set as Default",
                                          style:
                                              TextHelper.bodyMediumStyle(
                                                context,
                                              ).copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text(
                                          "Automatically apply this term to new bills",
                                          style: TextHelper.captionStyle(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: isDefault.value,
                                    onChanged: (v) => isDefault.value = v,
                                    activeThumbColor: context.appColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Footer
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.paddingL,
                        vertical: Sizes.paddingM,
                      ),
                      decoration: BoxDecoration(
                        color: context.appColors.surface,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(Sizes.borderRadiusL),
                        ),
                        border: Border(
                          top: BorderSide(color: context.appColors.border),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: context.appColors.border,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.borderRadiusM,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextHelper.bodyMediumStyle(context)
                                    .copyWith(
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.appColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      Sizes.borderRadiusM,
                                    ),
                                  ),
                                ),
                                onPressed: controller.isAddingTerm.value
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          controller.addNewTerm(
                                            textController.text,
                                            isDefault.value,
                                          );
                                        }
                                      },
                                child: controller.isAddingTerm.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Save Item",
                                        style:
                                            TextHelper.bodyMediumStyle(
                                              context,
                                            ).copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                              ),
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

  Widget _buildAdditionalChargeCard(
    BuildContext context,
    int index,
    AdditionalCharge item,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  label: "Charge Name",
                  value: item.name == "New Charge" ? null : item.name,
                  items: controller.availableAdditionalCharges
                      .map((e) => e.name)
                      .toList(),
                  onChanged: (v) {
                    final charge = controller.availableAdditionalCharges
                        .firstWhereOrNull((c) => c.name == v);
                    controller.updateAdditionalChargeSelection(index, charge);
                  },
                  searchable: true,
                ),
              ),
              IconButton(
                onPressed: () => controller.removeAdditionalCharge(index),
                icon: Icon(
                  PhosphorIconsLight.trash,
                  color: context.appColors.error,
                  size: 18,
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingS),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Amount",
                  controller: TextEditingController(
                    text: item.amount.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateAdditionalChargeAmount(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: CustomDropdown(
                  label: "Tax",
                  value: controller.taxes
                      .firstWhereOrNull((t) => t.id == item.taxId)
                      ?.name,
                  items: controller.taxes.map((e) => e.name).toList(),
                  onChanged: (v) {
                    final tax = controller.taxes.firstWhereOrNull(
                      (t) => t.name == v,
                    );
                    controller.updateAdditionalChargeTax(index, tax);
                  },
                  searchable: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReturnItemCard(
    BuildContext context,
    int index,
    ReturnItem item,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.productName,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.removeReturnItem(index),
                icon: Icon(
                  PhosphorIconsLight.trash,
                  color: context.appColors.error,
                  size: 18,
                ),
              ),
            ],
          ),
          const Divider(),
          const Gap(Sizes.paddingS),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Qty",
                  controller: TextEditingController(text: item.qty.toString()),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateReturnItemQty(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
              const Gap(Sizes.paddingM),
              Expanded(
                child: EditTextField(
                  label: "Cost",
                  controller: TextEditingController(
                    text: item.unitCost.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateReturnItemPrice(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingS),
          Row(
            children: [
              Expanded(
                child: EditTextField(
                  label: "Disc Amt",
                  controller: TextEditingController(
                    text: item.discountAmount.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.updateReturnItemDiscount(
                    index,
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const Gap(Sizes.paddingS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxable: ₹${item.taxable.toStringAsFixed(2)}",
                style: TextHelper.captionStyle(context),
              ),
              Text(
                "Total: ₹${item.total.toStringAsFixed(2)}",
                style: TextHelper.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primary,
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
      address.pinCode?.toString()
    ].where((e) => e != null && e.toString().isNotEmpty).toList();
    return parts.join(", ");
  }
}
