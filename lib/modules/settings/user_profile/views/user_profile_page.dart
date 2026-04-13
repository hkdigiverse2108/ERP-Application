import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/modules/settings/user_profile/controllers/user_profile_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserProfilePage extends GetView<UserProfileController> {
  const UserProfilePage({super.key});

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

          final user = controller.user.value;
          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load profile.'),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: controller.fetchUserProfile,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.fetchUserProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuickAction(),

                  // ── HEADER CARD ──
                  _buildHeader(context, user),

                  // ── BASIC DETAILS ──
                  _buildSection(
                    context,
                    title: "Basic Details",
                    icon: PhosphorIconsLight.identificationCard,
                    items: [
                      _InfoData("Full Name", user.fullName),
                      _InfoData("Designation", user.designation),
                      _InfoData(
                        "Phone No",
                        "${user.phoneNo.countryCode} ${user.phoneNo.phoneNo}",
                      ),
                      _InfoData("PAN Number", user.panNumber),
                      _InfoData("Role", user.role?.name),
                      _InfoData("Branch", user.branchId?.name),
                    ],
                  ),

                  // ── ADDRESS DETAILS ──
                  _buildSection(
                    context,
                    title: "Address Details",
                    icon: PhosphorIconsLight.mapPin,
                    items: [
                      _InfoData("Address", user.address.address),
                      _InfoData("City", user.address.city),
                      _InfoData("State", user.address.state),
                      _InfoData("Country", user.address.country),
                      _InfoData(
                        "Pin Code",
                        user.address.pinCode == 0
                            ? null
                            : user.address.pinCode.toString(),
                      ),
                    ],
                  ),

                  // ── BANK DETAILS ──
                  _buildSection(
                    context,
                    title: "Bank Details",
                    icon: PhosphorIconsLight.bank,
                    items: [
                      _InfoData("Bank Name", user.bankDetails?.name),
                      _InfoData("Bank IFSC", user.bankDetails?.ifscCode),
                      _InfoData("Branch Name", user.bankDetails?.branchName),
                      _InfoData(
                        "Account Holder Name",
                        user.bankDetails?.bankHolderName,
                      ),
                      _InfoData("Account No", user.bankDetails?.accountNumber),
                      _InfoData("Swift Code", user.bankDetails?.swiftCode),
                    ],
                  ),

                  // ── SALARY DETAILS ──
                  _buildSection(
                    context,
                    title: "Salary Details",
                    icon: PhosphorIconsLight.money,
                    items: [
                      _InfoData("Wages", user.wages?.toString()),
                      _InfoData("Extra Wages", user.extraWages?.toString()),
                      _InfoData("Commission", user.commission?.toString()),
                      _InfoData("Target", user.target?.toString()),
                    ],
                  ),

                  const Gap(Sizes.paddingM),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── HEADER CARD ──
  Widget _buildHeader(BuildContext context, UserModel user) {
    final progress = controller.completionPercentage / 100;

    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingM),
      child: BorderContainer(
        padding: const EdgeInsets.all(Sizes.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar (no ring — cleaner)
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(
                    user.fullName.substring(0, 1).toUpperCase(),
                    style: TextHelper.h3.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(Sizes.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: TextHelper.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          const Icon(
                            PhosphorIconsLight.phone,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const Gap(4),
                          Text(
                            "${user.phoneNo.countryCode} ${user.phoneNo.phoneNo}",
                            style: TextHelper.bodySmall.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Gap(2),
                      Row(
                        children: [
                          const Icon(
                            PhosphorIconsLight.envelope,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const Gap(4),
                          Expanded(
                            child: Text(
                              user.email,
                              style: TextHelper.bodySmall.copyWith(
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton.outlined(
                  onPressed: controller.goToEdit,
                  icon: const Icon(PhosphorIconsLight.notePencil, size: 18),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ],
            ),

            // ── PROGRESS BAR (replaces circle progress) ──
            const Gap(Sizes.paddingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile completeness",
                  style: TextHelper.bodySmall.copyWith(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextHelper.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Gap(6),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: Colors.grey.withValues(alpha: 0.12),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── SECTION with grid-style cells ──
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
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
}

// Helper class to pass label+value pairs
class _InfoData {
  final String label;
  final String? value;
  const _InfoData(this.label, this.value);
}
