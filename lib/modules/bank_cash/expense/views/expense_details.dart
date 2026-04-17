import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/expense_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseModel expense = Get.arguments;
    final dateStr = DateFormat('dd MMM yyyy').format(expense.fromDate);

    return DetailsView(
      title: 'Expense: ${expense.type.toUpperCase()}',
      subtitle: 'Date: $dateStr',
      heroIcon: PhosphorIconsFill.receipt,
      status: expense.isActive ? 'Active' : 'Inactive',
      statusColor: expense.isActive ? AppColors.success : AppColors.error,
      // backgroundHeroColor: Colors.amber.shade800,
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapExpense(expense);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapExpense(expense);
            await PdfService.generateAndShare(pdfData);
          },
        ),
        if (expense.image != null)
          DetailAction(
            label: 'Receipt Image',
            icon: PhosphorIconsFill.image,
            onTap: () {
              // Show image logic
            },
          ),
      ],
      sections: [
        DetailSection(
          title: 'Expense Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Party/Payee',
                  value: expense.partyId.fullName.isNotEmpty
                      ? expense.partyId.fullName
                      : '-',
                ),
                DetailItem(
                  label: 'Category',
                  value: expense.type.toUpperCase(),
                ),
                DetailItem(
                  label: 'Is Salary',
                  value: expense.isSalary ? 'Yes' : 'No',
                ),
                if (expense.description != null &&
                    expense.description!.isNotEmpty)
                  DetailItem(label: 'Description', value: expense.description!),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Financial Details',
          children: [
            _buildAmountRow(
              'Expense Amount',
              expense.amount.toDouble(),
              context: context,
            ),
            if (expense.incentive != null && expense.incentive! > 0)
              _buildAmountRow(
                'Incentive',
                expense.incentive!.toDouble(),
                context: context,
              ),
            const Divider(height: 32),
            _buildAmountRow(
              'Total Amount',
              (expense.total ?? (expense.amount + (expense.incentive ?? 0)))
                  .toDouble(),
              isTotal: true,
              context: context,
            ),
          ],
        ),
        DetailSection(
          title: 'Timeline',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'From Date',
                  value: DateFormat('dd MMM yyyy').format(expense.fromDate),
                ),
                if (expense.toDate != null)
                  DetailItem(
                    label: 'To Date',
                    value: DateFormat('dd MMM yyyy').format(expense.toDate!),
                  ),
                DetailItem(
                  label: 'Registered By',
                  value: expense.createdBy.fullName,
                ),
                DetailItem(
                  label: 'Log Date',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(expense.createdAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isBold = false,
    Color? color,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? TextHelper.bodyLarge.copyWith(fontWeight: FontWeight.bold)
                : TextHelper.bodyMedium.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: (isTotal || isBold)
                ? TextHelper.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        color ?? (isTotal ? context.appColors.primary : null),
                  )
                : TextHelper.bodyMedium.copyWith(
                    color: color,
                    fontWeight: isBold ? FontWeight.bold : null,
                  ),
          ),
        ],
      ),
    );
  }
}
