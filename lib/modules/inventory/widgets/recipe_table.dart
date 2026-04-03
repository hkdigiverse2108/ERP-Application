import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/recipe_model.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class RecipeTable extends StatelessWidget {
  RecipeTable({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: homeController.selectedDateRange.value,
                onChanged: (range) =>
                    homeController.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<RecipeModel>(
                items: [
                  RecipeModel(
                    recipeNo: '1',
                    recipeName: 'Recipe 1',
                    recipeDate: '2022-01-01',
                    recipeType: 'Type 1',
                    recipeStatus: 'Active',
                  ),
                  RecipeModel(
                    recipeNo: '2',
                    recipeName: 'Recipe 2',
                    recipeDate: '2022-01-02',
                    recipeType: 'Type 2',
                    recipeStatus: 'Inactive',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'Recipe No',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.recipeNo ?? 'N/A',
                          style: TextHelper.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  TableColumn(
                    title: 'Recipe Name',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.recipeName ?? 'N/A',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Recipe Date',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.recipeDate ?? 'N/A',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Recipe Type',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.recipeType ?? 'N/A',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Recipe Status',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.recipeStatus ?? 'N/A',
                      textAlign: TextAlign.right,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                currentPage: homeController.currentPage.value,
                totalPages: 5,
                totalItems: 43,
                onPageChanged: (page) =>
                    homeController.currentPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
