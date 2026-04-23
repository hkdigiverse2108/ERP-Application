import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/announcement/controllers/announcement_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      appBar: AppBar(
        title: const Text(
          "Announcements",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: context.appColors.surface,
        foregroundColor: context.appColors.textPrimary,
        elevation: 0.5,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.announcements.isEmpty) {
          return Center(child: CircularProgressIndicator(color: context.appColors.primary));
        }

        if (controller.announcements.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(PhosphorIconsFill.megaphone, size: 64, color: context.appColors.textSecondary.withValues(alpha: 0.3)),
                const Gap(16),
                Text(
                  "No announcements yet",
                  style: TextStyle(color: context.appColors.textSecondary, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchAnnouncements(),
          color: context.appColors.primary,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.announcements.length,
            separatorBuilder: (context, index) => const Gap(16),
            itemBuilder: (context, index) {
              final announcement = controller.announcements[index];
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: Get.isDarkMode ? 0.2 : 0.04),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Vertical Primary Accent Bar
                      Container(
                        width: 6,
                        color: context.appColors.primary,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: context.appColors.primary.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      PhosphorIconsFill.megaphone,
                                      size: 16,
                                      color: context.appColors.primary,
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    "ANNOUNCEMENT",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.2,
                                      color: context.appColors.primary.withValues(alpha: 0.6),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(announcement.createdAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.appColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(16),
                              Text(
                                announcement.desc.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ' '),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: context.appColors.textPrimary,
                                  height: 1.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Gap(20),
                              Divider(height: 1, color: context.appColors.border.withValues(alpha: 0.5)),
                              const Gap(16),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: context.appColors.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      PhosphorIconsFill.user,
                                      size: 14,
                                      color: context.appColors.primary,
                                    ),
                                  ),
                                  const Gap(10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        announcement.createdBy?.fullName ?? "System",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: context.appColors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        announcement.createdBy?.userType ?? "Administrator",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: context.appColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
