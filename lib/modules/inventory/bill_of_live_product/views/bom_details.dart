import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BOMDetails extends StatelessWidget {
  const BOMDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final BillOfLiveProductModel bom = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(bom.date);

    return DetailsView(
      title: 'BOM #${bom.number}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.blueprint,
      status: bom.isActive ? 'Active' : 'Inactive',
      statusColor: bom.isActive ? AppColors.success : AppColors.error,
      // backgroundHeroColor: Colors.teal.shade700,
      actions: [
        DetailAction(
          label: 'Print BOM',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapBOM(bom);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapBOM(bom);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        DetailAction(
          label: 'Export CSV',
          icon: PhosphorIconsFill.fileCsv,
          onTap: () {},
        ),
      ],
      sections: [
        DetailSection(
          title: 'General Information',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'BOM Number', value: bom.number),
                DetailItem(label: 'Date', value: dateStr),
                DetailItem(
                  label: 'Reverse Calc',
                  value: bom.allowReverseCalculation ? 'Enabled' : 'Disabled',
                ),
                DetailItem(label: 'Created By', value: bom.createdBy.fullName),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Manufactured Products & Ingredients',
          children: [
            ...bom.productDetails.map(
              (product) => _buildProductIngredientCard(product, context),
            ),
          ],
        ),
        DetailSection(
          title: 'Audit Info',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Created At',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(bom.createdAt),
                ),
                DetailItem(
                  label: 'Last Updated',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(bom.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductIngredientCard(
    ProductDetail product,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.appColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Product Name and Qty
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productId.name,
                        style: TextHelper.h4Style(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Yield Qty: ${product.qty}',
                        style: TextHelper.bodySmall.copyWith(
                          color: AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                PhosphorIcon(
                  PhosphorIconsFill.package,
                  color: context.appColors.primary,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Ingredients List
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMPONENTS / INGREDIENTS',
                  style: TextHelper.captionStyle(context).copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                ...product.ingredients.map(
                  (ing) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            ing.productId.name,
                            style: TextHelper.bodyMedium,
                          ),
                        ),
                        Text(
                          ing.useQty.toString(),
                          style: TextHelper.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.appColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
