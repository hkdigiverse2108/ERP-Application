import 'dart:io';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/media/media_model.dart';
import 'package:ai_setu/shared/widgets/media_picker/controllers/media_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MediaPickerDialog extends StatelessWidget {
  final bool allowMultiple;
  final Function(List<MediaModel>) onMediaSelected;

  const MediaPickerDialog({
    super.key,
    this.allowMultiple = false,
    required this.onMediaSelected,
  });

  static Future<void> show({
    bool allowMultiple = false,
    required Function(List<MediaModel>) onMediaSelected,
  }) async {
    await Get.dialog(
      MediaPickerDialog(
        allowMultiple: allowMultiple,
        onMediaSelected: onMediaSelected,
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      MediaPickerController(allowMultiple: allowMultiple),
    );

    return Dialog(
      backgroundColor: context.appColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: DefaultTabController(
        length: 2,
        child: Container(
          width: 800,
          height:
              MediaQuery.of(context).size.height *
              0.8, // Set a fixed height relative to screen
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              _buildHeader(context, controller),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _buildTabBar(context),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildSelectFileTab(context, controller),
                              _buildUploadNewTab(context, controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => controller.isUploading.value
                          ? Positioned.fill(
                              child: Container(
                                color: context.appColors.surface.withValues(
                                  alpha: 0.8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const Gap(Sizes.paddingL),
                                    Text(
                                      "Uploading your media...",
                                      style: TextHelper.bodyBoldStyle(context),
                                    ),
                                    const Gap(Sizes.paddingS),
                                    Text(
                                      "Please wait while we process the files.",
                                      style: TextHelper.bodySmallStyle(context),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              _buildFooter(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MediaPickerController controller) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: Sizes.paddingS,
              runSpacing: 4,
              children: [
                Text(
                  "Media Library",
                  style: TextHelper.h4Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.fetchMedia(),
                  icon: Icon(
                    PhosphorIconsLight.arrowsClockwise,
                    size: 20,
                    color: context.appColors.textPrimary,
                  ),
                  tooltip: "Refresh",
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                if (allowMultiple)
                  Obx(
                    () => controller.selectedMedia.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: context.appColors.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusS,
                              ),
                            ),
                            child: Text(
                              "${controller.selectedMedia.length} Selected",
                              style: TextStyle(
                                color: context.appColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
          const Gap(Sizes.paddingM),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              PhosphorIconsLight.x,
              size: 24,
              color: context.appColors.textPrimary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.appColors.textSecondary.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: TabBar(
        isScrollable: true,
        dividerColor: Colors.transparent,
        labelColor: context.appColors.primary,
        unselectedLabelColor: context.appColors.textSecondary,
        indicatorColor: context.appColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: context.appColors.textPrimary,
        ),
        tabs: const [
          Tab(text: "Select File"),
          Tab(text: "Upload New"),
        ],
      ),
    );
  }

  Widget _buildSelectFileTab(
    BuildContext context,
    MediaPickerController controller,
  ) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.mediaList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIconsLight.imageSquare,
                size: 64,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
              const Gap(Sizes.paddingM),
              Text(
                "No images found",
                style: TextHelper.bodyMediumStyle(
                  context,
                ).copyWith(color: context.appColors.textSecondary),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(Sizes.paddingL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Sizes.paddingM,
          mainAxisSpacing: Sizes.paddingM,
          childAspectRatio: 1,
        ),
        itemCount: controller.mediaList.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final media = controller.mediaList[index];
            final isSelected = controller.selectedMedia.contains(media);

            return GestureDetector(
              onTap: () => controller.toggleSelection(media),
              child: AnimatedScale(
                scale: isSelected ? 0.92 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                    border: Border.all(
                      color: isSelected
                          ? context.appColors.primary
                          : context.appColors.textSecondary.withValues(
                              alpha: 0.2,
                            ),
                      width: isSelected ? 2.5 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: context.appColors.primary.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 12,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadiusM - 1,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              media.url,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: context.appColors.background,
                                    child: Icon(
                                      PhosphorIconsLight.warning,
                                      color: context.appColors.textSecondary,
                                    ),
                                  ),
                            ),
                            if (isSelected)
                              Container(
                                color: context.appColors.primary.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Gradient Overlay for better icon visibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Sizes.borderRadiusM - 1,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.1),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.2),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: context.appColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.appColors.surface,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: context.appColors.surface,
                              size: 14,
                            ),
                          ),
                        ),
                      // Delete Button
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () async {
                            Get.dialog(
                              Dialog(
                                backgroundColor: context.appColors.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.borderRadiusL,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Sizes.paddingL),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(
                                          Sizes.paddingM,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          PhosphorIconsFill.trash,
                                          color: Colors.red,
                                          size: 32,
                                        ),
                                      ),
                                      const Gap(Sizes.paddingL),
                                      Text(
                                        "Delete this media?",
                                        style: TextHelper.h4Style(context)
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  context.appColors.textPrimary,
                                            ),
                                      ),
                                      const Gap(Sizes.paddingS),
                                      Text(
                                        "This action cannot be undone. The image will be permanently removed from the server.",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextHelper.bodySmallStyle(
                                              context,
                                            ).copyWith(
                                              color: context
                                                  .appColors
                                                  .textSecondary,
                                            ),
                                      ),
                                      const Gap(Sizes.paddingL),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () => Get.back(),
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                    ),
                                              ),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: context
                                                      .appColors
                                                      .textSecondary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Gap(Sizes.paddingM),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                controller.deleteMedia(media);
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                elevation: 0,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        Sizes.borderRadiusM,
                                                      ),
                                                ),
                                              ),
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: context.appColors.surface.withValues(
                                alpha: 0.9,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              PhosphorIconsLight.trash,
                              color: Colors.red,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      );
    });
  }

  Widget _buildUploadNewTab(
    BuildContext context,
    MediaPickerController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingL),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  if (allowMultiple) {
                    final images = await picker.pickMultiImage();
                    if (images.isNotEmpty) {
                      controller.uploadMedia(
                        images.map((e) => File(e.path)).toList(),
                      );
                    }
                  } else {
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      controller.uploadMedia([File(image.path)]);
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  decoration: BoxDecoration(
                    color: context.appColors.primary.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                    border: Border.all(
                      color: context.appColors.primary.withValues(alpha: 0.3),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: context.appColors.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.appColors.textPrimary.withValues(
                                alpha: 0.05,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          PhosphorIconsFill.cloudArrowUp,
                          size: 48,
                          color: context.appColors.primary,
                        ),
                      ),
                      const Gap(Sizes.paddingL),
                      Text(
                        "Click to Upload Media",
                        style: TextHelper.h4Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.appColors.textPrimary,
                        ),
                      ),
                      const Gap(Sizes.paddingS),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.paddingXL,
                        ),
                        child: Text(
                          "We are uploading the image to our server and selecting which image to use.",
                          textAlign: TextAlign.center,
                          style: TextHelper.bodySmallStyle(context).copyWith(
                            color: context.appColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, MediaPickerController controller) {
    return Container(
      padding: const EdgeInsets.all(Sizes.paddingL),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.appColors.textSecondary.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => controller.clearSelection(),
            child: Text(
              "CLEAR",
              style: TextStyle(
                color: context.appColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.selectedMedia.isEmpty
                  ? null
                  : () {
                      onMediaSelected(controller.selectedMedia);
                      Get.back();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.selectedMedia.isEmpty
                    ? context.appColors.background
                    : context.appColors.primary,
                foregroundColor: controller.selectedMedia.isEmpty
                    ? context.appColors.textSecondary
                    : Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                elevation: 0,
              ),
              child: Text(
                allowMultiple ? "INSERT MEDIA" : "SAVE",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
