import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/images/image_viewer_page.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductItemModel product = Get.arguments;

    return DetailsView(
      title: product.name,
      subtitle: product.printName,
      heroIcon: PhosphorIconsFill.package,
      status: '${product.qty}',
      statusColor: product.qty > 10 ? Colors.green : Colors.red,
      // actions: [
      // DetailAction(
      //   label: 'Edit',
      //   icon: PhosphorIconsFill.pencilSimple,
      //   onTap: () => Get.toNamed(Routes.addUpdateProduct, arguments: product),
      // ),
      // DetailAction(
      //   label: 'Stock History',
      //   icon: PhosphorIconsFill.chartBar,
      //   onTap: () {
      //     // Navigate to stock report
      //   },
      // ),
      //   DetailAction(
      //     label: 'Clone',
      //     icon: PhosphorIconsFill.copy,
      //     onTap: () {
      //       // Clone product logic
      //     },
      //   ),
      //   DetailAction(
      //     label: 'Delete',
      //     icon: PhosphorIconsFill.trash,
      //     color: AppColors.error,
      //     onTap: () {
      //       // Show delete confirmation
      //     },
      //   ),
      // ],
      sections: [
        DetailSection(
          title: 'General Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Category',
                  value: product.categoryId?.name ?? '-',
                  icon: PhosphorIconsLight.tag,
                ),
                DetailItem(
                  label: 'Brand',
                  value: product.brandId?.name ?? '-',
                  icon: PhosphorIconsLight.copyright,
                ),
                DetailItem(
                  label: 'Product ID',
                  value: product.id.length > 8
                      ? product.id.substring(0, 8)
                      : product.id,
                  isCopyable: true,
                  icon: PhosphorIconsLight.hash,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Pricing & Taxes',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Purchase Price',
                  value: '₹${product.purchasePrice}',
                  icon: PhosphorIconsLight.truck,
                ),
                DetailItem(
                  label: 'MRP',
                  value: '₹${product.mrp}',
                  icon: PhosphorIconsLight.ticket,
                ),
                DetailItem(
                  label: 'Selling Price',
                  value: '₹${product.sellingPrice}',
                  icon: PhosphorIconsLight.tagChevron,
                ),
                DetailItem(
                  label: 'Purchase Tax',
                  value: product.purchaseTaxId?.name ?? '-',
                  icon: PhosphorIconsLight.receipt,
                ),
                DetailItem(
                  label: 'Sales Tax',
                  value: product.salesTaxId?.name ?? '-',
                  icon: PhosphorIconsLight.receipt,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Inventory Status',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Current Quantity',
                  value: '${product.qty}',
                  icon: PhosphorIconsLight.stack,
                ),
                DetailItem(
                  label: 'Created By',
                  value: product.createdBy?.fullName ?? 'N/A',
                  icon: PhosphorIconsLight.user,
                ),
              ],
            ),
          ],
        ),
        if (product.images.isNotEmpty)
          DetailSection(
            title: 'Product Images',
            children: [
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.images.length,
                  separatorBuilder: (context, index) =>
                      const Gap(Sizes.paddingM),
                  itemBuilder: (context, index) {
                    final imageUrl = product.images[index];
                    return GestureDetector(
                      onTap: () => Get.to(
                        () => ImageViewerPage(
                          imageUrl: imageUrl,
                          title: product.name,
                        ),
                      ),
                      child: Hero(
                        tag: imageUrl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                          child: Image.network(
                            imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 120,
                                  height: 120,
                                  color: context.appColors.background,
                                  child: Icon(
                                    PhosphorIconsLight.warning,
                                    color: context.appColors.textSecondary,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
