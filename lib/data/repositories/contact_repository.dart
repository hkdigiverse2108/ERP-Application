import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:get/get.dart';

class ContactRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<ContactListModel> getContacts({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final ResModel response = await _apiService.get(
      ApiConstants.buildUrl(ApiConstants.getAllContact, {
        "page": page,
        "limit": limit,
        "search": search,
      }),
    );
    if (response.status == 200 && response.data != null) {
      return ContactListModel.fromJson(response.data);
    }
    throw Exception(response.message ?? 'Failed to load contacts');
  }
}
