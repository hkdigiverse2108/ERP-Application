import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/modules/inventory/product/controllers/product_controller.dart';
import 'package:ai_setu/shared/widgets/buttons/smoll_section_button.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProductTable extends StatelessWidget {
  ProductTable({super.key});
  final controller = ProductController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLodding.value && controller.products.isEmpty) {
          return const TableShimmer();
        }
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SectionButton(
                    onTap: () {},
                    label: 'Import',
                    icon: PhosphorIconsLight.fileArchive,
                  ),
                  const Gap(8),
                  SectionButton(
                    onTap: () => Get.toNamed(Routes.addItem),
                    label: 'Add Item',
                  ),
                  const Gap(8),
                  SectionButton(onTap: () {}, label: 'Remove Item'),
                ],
              ),
              Gap(Sizes.defHorizontalSpace),
              RangedDatePicker(
                initialDateRange: controller.selectedDateRange.value,
                onChanged: (range) =>
                    controller.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              Obx(
                () => CommonTable<ProductItemModel>(
                  isLoading: controller.isLodding.value,
                  items: controller.products,
                  onEditItem: (item) =>
                      Get.toNamed(Routes.addUpdateProduct, arguments: item),
                  columns: [
                    TableColumn(
                      title: 'Name',
                      width: 100,
                      cellBuilder: (context, item, index) => Text(
                        item.name,
                        style: TextHelper.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TableColumn(
                      title: 'Print Name',
                      width: 120,
                      cellBuilder: (context, item, index) =>
                          Text(item.printName, style: TextHelper.bodySmall),
                    ),
                    TableColumn(
                      title: 'Category',
                      width: 80,
                      cellBuilder: (context, item, index) => Text(
                        item.categoryId?.name ?? '-',
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Brand',
                      width: 80,
                      cellBuilder: (context, item, index) => Text(
                        item.brandId?.name ?? '-',
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Purchase Tax',
                      width: 100,
                      alignment: TextAlign.right,
                      cellBuilder: (context, item, index) => Text(
                        item.purchaseTaxId?.name ?? '-',
                        textAlign: TextAlign.right,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Sales Tax',
                      width: 100,
                      alignment: TextAlign.right,
                      cellBuilder: (context, item, index) => Text(
                        item.salesTaxId?.name ?? '-',
                        textAlign: TextAlign.right,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Purchase Price',
                      width: 100,
                      alignment: TextAlign.right,
                      cellBuilder: (context, item, index) => Text(
                        '₹${item.purchasePrice}',
                        textAlign: TextAlign.right,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'MRP',
                      width: 100,
                      alignment: TextAlign.right,
                      cellBuilder: (context, item, index) => Text(
                        '₹${item.mrp}',
                        textAlign: TextAlign.right,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Selling Price',
                      width: 100,
                      alignment: TextAlign.right,
                      cellBuilder: (context, item, index) => Text(
                        '₹${item.sellingPrice}',
                        textAlign: TextAlign.right,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Qty',
                      width: 80,
                      alignment: TextAlign.center,
                      cellBuilder: (context, item, index) => Text(
                        item.qty.toString(),
                        textAlign: TextAlign.center,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                    TableColumn(
                      title: 'Created By',
                      width: 120,
                      alignment: TextAlign.center,
                      cellBuilder: (context, item, index) => Text(
                        (item.createdBy.userType == UserType.superAdmin)
                            ? "system generated"
                            : item.createdBy.fullName,
                        textAlign: TextAlign.center,
                        style: TextHelper.bodySmall,
                      ),
                    ),
                  ],
                  currentPage: controller.currentPage.value,
                  totalPages: controller.totalPages.value,
                  totalItems: controller.totalItems.value,
                  onPageChanged: (page) => controller.goToPage(page),
                  pageSize: controller.limit.value,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
