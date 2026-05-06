import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/invetory/stock_transfer_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StockTransferDetailsView extends StatelessWidget {
  const StockTransferDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final StockTransferModel transfer = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(transfer.createdAt);

    return DetailsView(
      title: 'Stock Transfer #${transfer.transferNo}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.package,
      status: transfer.status,
      statusColor: _getStatusColor(transfer.status),
      sections: [
        DetailSection(
          title: 'Transfer Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'From Branch',
                  value: transfer.requestedByBranchId?.name ?? '-',
                ),
                DetailItem(
                  label: 'To Branch',
                  value: transfer.requestedToBranchId?.name ?? '-',
                ),
                DetailItem(
                  label: 'Requested By',
                  value: transfer.createdBy?.fullName ?? '-',
                ),
                DetailItem(label: 'Type', value: transfer.type),
                if (transfer.approvedBy != null)
                  DetailItem(
                    label: 'Approved By',
                    value: transfer.approvedBy?.fullName ?? '-',
                  ),
                if (transfer.approvedAt != null)
                  DetailItem(
                    label: 'Approved At',
                    value: DateFormat(
                      'dd MMM yyyy HH:mm',
                    ).format(transfer.approvedAt!),
                  ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Items',
          children: [_buildItemsTable(context, transfer.items)],
        ),
        if (transfer.requestNote.isNotEmpty)
          DetailSection(
            title: 'Request Note',
            children: [
              Text(
                transfer.requestNote,
                style: TextHelper.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        if (transfer.approvalNote.isNotEmpty)
          DetailSection(
            title: 'Approval Note',
            children: [
              Text(
                transfer.approvalNote,
                style: TextHelper.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Widget _buildItemsTable(BuildContext context, List<StockTransferItem> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        horizontalMargin: 0,
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('Product')),
          DataColumn(label: Text('Req Qty'), numeric: true),
          DataColumn(label: Text('Appr Qty'), numeric: true),
          DataColumn(label: Text('Recv Qty'), numeric: true),
          DataColumn(label: Text('Price'), numeric: true),
        ],
        rows: items.map((item) {
          return DataRow(
            cells: [
              DataCell(
                Text(item.productId?.name ?? '-', style: TextHelper.bodySmall),
              ),
              DataCell(
                Text('${item.requestedQty}', style: TextHelper.bodySmall),
              ),
              DataCell(
                Text('${item.approvedQty}', style: TextHelper.bodySmall),
              ),
              DataCell(
                Text('${item.receivedQty}', style: TextHelper.bodySmall),
              ),
              DataCell(Text('₹${item.price}', style: TextHelper.bodySmall)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
