import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/inventory/recipe/controllers/recipe_add_edit_controller.dart';
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

class RecipeAddEditView extends GetView<RecipeAddEditController> {
  const RecipeAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuickAction(),
                const Gap(Sizes.paddingS),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.paddingM,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.appColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusL,
                          ),
                        ),
                        child: Icon(
                          controller.isEdit.value
                              ? PhosphorIconsLight.pencilSimple
                              : PhosphorIconsLight.cookingPot,
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
                                  ? "Edit Recipe"
                                  : "Add Recipe",
                              style: TextHelper.h5Style(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.appColors.textPrimary,
                              ),
                            ),
                            Text(
                              "Define ingredients and final products for manufacturing",
                              style: TextHelper.captionStyle(context).copyWith(
                                color: context.appColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(Sizes.paddingS),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // --- GENERAL INFORMATION ---
                      EditSection(
                        title: "General Information",
                        icon: PhosphorIconsLight.info,
                        child: Column(
                          children: [
                            EditTextField(
                              label: "Recipe Name",
                              controller: controller.nameController,
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            controller.recipeDate.value ??
                                            DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        controller.recipeDate.value = date;
                                      }
                                    },
                                    child: IgnorePointer(
                                      child: EditTextField(
                                        label: "Recipe Date",
                                        controller: TextEditingController(
                                          text:
                                              controller.recipeDate.value ==
                                                  null
                                              ? ""
                                              : DateFormat('dd-MM-yyyy').format(
                                                  controller.recipeDate.value!,
                                                ),
                                        ),
                                        suffixIcon: const Icon(
                                          PhosphorIconsLight.calendar,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: CustomDropdown(
                                    label: "Recipe Type",
                                    items: RecipeType.values
                                        .map((e) => e.name.capitalizeFirst!)
                                        .toList(),
                                    value: controller
                                        .recipeType
                                        .value
                                        .name
                                        .capitalizeFirst!,
                                    onChanged: (val) {
                                      controller.recipeType.value = RecipeType
                                          .values
                                          .firstWhere(
                                            (e) =>
                                                e.name.capitalizeFirst == val,
                                          );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // --- FINAL PRODUCT ---
                      EditSection(
                        title: "Final Product (Result)",
                        icon: PhosphorIconsLight.package,
                        child: Column(
                          children: [
                            CustomDropdown(
                              searchable: true,
                              searchHint: "Search Product",
                              label: "Select Final Product",
                              items: controller.products
                                  .map((e) => e.name)
                                  .toList(),
                              value: controller.finalProductName.value.isEmpty
                                  ? null
                                  : controller.finalProductName.value,
                              onChanged: (val) {
                                final p = controller.products.firstWhere(
                                  (e) => e.name == val,
                                );
                                controller.setFinalProduct(p);
                              },
                            ),
                            const Gap(Sizes.defVerticalSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: EditTextField(
                                    label: "Qty to Produce",
                                    controller:
                                        controller.finalProductQtyController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const Gap(Sizes.paddingM),
                                Expanded(
                                  child: EditTextField(
                                    label: "MRP",
                                    controller:
                                        controller.finalProductMrpController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // --- RAW MATERIALS ---
                      EditSection(
                        title: "Raw Materials (Ingredients)",
                        icon: PhosphorIconsLight.listPlus,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown(
                              searchable: true,
                              searchHint: "Search Ingredient",
                              label: "Add Ingredient",
                              items: controller.products
                                  .map((e) => e.name)
                                  .toList(),
                              onChanged: (val) {
                                final p = controller.products.firstWhere(
                                  (e) => e.name == val,
                                );
                                controller.addIngredient(p);
                              },
                            ),
                            const Gap(Sizes.paddingM),
                            if (controller.rawProducts.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(Sizes.paddingM),
                                  child: Text(
                                    "No ingredients added yet",
                                    style: TextHelper.bodySmall.copyWith(
                                      color: context.appColors.textSecondary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.rawProducts.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemBuilder: (context, index) {
                                  final item = controller.rawProducts[index];
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.productName,
                                              style: TextHelper.bodyMedium
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              "MRP: ${item.mrp}",
                                              style: TextHelper.captionStyle(
                                                context,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(Sizes.paddingM),
                                      Expanded(
                                        child: EditTextField(
                                          label: "Qty",
                                          initialValue: item.qty.toString(),
                                          keyboardType: TextInputType.number,
                                          onChanged: (v) => controller
                                              .updateIngredientQty(index, v),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.removeIngredient(index),
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                          ],
                        ),
                      ),

                      const Gap(Sizes.paddingL),

                      // --- SAVE BUTTON ---
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingM,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isSaving.value
                                ? null
                                : () => controller.saveRecipe(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.borderRadiusM,
                                ),
                              ),
                            ),
                            child: controller.isSaving.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    controller.isEdit.value
                                        ? "Update Recipe"
                                        : "Add Recipe",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(Sizes.paddingXL),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
