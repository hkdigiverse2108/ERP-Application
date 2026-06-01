import 'package:flutter/material.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/pos/cash_control_model.dart';
import 'package:intl/intl.dart';

class CashControlCard extends StatelessWidget {
  final CashControlModel data;

  const CashControlCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.appColors.border),
      ),
      color: context.appColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹ ${data.amount.toStringAsFixed(2)}",
                  style: TextHelper.h4Style(
                    context,
                  ).copyWith(color: context.appColors.success),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.appColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    data.type.toUpperCase(),
                    style: TextHelper.captionStyle(context).copyWith(
                      color: context.appColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (data.remark.isNotEmpty)
              Text(data.remark, style: TextHelper.bodyMediumStyle(context)),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Created At", style: TextHelper.captionStyle(context)),
                    Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(data.createdAt),
                      style: TextHelper.bodySmallStyle(context),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Register", style: TextHelper.captionStyle(context)),
                    Text(
                      data.registerId?.registerNo ?? "N/A",
                      style: TextHelper.bodySmallStyle(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
