import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/bank_cash/salary_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SalaryDetails extends StatelessWidget {
  const SalaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final SalaryModel salary = Get.arguments;
    final fromDateStr = DateFormat('dd MMM yyyy').format(salary.fromDate);
    final toDateStr = DateFormat('dd MMM yyyy').format(salary.toDate);

    return DetailsView(
      title: 'Salary: ${salary.partyId?.fullName ?? '-'}',
      subtitle: 'Period: $fromDateStr - $toDateStr',
      heroIcon: PhosphorIconsFill.identificationCard,
      status: salary.isActive ? 'Active' : 'Inactive',
      statusColor: salary.isActive ? AppColors.success : AppColors.error,
      // backgroundHeroColor: Colors.indigo.shade700,
      actions: [
        DetailAction(
          label: 'Print',
          icon: PhosphorIconsFill.printer,
          onTap: () async {
            final pdfData = PdfMappers.mapSalary(salary);
            await PdfService.generateAndPrint(pdfData);
          },
        ),
        DetailAction(
          label: 'Share',
          icon: PhosphorIconsFill.shareNetwork,
          onTap: () async {
            final pdfData = PdfMappers.mapSalary(salary);
            await PdfService.generateAndShare(pdfData);
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Employee Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Employee Name',
                  value: (salary.partyId?.fullName ?? '').isNotEmpty
                      ? salary.partyId!.fullName
                      : '-',
                  icon: PhosphorIconsLight.user,
                ),
                DetailItem(
                  label: 'Payment Period',
                  value: '$fromDateStr to $toDateStr',
                  icon: PhosphorIconsLight.calendar,
                ),
                if (salary.description != null &&
                    salary.description!.isNotEmpty)
                  DetailItem(label: 'Notes', value: salary.description!),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Salary Breakdown',
          children: [
            _buildAmountRow(
              'Basic / Base Salary',
              salary.amount.toDouble(),
              context: context,
            ),
            if (salary.incentive > 0)
              _buildAmountRow(
                'Incentive / Bonus',
                salary.incentive.toDouble(),
                context: context,
              ),
            const Divider(height: 32),
            _buildAmountRow(
              'Net Salary Payable',
              salary.total.toDouble(),
              isTotal: true,
              context: context,
            ),
          ],
        ),
        DetailSection(
          title: 'Administration',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Processed By',
                  value: salary.createdBy?.fullName ?? '-',
                ),
                DetailItem(
                  label: 'Record Date',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(salary.createdAt),
                ),
                DetailItem(
                  label: 'Last Modified',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(salary.updatedAt),
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
