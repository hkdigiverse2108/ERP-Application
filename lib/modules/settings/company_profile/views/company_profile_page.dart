import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/company_model.dart';
import 'package:ai_setu/modules/settings/company_profile/controllers/company_profile_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CompanyProfilePage extends GetView<CompanyProfileController> {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final company = controller.company.value;
          if (company == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load company profile.'),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: controller.fetchCompanyProfile,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.fetchCompanyProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuickAction(),
                  const Gap(16),

                  // ── BASIC DETAILS ──
                  _buildSection(
                    context,
                    title: "Basic Details",
                    icon: PhosphorIconsLight.info,
                    trailing: _buildEditButton(),
                    items: [
                      _InfoData("Accounting Type", company.accountingType),
                      _InfoData("Name", company.name),
                      _InfoData("Display Name", company.displayName),
                      _InfoData("Contact Name", company.contactName),
                      _InfoData("Owner No", company.ownerNo.toString()),
                      _InfoData("Support Email", company.supportEmail),
                      _InfoData("Email", company.email),
                      _InfoData("Phone No", company.phoneNo.toString()),
                      _InfoData(
                        "Customer Care No.",
                        company.customerCareNumber,
                      ),
                      _InfoData("Web Site", company.webSite),
                      _InfoData("Time Zone", company.timeZone),
                    ],
                  ),

                  // ── COMMUNICATION DETAILS ──
                  _buildSection(
                    context,
                    title: "Communication Details",
                    icon: PhosphorIconsLight.mapPin,
                    items: [
                      _InfoData("Address", company.address.address),
                      _InfoData("City", company.address.city.name),
                      _InfoData("State", company.address.state.name),
                      _InfoData("Country", company.address.country.name),
                      _InfoData(
                        "Pin Code",
                        company.address.pinCode?.toString(),
                      ),
                    ],
                  ),

                  // ── BANK DETAILS ──
                  _buildSection(
                    context,
                    title: "Bank Details",
                    icon: PhosphorIconsLight.bank,
                    items: [
                      _InfoData("Bank Name", company.bankId?.name),
                      _InfoData("Bank IFSC", company.bankId?.ifscCode),
                      _InfoData("UPI", company.bankId?.upiId),
                      _InfoData("Branch Name", company.bankId?.branchName),
                      _InfoData(
                        "Account Holder Name",
                        company.bankId?.accountHolderName,
                      ),
                      _InfoData(
                        "Bank Account No.",
                        company.bankId?.bankAccountNumber,
                      ),
                    ],
                  ),

                  // ── REGISTRATION & ADDITIONAL ──
                  _buildSection(
                    context,
                    title: "Additional Details",
                    icon: PhosphorIconsLight.plusCircle,
                    items: [
                      _InfoData("User Name", company.userName),
                      _InfoData("PAN No.", company.panNo),
                      _InfoData(
                        "GST Registration",
                        company.gstRegistrationType,
                      ),
                      _InfoData("GSTIN", company.gstIdentificationNumber),
                      _InfoData(
                        "Financial Month Interval",
                        company.financialMonthInterval,
                      ),
                      _InfoData(
                        "Default Financial Year",
                        company.defaultFinancialYear ?? company.financialYear,
                      ),
                    ],
                  ),

                  // ── OTHER DETAILS ──
                  _buildSection(
                    context,
                    title: "Other Details",
                    icon: PhosphorIconsLight.dotsThreeCircle,
                    items: [
                      _InfoData(
                        "CIN No.",
                        company.corporateIdentificationNumber,
                      ),
                      _InfoData("LUT No.", company.letterOfUndertaking),
                      _InfoData(
                        "TAN No.",
                        company.taxDeductionAndCollectionAccountNumber,
                      ),
                      _InfoData("IEC No.", company.importerExporterCode),
                      _InfoData("Outlet Size", company.outletSize),
                      _InfoData("Decimal Point", company.decimalPoint),
                      _InfoData("Print Date Format", company.printDateFormat),
                    ],
                  ),

                  // ── LOGO SECTION ──
                  _buildLogoSection(context, company),

                  // ── SWITCHES ──
                  _buildSettingsSwitches(context, company),

                  const Gap(Sizes.paddingL),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEditButton() {
    return TextButton.icon(
      onPressed: controller.goToEdit,
      icon: const Icon(PhosphorIconsLight.notePencil, size: 18),
      label: const Text("Edit"),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? trailing,
    required List<_InfoData> items,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Sizes.paddingM,
        0,
        Sizes.paddingM,
        Sizes.paddingM,
      ),
      child: BorderContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, size: 15, color: AppColors.primary),
                      ),
                      const Gap(Sizes.paddingS),
                      Text(
                        title,
                        style: TextHelper.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  ?trailing,
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),

            // Grid of cells
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.4,
              ),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final isLastRow = i >= items.length - 2;
                final isRightColumn = i.isOdd;
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: isLastRow
                          ? BorderSide.none
                          : BorderSide(color: Colors.grey.shade200, width: 0.5),
                      right: isRightColumn
                          ? BorderSide.none
                          : BorderSide(color: Colors.grey.shade200, width: 0.5),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: _buildInfoCell(items[i].label, items[i].value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBaseSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Sizes.paddingM,
        0,
        Sizes.paddingM,
        Sizes.paddingM,
      ),
      child: BorderContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 15, color: AppColors.primary),
                  ),
                  const Gap(Sizes.paddingS),
                  Text(
                    title,
                    style: TextHelper.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),
            Padding(padding: const EdgeInsets.all(14), child: child),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCell(String label, String? value) {
    final isEmpty = value == null || value.isEmpty || value == '-';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: TextHelper.bodySmall.copyWith(
            color: Colors.grey,
            fontSize: 10,
            letterSpacing: 0.4,
          ),
        ),
        const Gap(3),
        Text(
          isEmpty ? 'Not provided' : value,
          style: isEmpty
              ? TextHelper.bodySmall.copyWith(
                  color: Colors.grey.shade400,
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                )
              : TextHelper.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildLogoSection(BuildContext context, CompanyModel company) {
    return _buildBaseSection(
      context,
      title: "Logo & Branding",
      icon: PhosphorIconsLight.image,
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            _buildLogoItem("Logo", company.logo),
            _buildLogoItem("Watermark", company.waterMark),
            _buildLogoItem("Report Logo", company.reportFormatLogo ?? ''),
            _buildLogoItem("Signature", company.authorizedSignature ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoItem(String label, String url) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: url.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.network(
                          url,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Icon(
                            PhosphorIconsLight.image,
                            size: 32,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      )
                    : Icon(
                        PhosphorIconsLight.image,
                        size: 32,
                        color: Colors.grey.shade300,
                      ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIconsLight.magnifyingGlassPlus,
                    size: 12,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextHelper.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSwitches(BuildContext context, CompanyModel company) {
    return _buildBaseSection(
      context,
      title: "System Settings",
      icon: PhosphorIconsLight.gear,
      child: Column(
        children: [
          _buildSettingTile(
            "Allow RoundOff",
            "Automatically round off totals in invoices",
            company.allowRoundOff == "true",
            PhosphorIconsLight.coins,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            "Enable Feedback Module",
            "Allow customers to provide feedback on orders",
            company.enableFeedbackModule == "true",
            PhosphorIconsLight.chatCircleDots,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    bool value,
    IconData icon,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: TextHelper.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: TextHelper.bodySmall.copyWith(fontSize: 11),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: (v) {},
        activeTrackColor: AppColors.primary,
      ),
    );
  }
}

// Helper class to pass label+value pairs
class _InfoData {
  final String label;
  final String? value;
  const _InfoData(this.label, this.value);
}
