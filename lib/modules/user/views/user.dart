import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/user/controllers/user_controller.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class User extends GetView<UserController> {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.paddingM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
              child: Text(
                "Edit User",
                style: TextHelper.h2Style(
                  context,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Divider(),
            _buildSectionTitle('Basic Details'),
            Padding(
              padding: const EdgeInsets.all(Sizes.paddingM),
              child: BorderContainer(
                child: Column(
                  children: [
                    _textFormField("Full Name", controller.nameController),
                    const Gap(Sizes.defVerticalSpace),
                    _textFormField("User Name", controller.emailController),
                    const Gap(Sizes.defVerticalSpace),
                    _textFormField(
                      "User Description",
                      controller.phoneController,
                    ),
                    const Gap(Sizes.defVerticalSpace),
                    _textFormField("Phone No.", controller.addressController),
                    const Gap(Sizes.defVerticalSpace),
                    _textFormField("Email", controller.cityController),
                    const Gap(Sizes.defVerticalSpace),
                    _textFormField("PAN No.", controller.stateController),
                    const Gap(Sizes.defVerticalSpace),
                    _SelectField("Branch", controller.zipCodeController),
                    const Gap(Sizes.defVerticalSpace),
                    _textFormField("Password", controller.countryController),
                    const Gap(Sizes.defVerticalSpace),

                    const Gap(Sizes.defVerticalSpace),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: Obx(
        () => Text(
          title,
          style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _textFormField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _SelectField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
      ),
      child: Row(
        children: [
          Gap(10),
          Text(label),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIconsLight.caretDown),
          ),
        ],
      ),
    );
  }
}
