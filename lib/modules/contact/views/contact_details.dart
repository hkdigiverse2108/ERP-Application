import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactModel contact = Get.arguments;

    return DetailsView(
      title: '${contact.firstName} ${contact.lastName}',
      subtitle: contact.companyName ?? 'Individual',
      heroIcon: PhosphorIconsFill.userCircle,
      status: contact.isActive ? 'Active' : 'Inactive',
      statusColor: contact.isActive ? AppColors.success : AppColors.error,
      actions: [
        DetailAction(
          label: 'Edit',
          icon: PhosphorIconsFill.pencilSimple,
          onTap: () => Get.toNamed(Routes.contact, arguments: contact),
        ),
        DetailAction(
          label: 'Call',
          icon: PhosphorIconsFill.phone,
          onTap: () {
            // Initiate call
          },
        ),
        DetailAction(
          label: 'WhatsApp',
          icon: PhosphorIconsFill.whatsappLogo,
          color: Colors.green,
          onTap: () {
            // Initiate WhatsApp
          },
        ),
        DetailAction(
          label: 'Ledger',
          icon: PhosphorIconsFill.article,
          onTap: () {
            // View ledger
          },
        ),
      ],
      sections: [
        DetailSection(
          title: 'Communication',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Phone',
                  value: '+${contact.phoneNo?.countryCode} ${contact.phoneNo?.phoneNo}',
                  icon: PhosphorIconsLight.phone,
                  isCopyable: true,
                ),
                DetailItem(
                  label: 'WhatsApp',
                  value: '+${contact.whatsappNo?.countryCode} ${contact.whatsappNo?.phoneNo}',
                  icon: PhosphorIconsLight.whatsappLogo,
                ),
                DetailItem(
                  label: 'Email',
                  value: contact.email ?? '-',
                  icon: PhosphorIconsLight.envelopeSimple,
                  isCopyable: true,
                ),
                DetailItem(
                  label: 'Telephone',
                  value: contact.telephoneNo ?? '-',
                  icon: PhosphorIconsLight.phoneCall,
                ),
              ],
            ),
          ],
        ),
        DetailSection(
          title: 'Business Information',
          children: [
            DataGrid(
              items: [
                DetailItem(
                  label: 'Contact Type',
                  value: contact.contactType.toUpperCase(),
                  icon: PhosphorIconsLight.identificationBadge,
                ),
                DetailItem(
                  label: 'PAN No',
                  value: contact.panNo ?? '-',
                  isCopyable: true,
                  icon: PhosphorIconsLight.cardholder,
                ),
                DetailItem(
                  label: 'Loyalty Points',
                  value: '${contact.loyaltyPoints}',
                  icon: PhosphorIconsLight.star,
                ),
                DetailItem(
                  label: 'Payment Mode',
                  value: contact.paymentMode ?? '-',
                  icon: PhosphorIconsLight.creditCard,
                ),
                DetailItem(
                  label: 'Payment Terms',
                  value: contact.paymentTerms ?? '-',
                  icon: PhosphorIconsLight.calendarCheck,
                ),
                DetailItem(
                  label: 'Opening Balance',
                  value:
                      'Dr: ${contact.openingBalance?.debitBalance} | Cr: ${contact.openingBalance?.creditBalance}',
                  icon: PhosphorIconsLight.wallet,
                ),
              ],
            ),
          ],
        ),
        if (contact.address.isNotEmpty)
          DetailSection(
            title: 'Addresses',
            children: contact.address.map((addr) => _buildAddressItem(addr)).toList(),
          ),
        if (contact.bankDetails != null)
          DetailSection(
            title: 'Bank Details',
            children: [
              DataGrid(
                items: [
                  DetailItem(
                    label: 'Bank Name',
                    value: contact.bankDetails?.name ?? '-',
                    icon: PhosphorIconsLight.bank,
                  ),
                  DetailItem(
                    label: 'Account No',
                    value: contact.bankDetails?.accountNumber ?? '-',
                    isCopyable: true,
                    icon: PhosphorIconsLight.fileText,
                  ),
                  DetailItem(
                    label: 'IFSC Code',
                    value: contact.bankDetails?.ifscCode ?? '-',
                    isCopyable: true,
                    icon: PhosphorIconsLight.barcode,
                  ),
                  DetailItem(
                    label: 'Branch',
                    value: contact.bankDetails?.branch ?? '-',
                    icon: PhosphorIconsLight.mapPinLine,
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildAddressItem(Address addr) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${addr.addressLine1}${addr.addressLine2 != null ? ', ${addr.addressLine2}' : ''}',
            style: TextHelper.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            '${addr.city?.name}, ${addr.state?.name}, ${addr.country?.name} - ${addr.pinCode}',
            style: TextHelper.bodySmall.copyWith(color: AppColors.lightTextSecondary),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}
