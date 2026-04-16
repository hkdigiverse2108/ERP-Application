import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/invetory/recipe_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeModel recipe = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(recipe.date);

    return DetailsView(
      title: recipe.name,
      subtitle: 'Recipe #${recipe.number} | Date: $dateStr',
      heroIcon: PhosphorIconsFill.cookingPot,
      status: recipe.isActive ? 'Active' : 'Inactive',
      statusColor: recipe.isActive ? Colors.green : Colors.grey,
      actions: [
        DetailAction(
          label: 'Print Recipe',
          icon: PhosphorIconsFill.printer,
          onTap: () {},
        ),
      ],
      sections: [
        DetailSection(
          title: 'Final Product Output',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Output Product',
                  value: recipe.finalProducts.productId?.name ?? '-',
                ),
                DetailItem(
                  label: 'Qty Generated',
                  value: '${recipe.finalProducts.qtyGenerate}',
                ),
                DetailItem(
                  label: 'MRP',
                  value: '₹${recipe.finalProducts.mrp.toStringAsFixed(2)}',
                ),
                DetailItem(label: 'Recipe Type', value: recipe.type),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Ingredients / Raw Materials',
          children: [
            ...recipe.rawProducts.map((item) => _buildRawProductCard(item, context)),
          ],
        ),
        DetailSection(
          title: 'System Information',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Created By', value: recipe.createdBy.fullName),
                DetailItem(
                  label: 'Created At',
                  value: DateFormat('dd MMM yyyy, hh:mm a').format(recipe.createdAt),
                ),
                DetailItem(
                  label: 'Last Updated',
                  value: DateFormat('dd MMM yyyy, hh:mm a').format(recipe.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRawProductCard(RawProduct item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productId?.name ?? '-',
                  style: TextHelper.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'MRP: ₹${item.mrp.toStringAsFixed(2)}',
                  style: TextHelper.bodySmall.copyWith(color: context.appColors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Qty Used',
                style: TextHelper.captionStyle(context),
              ),
              Text(
                '${item.useQty}',
                style: TextHelper.h4Style(context).copyWith(color: context.appColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
