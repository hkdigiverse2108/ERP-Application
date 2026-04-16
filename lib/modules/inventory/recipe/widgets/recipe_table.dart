import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/recipe_model.dart';
import 'package:ai_setu/modules/inventory/recipe/controllers/recipe_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecipeTable extends StatelessWidget {
  RecipeTable({super.key});
  final controller = RecipeController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.recipes.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) =>
                    controller.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<RecipeModel>(
                isLoading: controller.isLoading.value,
                items: controller.recipes,
                columns: [
                  TableColumn(
                    title: 'Recipe No',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      item.number,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 120,
                    cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.date),
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Recipe Name',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.name,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Type',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.type,
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Final Product',
                    width: 150,
                    cellBuilder: (context, item, index) => Text(
                      item.finalProducts.productId?.name ?? '-',
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Qty Gen.',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.finalProducts.qtyGenerate.toString(),
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.isActive ? 'Active' : 'Inactive',
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        color: item.isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                currentPage: controller.currentPage.value,
                totalPages: controller.totalPages.value,
                totalItems: controller.totalItems.value,
                onRowTap: (item) => Get.toNamed(Routes.recipeDetails, arguments: item),
                pageSize: controller.limit.value,
                onPageChanged: (page) => controller.goToPage(page),
              ),
            ],
          ),
        );
      }),
    );
  }
}
