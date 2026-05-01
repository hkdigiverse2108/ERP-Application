import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  final String? title;

  const ImageViewerPage({super.key, required this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(PhosphorIconsLight.arrowLeft, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title ?? "Image Preview",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              PhosphorIconsLight.shareNetwork,
              color: Colors.white,
            ),
            onPressed: () async {
              if (imageUrl.startsWith('http')) {
                await SharePlus.instance.share(
                  ShareParams(text: imageUrl, subject: title ?? "Shared Image"),
                );
              } else {
                await SharePlus.instance.share(
                  ShareParams(
                    files: [XFile(imageUrl)],
                    text: title ?? "Shared Image",
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 5.0,
            child: Hero(
              tag: imageUrl,
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIconsLight.warning,
                                color: Colors.white,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Failed to load image",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                    )
                  : Image.file(
                      File(imageUrl),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
