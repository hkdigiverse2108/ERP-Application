import 'dart:io';
import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/settings/controllers/settings_controller.dart';
import 'package:ai_setu/modules/support/views/dialogs/talk_to_expert_dialog.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ai_setu/data/model/settings_model.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        "Error",
        "Could not launch $url",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(launchUri)) {
      Get.snackbar(
        "Error",
        "Could not make call to $phoneNumber",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    if (!await launchUrl(launchUri)) {
      Get.snackbar(
        "Error",
        "Could not send email to $email",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _openMap(String address) async {
    final String query = Uri.encodeComponent(address);
    final String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$query";
    final Uri uri = Uri.parse(googleUrl);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        "Error",
        "Could not open maps for $address",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      int hour = int.parse(parts[0]);
      final minute = parts[1];
      final period = hour >= 12 ? 'PM' : 'AM';

      if (hour > 12) {
        hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }

      return '$hour:$minute $period';
    } catch (e) {
      return time;
    }
  }

  IconData _getSocialIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'instagram':
        return PhosphorIconsFill.instagramLogo;
      case 'facebook':
        return PhosphorIconsFill.facebookLogo;
      case 'youtube':
        return PhosphorIconsFill.youtubeLogo;
      case 'twitter':
      case 'x':
        return PhosphorIconsFill.xLogo;
      case 'linkedin':
        return PhosphorIconsFill.linkedinLogo;
      default:
        return PhosphorIconsFill.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService().isDarkMode;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.responsive(
          light: AppColors.lightBackground,
          dark: AppColors.darkBackground,
        ),
        appBar: DefAppBar(),
        drawer: AppDrawer(),
        body: Obx(() {
          final settings = SettingsController.instance.settings.value;
          if (settings == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            // physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Premium Header ──────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildHeader(context, isDark)),

              // ── Contact & Info Section ─────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.paddingL,
                  vertical: Sizes.paddingXL,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSectionTitle(context, "Service Availability"),
                    const Gap(Sizes.paddingL),
                    _buildAvailabilityCard(context, settings.workingHours),

                    const Gap(Sizes.paddingXL * 1.5),

                    _buildSectionTitle(context, "Get in Touch"),
                    const Gap(Sizes.paddingL),

                    _buildContactCard(
                      context,
                      icon: PhosphorIconsFill.headset,
                      title: "Talk To Our Expert",
                      value: "Request a Callback",
                      color: const Color(0xFF9C27B0),
                      onTap: () => Get.dialog(const TalkToExpertDialog()),
                    ),
                    const Gap(Sizes.paddingM),

                    _buildContactCard(
                      context,
                      icon: PhosphorIconsFill.phoneCall,
                      title: "Phone Support",
                      value: settings.phoneNo.toString(),
                      color: const Color(0xFF007AFF),
                      onTap: () => _makePhoneCall(settings.phoneNo.toString()),
                    ),
                    const Gap(Sizes.paddingM),
                    _buildContactCard(
                      context,
                      icon: PhosphorIconsFill.envelopeSimpleOpen,
                      title: "Email Support",
                      value: settings.email,
                      color: const Color(0xFFFF2D55),
                      onTap: () => _sendEmail(settings.email),
                    ),
                    const Gap(Sizes.paddingM),
                    _buildContactCard(
                      context,
                      icon: PhosphorIconsFill.mapPinLine,
                      title: "Office Address",
                      value: settings.address,
                      color: const Color(0xFF34C759),
                      onTap: () => _openMap(settings.address),
                    ),

                    const Gap(Sizes.paddingXL * 1.5),

                    _buildSectionTitle(context, "Connect with us"),
                    const Gap(Sizes.paddingL),
                    _buildSocialSection(context, settings.links),

                    const Gap(Sizes.paddingXL * 3),
                  ]),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        Sizes.paddingL,
        40,
        Sizes.paddingL,
        60,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF161950), const Color(0xFF0A0C2A)]
              : [const Color(0xFFE3F2FD), const Color(0xFFFFFFFF)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Sizes.borderRadiusXL * 2.5),
          bottomRight: Radius.circular(Sizes.borderRadiusXL * 2.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Illustration with Glow
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? Colors.blue : Colors.white).withValues(
                    alpha: 0.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Image.file(
                  File(
                    "C:/Users/VI/.gemini/antigravity/brain/a0a5fe67-da61-4a45-8287-3f80ea62ad04/support_illustration_1776835235903.png",
                  ),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    PhosphorIconsFill.headset,
                    size: 80,
                    color: isDark ? Colors.white70 : context.appColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingL),
          Text(
            "How can we help?",
            textAlign: TextAlign.center,
            style: TextHelper.h1Style(context).copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 32,
              letterSpacing: -1,
              color: isDark ? Colors.white : context.appColors.primary,
            ),
          ),
          const Gap(Sizes.paddingS),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingXL),
            child: Text(
              "Experience world-class support. We are here to ensure your journey is seamless.",
              textAlign: TextAlign.center,
              style: TextHelper.bodyMediumStyle(context).copyWith(
                color: isDark ? Colors.white60 : Colors.blueGrey,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: context.appColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(12),
        Text(
          title,
          style: TextHelper.h3Style(
            context,
          ).copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
        ),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = ThemeService().isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Sizes.paddingM),
        decoration: BoxDecoration(
          color: isDark ? context.appColors.surface : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
          border: Border.all(
            color: context.appColors.border.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Gap(Sizes.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextHelper.bodySmallStyle(context).copyWith(
                      color: context.appColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    value,
                    style: TextHelper.bodyLargeStyle(context).copyWith(
                      fontWeight: FontWeight.w800,
                      color: context.appColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIconsBold.caretRight,
              size: 18,
              color: context.appColors.textSecondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityCard(BuildContext context, WorkingHours hours) {
    final isDark = ThemeService().isDarkMode;

    return Container(
      padding: const EdgeInsets.all(Sizes.paddingL),
      decoration: BoxDecoration(
        color: context.appColors.primary.withValues(alpha: isDark ? 0.2 : 0.05),
        borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
        border: Border.all(
          color: context.appColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                PhosphorIconsFill.clock,
                color: context.appColors.primary,
                size: 24,
              ),
              const Gap(12),
              Text(
                "Working Hours",
                style: TextHelper.bodyLargeStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    const Text(
                      "Live",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(Sizes.paddingL),
          _buildInfoRow(
            context,
            "Mon - Sat",
            "${_formatTime(hours.startTime)} to ${_formatTime(hours.endTime)}",
          ),
          const Divider(height: 32),
          _buildInfoRow(context, "Timezone", hours.timezone),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextHelper.bodyMediumStyle(
            context,
          ).copyWith(color: context.appColors.textSecondary),
        ),
        Text(
          value,
          style: TextHelper.bodyMediumStyle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSection(BuildContext context, List<SettingsLink> links) {
    final activeLinks = links.where((l) => l.isActive).toList();

    return Wrap(
      spacing: Sizes.paddingM,
      runSpacing: Sizes.paddingM,
      children: activeLinks.map((link) {
        return _buildSocialTile(context, link);
      }).toList(),
    );
  }

  Widget _buildSocialTile(BuildContext context, SettingsLink link) {
    return InkWell(
      onTap: () => _launchUrl(link.link),
      borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          border: Border.all(
            color: context.appColors.border.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getSocialIcon(link.icon),
              size: 20,
              color: context.appColors.primary,
            ),
            const Gap(10),
            Text(
              link.title,
              style: TextHelper.bodyMediumStyle(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
