import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/pos/sales_register_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SalesRegisterDetails extends StatelessWidget {
  const SalesRegisterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesRegisterModel register = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(register.createdAt);

    return DetailsView(
      title: 'Sales Register #${register.registerNo ?? 'N/A'}',
      subtitle: 'Session: $dateStr',
      heroIcon: PhosphorIconsFill.cashRegister,
      status: register.status,
      statusColor: register.status.toLowerCase() == 'open'
          ? Colors.green
          : Colors.grey,
      actions: [
        DetailAction(
          label: 'Print Summary',
          icon: PhosphorIconsFill.printer,
          onTap: () {},
        ),
      ],
      sections: [
        DetailSection(
          title: 'Session Overview',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Sales Man',
                  value: register.salesManId?.fullName ?? '-',
                ),
                DetailItem(
                  label: 'Opening Cash',
                  value: '₹${register.openingCash.toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Bills Count',
                  value: register.numberOfBills?.toString() ?? '0',
                ),
                DetailItem(
                  label: 'Items Sold',
                  value: register.numberOfItems?.toString() ?? '0',
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Financial Summary',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Total Sales',
                  value: '₹${register.totalSales.toStringAsFixed(2)}',
                  color: Colors.green,
                ),
                DetailItem(
                  label: 'Tax Amount',
                  value: '₹${(register.taxAmount ?? 0).toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Total Discount',
                  value: '₹${(register.totalDiscount ?? 0).toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Sales Return',
                  value: '₹${register.salesReturn.toStringAsFixed(2)}',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Payment Breakdown',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Cash Payment',
                  value: '₹${register.cashPayment.toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Card Payment',
                  value: '₹${register.cardPayment.toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Bank Payment',
                  value: '₹${register.bankPayment.toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'UPI Payment',
                  value: '₹${register.upiPayment.toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Cheque Payment',
                  value: '₹${register.chequePayment.toStringAsFixed(2)}',
                ),
                DetailItem(
                  label: 'Wallet Payment',
                  value: '₹${(register.walletPayment ?? 0).toStringAsFixed(2)}',
                ),
              ],
            ),
          ],
        ),
        if (register.denominations.isNotEmpty)
          DetailSection(
            title: 'Denominations',
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 40,
                  columns: const [
                    DataColumn(label: Text('Currency')),
                    DataColumn(label: Text('Count')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: register.denominations.map((d) {
                    return DataRow(
                      cells: [
                        DataCell(Text('₹${d.currency}')),
                        DataCell(Text(d.count.toString())),
                        DataCell(Text('₹${d.amount.toStringAsFixed(2)}')),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        DetailSection(
          title: 'System Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Created By',
                  value: register.createdBy.fullName,
                ),
                DetailItem(
                  label: 'Opened At',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(register.createdAt),
                ),
                DetailItem(
                  label: 'Last Updated',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(register.updatedAt),
                ),
              ],
            ),
          ],
        ),
        if (register.closingNote != null && register.closingNote!.isNotEmpty)
          DetailSection(
            title: 'Closing Note',
            children: [
              Text(
                register.closingNote!,
                style: TextHelper.bodyMediumStyle(context),
              ),
            ],
          ),
      ],
    );
  }
}
