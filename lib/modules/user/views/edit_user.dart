import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/user/controllers/update_user_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/edit_section.dart';
import 'package:ai_setu/shared/widgets/images/edit_image_picker.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditUser extends GetView<UpdateUserController> {
  const EditUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              QuickAction(),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingS,
                        ),
                        child: Text(
                          "Edit User",
                          style: TextHelper.h2Style(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Divider(),

                      /// BASIC DETAILS
                      EditSection(
                        title: "Basic Details",
                        icon: PhosphorIconsLight.identificationCard,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextField(
                              label: "Full Name",
                              controller: controller.fullNameController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "User Name",
                              controller: controller.userNameController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "User Description",
                              controller: controller.userDescriptionController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            Obx(
                              () => CustomDropdown(
                                label: "Role",
                                items: controller.roleList
                                    .map((e) => e.name)
                                    .toList(),
                                value: controller.roleName.value.isEmpty
                                    ? null
                                    : controller.roleName.value,
                                onChanged: (value) =>
                                    controller.onRoleChanged(value),
                              ),
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: EditTextField(
                                    label: "Code",
                                    controller: controller.countryCodeController,
                                    keyboardType: TextInputType.phone,
                                    readOnly: true,
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode: true,
                                        countryListTheme: CountryListThemeData(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.borderRadiusL,
                                          ),
                                          inputDecoration: InputDecoration(
                                            labelText: "Search",
                                            prefixIcon: const Icon(
                                              Icons.search,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    Sizes.borderRadiusM,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        onSelect: (Country country) {
                                          controller
                                                  .countryCodeController
                                                  .text =
                                              "+${country.phoneCode}";
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const Gap(Sizes.defHorizontalSpace),
                                Expanded(
                                  child: EditTextField(
                                    label: "Phone No.",
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Email",
                              controller: controller.emailController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "PAN No.",
                              controller: controller.panController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Branch",
                              controller: controller.branchController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            Obx(
                              () => EditTextField(
                                label: "Password",
                                controller: controller.passwordController,
                                obscureText: !controller.isPasswordVisible.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? PhosphorIconsLight.eye
                                        : PhosphorIconsLight.eyeSlash,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ADDRESS DETAILS
                      EditSection(
                        title: "Address Details",
                        icon: PhosphorIconsLight.mapPin,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextField(
                              label: "Address",
                              controller: controller.addressController,
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
                                onChanged: (value) =>
                                    controller.onCountryChanged(value),
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
                                onChanged: (value) =>
                                    controller.onStateChanged(value),
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
                                onChanged: (value) =>
                                    controller.onCityChanged(value),
                              ),
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Pin Code",
                              controller: controller.zipCodeController,
                            ),
                          ],
                        ),
                      ),

                      /// BANK DETAILS
                      EditSection(
                        title: "Bank Details",
                        icon: PhosphorIconsLight.bank,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextField(
                              label: "Bank Name",
                              controller: controller.bankNameController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Account Number",
                              controller: controller.accountNumberController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "IFSC Code",
                              controller: controller.ifscCodeController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Branch",
                              controller: controller.branchController,
                            ),
                          ],
                        ),
                      ),

                      /// SALARY DETAILS
                      EditSection(
                        title: "Salary Details",
                        icon: PhosphorIconsLight.money,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextField(
                              label: "Wages",
                              controller: controller.wagesController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Commission",
                              controller: controller.commissionController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Extra Wages",
                              controller: controller.extraWagesController,
                            ),
                            const Gap(Sizes.defVerticalSpace),

                            EditTextField(
                              label: "Target",
                              controller: controller.targetController,
                            ),
                          ],
                        ),
                      ),

                      /// IMAGE
                      EditSection(
                        title: "Image",
                        icon: PhosphorIconsLight.image,
                        child: Obx(
                          () => EditImagePicker(
                            imagePath: controller.selectedImage.value?.path,
                            onPickImage: controller.pickImageFromGallery,
                            onRemoveImage: controller.removeImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildButton(context),
      ),
    );
  }


  /// BUTTONS
  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
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
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
              ),
              onPressed: () => Get.back(),
              child: const Text("CANCEL"),
            ),
          ),
          const Gap(Sizes.defHorizontalSpace),
          Expanded(
            child: Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                  elevation: 0,
                ),
                onPressed: controller.isUpdating.value
                    ? null
                    : controller.updateUser,
                child: controller.isUpdating.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("SAVE CHANGES"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
