import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/modules/support/controllers/support_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TalkToExpertDialog extends StatelessWidget {
  const TalkToExpertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SupportController.instance;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.paddingXL),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Talk To Our Expert",
                        style: TextHelper.h2Style(
                          context,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                Text(
                  "Fill In Your Info - We'll Reach Out Shortly",
                  style: TextHelper.bodyMediumStyle(
                    context,
                  ).copyWith(color: Colors.grey),
                ),
                const Gap(Sizes.paddingXL),

                // Business Name
                _buildTextField(
                  context: context,
                  label: "Business Name *",
                  controller: controller.businessNameController,
                  validator: (value) =>
                      value!.trim().isEmpty ? "Required" : null,
                ),
                const Gap(Sizes.paddingM),

                // Contact Name
                _buildTextField(
                  context: context,
                  label: "Contact Name *",
                  controller: controller.contactNameController,
                  validator: (value) =>
                      value!.trim().isEmpty ? "Required" : null,
                ),
                const Gap(Sizes.paddingM),

                // Phone Number with Country Code
                _buildPhoneField(context, controller),
                const Gap(Sizes.paddingM),

                // Notes
                _buildTextField(
                  context: context,
                  label: "Notes",
                  controller: controller.notesController,
                  maxLines: 3,
                ),
                const Gap(Sizes.paddingXL),

                // Send Button
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.submitCallRequest(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A65FF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusL,
                          ),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "SEND",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : Colors.black12,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          borderSide: const BorderSide(color: Color(0xFF4A65FF), width: 2),
        ),
        filled: true,
        fillColor: isDark ? Colors.black12 : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context, SupportController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller.phoneController,
      validator: (value) => value!.trim().isEmpty ? "Required" : null,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone No. *",
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
          fontSize: 14,
        ),
        prefixIcon: InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              countryListTheme: CountryListThemeData(
                backgroundColor: isDark
                    ? const Color(0xFF1E1E2C)
                    : Colors.white,
                textStyle: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                bottomSheetHeight: 500,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              onSelect: (Country country) {
                controller.updateCountryCode(country.phoneCode);
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  // We don't have the flag emoji without mapping phoneCode back to country,
                  // so we'll just show the +Code. The package `country_picker` can return flag,
                  // but we only stored phoneCode. Let's show +Code.
                  return Text(
                    "+${controller.countryCode.value}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  );
                }),
                const Icon(Icons.arrow_drop_down),
                Container(
                  width: 1,
                  height: 24,
                  color: isDark ? Colors.white24 : Colors.black12,
                  margin: const EdgeInsets.only(left: 8),
                ),
              ],
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : Colors.black12,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          borderSide: const BorderSide(color: Color(0xFF4A65FF), width: 2),
        ),
        filled: true,
        fillColor: isDark ? Colors.black12 : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
