import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final BankModel bank = Get.arguments;

    return DetailsView(
      title: bank.name,
      subtitle: 'A/C: ${bank.bankAccountNumber}',
      heroIcon: PhosphorIconsFill.bank,
      status: bank.isActive ? 'Active' : 'Inactive',
      statusColor: bank.isActive ? Colors.green : Colors.grey,
      sections: [
        DetailSection(
          title: 'Account Information',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Holder Name', value: bank.accountHolderName),
                DetailItem(
                  label: 'Account Number',
                  value: bank.bankAccountNumber,
                ),
                DetailItem(label: 'IFSC Code', value: bank.ifscCode),
                DetailItem(label: 'Branch', value: bank.branchName),
                DetailItem(
                  label: 'Swift Code',
                  value: bank.swiftCode.isEmpty ? '-' : bank.swiftCode,
                ),
                DetailItem(
                  label: 'UPI ID',
                  value: bank.upiId.isEmpty ? '-' : bank.upiId,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Financial Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Opening Balance (DR)',
                  value: '₹${bank.openingBalance.debitBalance}',
                  color: Colors.red,
                ),
                DetailItem(
                  label: 'Opening Balance (CR)',
                  value: '₹${bank.openingBalance.creditBalance}',
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Location & Contact',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Address',
                  value: '${bank.addressLine1} ${bank.addressLine2}'.trim(),
                ),
                DetailItem(label: 'City', value: bank.city),
                DetailItem(label: 'State', value: bank.state),
                DetailItem(label: 'Country', value: bank.country),
                DetailItem(label: 'Zip Code', value: bank.zipCode),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'System Information',
          children: [
            DataGrid(
              items: [
                DetailItem(label: 'Created By', value: bank.createdBy.fullName),
                DetailItem(
                  label: 'Created At',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(bank.createdAt),
                ),
                DetailItem(
                  label: 'Last Updated',
                  value: DateFormat(
                    'dd MMM yyyy, hh:mm a',
                  ).format(bank.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
