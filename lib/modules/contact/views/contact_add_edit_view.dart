import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/modules/contact/controllers/contact_add_edit_controller.dart';
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

class ContactAddEditView extends GetView<ContactAddEditController> {
  const ContactAddEditView({super.key});

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
                  _buildContactTypeSelector(context),
                  const Gap(Sizes.paddingS),
                  _buildGeneralDetailsSection(context),
                  const Gap(Sizes.paddingM),
                  if (controller.contactType.value == ContactType.supplier) ...[
                    _buildBankDetailsSection(context),
                    const Gap(Sizes.paddingM),
                  ],
                  _buildAddressDetailsSection(context),
                  const Gap(Sizes.paddingM),
                  _buildStatusSection(context),
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
                  : PhosphorIconsLight.userPlus,
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
                  controller.isEdit.value ? "Edit Contact" : "Add New Contact",
                  style: TextHelper.h5Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Text(
                  "Manage your customers, suppliers, and transporters",
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

  Widget _buildContactTypeSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: context.appColors.border.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(
            color: context.appColors.border.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: ContactType.values.map((type) {
            final isSelected = controller.contactType.value == type;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.contactType.value = type,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.appColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: context.appColors.primary.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      type.name.capitalizeFirst ?? type.name,
                      style: TextHelper.bodyMediumStyle(context).copyWith(
                        color: isSelected
                            ? Colors.white
                            : context.appColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildGeneralDetailsSection(BuildContext context) {
    return EditSection(
      title: "General Details",
      icon: PhosphorIconsLight.info,
      child: Column(
        children: [
          EditTextField(
            label: "First Name",
            controller: controller.firstNameController,
            hintText: "Enter first name",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Last Name",
            controller: controller.lastNameController,
            hintText: "Enter last name",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Email",
            controller: controller.emailController,
            hintText: "Enter email address",
            keyboardType: TextInputType.emailAddress,
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Company Name",
            controller: controller.companyNameController,
            hintText: "Enter company name",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Phone No.",
            controller: controller.phoneController,
            hintText: "Enter phone number",
            keyboardType: TextInputType.phone,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("+91", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Whatsapp No.",
            controller: controller.whatsappController,
            hintText: "Enter whatsapp number",
            keyboardType: TextInputType.phone,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("+91", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Telephone No",
            controller: controller.telephoneController,
            hintText: "Enter telephone number",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Remarks",
            controller: controller.remarksController,
            hintText: "Enter remarks",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "PAN No",
            controller: controller.panNoController,
            hintText: "Enter PAN number",
          ),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "Payment Mode",
            value: controller.paymentMode.value,
            items: const ["Cash", "Bank", "Cheque", "Online"],
            onChanged: (v) => controller.paymentMode.value = v,
          ),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "Payment Terms",
            value: controller.paymentTerms.value,
            items: const ["Immediate", "Net 15", "Net 30", "Net 45", "Net 60"],
            onChanged: (v) => controller.paymentTerms.value = v,
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Debit Balance",
            controller: controller.debitBalanceController,
            keyboardType: TextInputType.number,
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Credit Balance",
            controller: controller.creditBalanceController,
            keyboardType: TextInputType.number,
          ),
          const Gap(Sizes.paddingM),
          InkWell(
            onTap: () => _selectDate(context, controller.dob),
            child: IgnorePointer(
              child: EditTextField(
                label: "Date Of Birth",
                controller: TextEditingController(
                  text: controller.dob.value != null
                      ? DateFormat('dd/MM/yyyy').format(controller.dob.value!)
                      : "",
                ),
                suffixIcon: const Icon(PhosphorIconsLight.calendar),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          InkWell(
            onTap: () => _selectDate(context, controller.anniversaryDate),
            child: IgnorePointer(
              child: EditTextField(
                label: "Anniversary Date",
                controller: TextEditingController(
                  text: controller.anniversaryDate.value != null
                      ? DateFormat(
                          'dd/MM/yyyy',
                        ).format(controller.anniversaryDate.value!)
                      : "",
                ),
                suffixIcon: const Icon(PhosphorIconsLight.calendar),
              ),
            ),
          ),
          const Gap(Sizes.paddingM),
          if (controller.contactType.value == ContactType.customer) ...[
            CustomDropdown(
              label: "Customer Category",
              value: controller.customerCategory.value,
              items: const ["General", "Premium", "VIP"],
              onChanged: (v) => controller.customerCategory.value = v,
            ),
            const Gap(Sizes.paddingM),
            _buildTypeSelector(context, "Customer Type", [
              "Retailer",
              "Wholesaler",
              "Merchant",
              "Other",
            ], controller.customerType),
          ] else if (controller.contactType.value == ContactType.supplier) ...[
            EditTextField(
              label: "Tan No",
              controller: controller.tanNoController,
              hintText: "Enter TAN number",
            ),
            const Gap(Sizes.paddingM),
            _buildTypeSelector(context, "Supplier Type", [
              "Manufacturer",
              "Stockiest",
              "Trader",
              "Other",
            ], controller.supplierType),
          ] else if (controller.contactType.value ==
              ContactType.transporter) ...[
            EditTextField(
              label: "Transporter Id",
              controller: controller.transporterIdController,
              hintText: "Enter transporter ID",
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypeSelector(
    BuildContext context,
    String label,
    List<String> options,
    Rx<String?> selectedValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label *",
          style: TextHelper.bodySmallStyle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.textSecondary,
          ),
        ),
        const Gap(Sizes.paddingS),
        Wrap(
          spacing: Sizes.paddingS,
          runSpacing: Sizes.paddingS,
          children: options.map((option) {
            final isSelected = selectedValue.value == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (v) => selectedValue.value = v ? option : null,
              selectedColor: context.appColors.primary.withValues(alpha: 0.15),
              checkmarkColor: context.appColors.primary,
              backgroundColor: context.appColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                side: BorderSide(
                  color: isSelected
                      ? context.appColors.primary
                      : context.appColors.border,
                ),
              ),
              labelStyle: TextHelper.bodySmallStyle(context).copyWith(
                color: isSelected
                    ? context.appColors.primary
                    : context.appColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBankDetailsSection(BuildContext context) {
    return EditSection(
      title: "Bank Details",
      icon: PhosphorIconsLight.bank,
      child: Column(
        children: [
          EditTextField(
            label: "Bank IfscCode",
            controller: controller.bankIfscController,
            hintText: "Enter IFSC code",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Bank Name",
            controller: controller.bankNameController,
            hintText: "Enter bank name",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Bank Branch",
            controller: controller.bankBranchController,
            hintText: "Enter bank branch",
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Account Number",
            controller: controller.bankAccountNoController,
            hintText: "Enter account number",
          ),
        ],
      ),
    );
  }

  Widget _buildAddressDetailsSection(BuildContext context) {
    return EditSection(
      title: "Address Details",
      icon: PhosphorIconsLight.mapPin,
      child: Column(
        children: [
          Obx(() {
            return Column(
              children: List.generate(controller.addresses.length, (index) {
                return _buildAddressCard(context, index);
              }),
            );
          }),
          const Gap(Sizes.paddingM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => controller.addAddress(),
              icon: const Icon(PhosphorIconsLight.plus, size: 18),
              label: const Text("ADD NEW ADDRESS"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                side: BorderSide(color: context.appColors.primary),
                foregroundColor: context.appColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, int index) {
    final address = controller.addresses[index];
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingL),
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Address #${index + 1}",
                style: TextHelper.bodyLargeStyle(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              if (controller.addresses.length > 1)
                IconButton(
                  onPressed: () => controller.removeAddress(index),
                  icon: Icon(
                    PhosphorIconsLight.trash,
                    color: context.appColors.error,
                  ),
                ),
            ],
          ),
          const Divider(),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "GST Type",
            value: address.gstType ?? "UnRegistered",
            items: const ["UnRegistered", "Registered", "Composite", "Exempt"],
            onChanged: (v) {
              controller.updateAddress(index, address.copyWith(gstType: v));
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "GSTIN",
            controller: TextEditingController(text: address.gstIn),
            onChanged: (v) {
              controller.updateAddress(index, address.copyWith(gstIn: v));
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Contact First Name",
            controller: TextEditingController(text: address.contactFirstName),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(contactFirstName: v),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Contact Last Name",
            controller: TextEditingController(text: address.contactLastName),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(contactLastName: v),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Company Name",
            controller: TextEditingController(text: address.contactCompanyName),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(contactCompanyName: v),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Phone No.",
            controller: TextEditingController(
              text: address.contactNo?.phoneNo?.toString() ?? "",
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("+91", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(
                  contactNo: ContactPhone(phoneNo: v, countryCode: "91"),
                ),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Email",
            controller: TextEditingController(text: address.contactEmail),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(contactEmail: v),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Address Line 1",
            controller: TextEditingController(text: address.addressLine1),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(addressLine1: v),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Address Line 2",
            controller: TextEditingController(text: address.addressLine2),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(addressLine2: v),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "Country",
            value: address.country?.name,
            items: controller.countries.map((e) => e.name).toList(),
            onChanged: (v) async {
              final country = controller.countries.firstWhereOrNull(
                (e) => e.name == v,
              );
              if (country != null) {
                controller.updateAddress(
                  index,
                  address.copyWith(
                    country: ContactLocation(
                      id: country.id,
                      name: country.name,
                      code: country.code,
                    ),
                  ),
                );
              }
            },
          ),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "State",
            value: address.state?.name,
            items: const ["Gujarat", "Maharashtra", "Rajasthan"], // Demo
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(
                  state: ContactLocation(id: "1", name: v, code: "ST"),
                ),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          CustomDropdown(
            label: "City",
            value: address.city?.name,
            items: const ["Surat", "Ahmedabad", "Mumbai"], // Demo
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(
                  city: ContactLocation(id: "1", name: v, code: "CT"),
                ),
              );
            },
          ),
          const Gap(Sizes.paddingM),
          EditTextField(
            label: "Pin Code",
            controller: TextEditingController(
              text: address.pinCode?.toString() ?? "",
            ),
            onChanged: (v) {
              controller.updateAddress(
                index,
                address.copyWith(pinCode: int.tryParse(v)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Row(
        children: [
          Switch(
            value: controller.isActive.value,
            onChanged: (v) => controller.isActive.value = v,
            activeThumbColor: context.appColors.primary,
          ),
          const Gap(Sizes.paddingS),
          Text(
            "Is Active",
            style: TextHelper.bodyMediumStyle(
              context,
            ).copyWith(fontWeight: FontWeight.bold),
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
                    : () => controller.saveContact(),
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
                        controller.isEdit.value
                            ? "Update Contact"
                            : "Save Contact",
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

  void _selectDate(BuildContext context, Rx<DateTime?> date) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      date.value = picked;
    }
  }
}
