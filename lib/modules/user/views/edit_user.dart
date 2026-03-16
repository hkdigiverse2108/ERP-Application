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
              child: SingleChildScrollView(
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

                          _selectField("Branch"),
                          const Gap(Sizes.defVerticalSpace),

                          _textFormField(
                            "Password",
                            controller.passwordController,
                            obscure: true,
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

                          _selectField("Country"),
                          const Gap(Sizes.defVerticalSpace),

                          _selectField("State"),
                          const Gap(Sizes.defVerticalSpace),

                          _selectField("City"),
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
                          _imagePicker(),
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
      bottomNavigationBar: _buildButton(),
    );
  }

  /// SECTION WRAPPER
  Widget _section(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingM),
      child: BorderContainer(
        padding: const EdgeInsets.all(Sizes.paddingM),
        child: child,
      ),
    );
  }

  /// SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
      child: Text(
        title,
        style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  /// TEXT FIELD
  Widget _textFormField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }

  /// SELECT FIELD
  Widget _selectField(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
        ),
      ),
      items: const [
        DropdownMenuItem(value: "Option1", child: Text("Option 1")),
        DropdownMenuItem(value: "Option2", child: Text("Option 2")),
      ],
      onChanged: (value) {},
    );
  }

  /// IMAGE PICKER
  Widget _imagePicker() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
      ),
      child: IconButton(onPressed: () {}, icon: Icon(PhosphorIconsLight.image)),
    );
  }

  /// BUTTONS
  Widget _buildButton() {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("BACK"),
          ),
          const Gap(Sizes.defHorizontalSpace),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkIconPrimary,
            ),
            onPressed: () {},
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
