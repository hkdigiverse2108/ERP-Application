import 'dart:io';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/user/controllers/user_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditUser extends GetView<UserController> {
  EditUser({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: DefAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QuickAction(),
            Form(
              key: formKey,
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
                    _section(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Basic Details"),
                          const Divider(),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Full Name",
                            controller.fullNameController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "User Name",
                            controller.userNameController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "User Description",
                            controller.userDescriptionController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("Role", controller.roleController),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Phone No.",
                            controller.phoneController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("Email", controller.emailController),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("PAN No.", controller.panController),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("Branch", controller.branchController),
                          const Gap(Sizes.defVerticalSpace),

                          Obx(
                            () => _textFormField(
                              "Password",
                              controller.passwordController,
                              obscure: !controller.isPasswordVisible.value,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? PhosphorIconsLight.eye
                                      : PhosphorIconsLight.eyeSlash,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// ADDRESS DETAILS
                    _section(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Address Details"),
                          const Divider(),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Address",
                            controller.addressController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Country",
                            controller.countryController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("State", controller.stateController),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("City", controller.cityController),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Pin Code",
                            controller.zipCodeController,
                          ),
                        ],
                      ),
                    ),

                    /// BANK DETAILS
                    _section(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Bank Details"),
                          const Divider(),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Bank Name",
                            controller.bankNameController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Account Number",
                            controller.accountNumberController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "IFSC Code",
                            controller.ifscCodeController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("Branch", controller.branchController),
                        ],
                      ),
                    ),

                    /// SALARY DETAILS
                    _section(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Salary Details"),
                          const Divider(),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("Wages", controller.wagesController),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Commission",
                            controller.commissionController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Extra Wages",
                            controller.extraWagesController,
                          ),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField("Target", controller.targetController),
                        ],
                      ),
                    ),

                    /// IMAGE
                    _section(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Image"),
                          const Divider(),
                          const Gap(Sizes.defVerticalSpace),
                          _imagePicker(context),
                        ],
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
    );
  }

  /// SECTION WRAPPER
  Widget _section(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingS,
      ),
      child: BorderContainer(
        padding: const EdgeInsets.all(Sizes.paddingM),
        child: child,
      ),
    );
  }

  /// SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
    );
  }

  /// TEXT FIELD
  Widget _textFormField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextHelper.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
        labelStyle: TextHelper.bodySmall,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  /// IMAGE PICKER
  Widget _imagePicker(BuildContext context) {
    return Obx(() {
      final image = controller.selectedImage.value;
      return Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: controller.pickImageFromGallery,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                  ),
                  child: image == null
                      ? Icon(
                          PhosphorIconsLight.plus,
                          size: 32,
                          color: Colors.grey,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                          child: GetPlatform.isWeb
                              ? Image.network(image.path, fit: BoxFit.cover)
                              : Image.file(File(image.path), fit: BoxFit.cover),
                        ),
                ),
              ),
              const Gap(Sizes.defHorizontalSpace),
              if (image != null)
                IconButton(
                  onPressed: controller.removeImage,
                  icon: Icon(PhosphorIconsLight.trash, color: Colors.red),
                ),
            ],
          ),
          const Gap(Sizes.paddingS),
          Text(
            image == null ? "Tap to select an image" : "Tap to change image",
            style: TextHelper.bodySmall,
          ),
        ],
      );
    });
  }

  /// BUTTONS
  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text("SAVE CHANGES"),
            ),
          ),
        ],
      ),
    );
  }
}
