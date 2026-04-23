import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/announcement/announcement_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class AnnouncementRepository {
  final ApiService _api = ApiService.to;

  Future<AnnouncementDataModel> getAnnouncements({String? branchId}) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllAnnouncement(branchId: branchId),
    );

    if (res.status == 200 && res.data != null) {
      return AnnouncementDataModel.fromJson(res.data);
    }

    throw Exception(res.message ?? 'Failed to fetch announcements');
  }
}
