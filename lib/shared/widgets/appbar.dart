import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/constants/images.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/settings/user_profile/controllers/user_profile_controller.dart';
import 'package:ai_setu/shared/widgets/financial_year_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ai_setu/shared/widgets/branch_dropdown.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/modules/announcement/controllers/announcement_controller.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DefAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.appColors.primary,
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: Image.asset(Images.lightAisetuLogo, height: 32, width: 96),
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Get.currentRoute != Routes.support) {
                  Get.toNamed(Routes.support);
                }
              },
              child: const Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 22,
              ),
            ),
            const Gap(4),

            // ── Theme toggle with circular-reveal animation ────────────────
            // const ThemeToggleButton(),
            Obx(() {
              final controller = Get.find<AnnouncementController>();
              return IconButton(
                onPressed: () => Get.toNamed(Routes.announcement),
                icon: Badge(
                  label: Text(controller.announcementCount.value.toString()),
                  isLabelVisible: controller.announcementCount.value > 0,
                  backgroundColor: Colors.red,
                  child: const Icon(
                    PhosphorIconsFill.bell,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              );
            }),
            const Gap(4),
            Obx(() {
              final profileController = Get.find<UserProfileController>();
              final user = profileController.user.value;
              final profileImage = user?.profileImage;

              return GestureDetector(
                onTap: () {
                  if (Get.currentRoute != Routes.settingsUserProfile) {
                    Get.toNamed(Routes.settingsUserProfile);
                  }
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      profileImage != null && profileImage.isNotEmpty
                      ? NetworkImage(
                          profileImage.startsWith('http')
                              ? profileImage
                              : '${ApiConstants.baseUrl}/$profileImage',
                        )
                      : null,
                  child: profileImage == null || profileImage.isEmpty
                      ? Icon(
                          PhosphorIconsBold.user,
                          color: context.appColors.primary,
                          size: 20,
                        )
                      : null,
                ),
              );
            }),
            const Gap(10),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.05),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(
            Sizes.paddingL,
            Sizes.paddingS,
            Sizes.paddingL,
            Sizes.paddingS,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: FinancialYearDropdown()),
              Obx(() {
                final branchController = Get.find<BranchController>();
                if (branchController.isMainBranch) {
                  return const Expanded(
                    child: Row(
                      children: [
                        Gap(Sizes.paddingS),
                        Expanded(child: BranchDropdown()),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 44);
}
