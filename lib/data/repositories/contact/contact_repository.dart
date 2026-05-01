import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';

import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:get/get.dart';

class ContactRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<PaginationModel<ContactModel>> getContacts({
    int page = 1,
    int limit = 10,
    String? search,
    String? typeFilter,
    String? activeFilter,
  }) async {
    final ResModel response = await _apiService.get(
      ApiConstants.buildUrl(ApiConstants.getAllContact(), {
        "page": page,
        "limit": limit,
        "search": search,
        "typeFilter": typeFilter,
        "activeFilter": activeFilter,
      }),
    );
    if (response.status == 200) {
      final items = (response.data['contact_data'] as List)
          .map((e) => ContactModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(response.data, items);
    }
    throw Exception(response.message ?? 'Failed to load contacts');
  }

  Future<List<ContactDropdownModel>> getContactDropdown({
    String? typeFilter,
    String? activeFilter,
  }) async {
    final ResModel response = await _apiService.get(
      ApiConstants.contactDropdown(
        typeFilter: typeFilter,
        activeFilter: activeFilter,
      ),
    );
    if (response.status == 200) {
      final items = (response.data as List)
          .map((e) => ContactDropdownModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return items;
    }
    throw Exception(response.message ?? 'Failed to load contacts');
  }

  Future<ContactModel> getContactById(String id) async {
    final ResModel response = await _apiService.get(ApiConstants.getContactById(id));
    if (response.status == 200 && response.data != null) {
      return ContactModel.fromMap(response.data);
    }
    throw Exception(response.message ?? 'Failed to load contact');
  }
}
