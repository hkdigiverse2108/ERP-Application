import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/media/media_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MediaPickerController extends GetxController {
  final ApiService _apiService = ApiService.to;

  final RxList<MediaModel> mediaList = <MediaModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isUploading = false.obs;

  // Selection
  final RxList<MediaModel> selectedMedia = <MediaModel>[].obs;
  final bool allowMultiple;

  MediaPickerController({this.allowMultiple = false});

  @override
  void onInit() {
    super.onInit();
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    isLoading.value = true;
    try {
      final response = await _apiService.get(ApiConstants.getImages);
      if (response is ResModel && response.status == 200) {
        final List data = response.data;
        mediaList.assignAll(
          data.map((e) {
            if (e is String) {
              return MediaModel.fromUrl(e);
            }
            return MediaModel.fromMap(e as Map<String, dynamic>);
          }).toList(),
        );
      }
    } catch (e) {
      AppSnackbar.error("Failed to load media: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadMedia(List<File> files) async {
    if (files.isEmpty) return;
    isUploading.value = true;
    try {
      final List<http.MultipartFile> multipartFiles = [];
      for (final file in files) {
        final ext = file.path.split('.').last.toLowerCase();
        multipartFiles.add(
          await http.MultipartFile.fromPath(
            'images',
            file.path,
            contentType: MediaType('image', ext == 'png' ? 'png' : 'jpeg'),
          ),
        );
      }

      final response = await _apiService.postMultipart(
        ApiConstants.upload,
        files: multipartFiles,
      );

      if (response is ResModel && response.status == 200) {
        AppSnackbar.success("Images uploaded successfully");
        fetchMedia(); // Refresh list
      } else {
        AppSnackbar.error(response.message ?? "Upload failed");
      }
    } catch (e) {
      AppSnackbar.error("Upload error: $e");
    } finally {
      isUploading.value = false;
    }
  }

  void toggleSelection(MediaModel media) {
    if (selectedMedia.contains(media)) {
      selectedMedia.remove(media);
    } else {
      if (!allowMultiple) {
        selectedMedia.clear();
      }
      selectedMedia.add(media);
    }
  }

  void clearSelection() {
    selectedMedia.clear();
  }

  Future<void> deleteMedia(MediaModel media) async {
    try {
      final response = await _apiService.delete(
        ApiConstants.deleteUpload,
        body: {"fileUrl": media.url},
      );
      if (response is ResModel && response.status == 200) {
        mediaList.removeWhere((element) => element.url == media.url);
        selectedMedia.removeWhere((element) => element.url == media.url);
        AppSnackbar.success("Media deleted");
      }
    } catch (e) {
      AppSnackbar.error("Delete failed: $e");
    }
  }
}
