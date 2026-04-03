import 'package:ai_setu/data/model/res_model/res_model.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/storage_service.dart';

class ApiService extends GetConnect implements GetxService {
  static ApiService get to => Get.put(ApiService());

  @override
  final String baseUrl = ApiConstants.baseUrl;

  String? _getToken() => StorageService.instance.token;

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      final token = _getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      return request;
    });

    super.onInit();
  }

  Future<ResModel> postRequest(
    String endpoint,
    dynamic body, {
    bool isAuth = true,
  }) async {
    final response = await post(
      endpoint,
      body,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        if (isAuth && _getToken() != null)
          "Authorization": "Bearer ${_getToken()}",
      },
    );

    // 🔥 FIX HERE
    final responseData = response.body;

    if (responseData == null) {
      return ResModel(
        status: 0,
        message: "Empty response from server",
        data: null,
      );
    }

    if (responseData is Map<String, dynamic>) {
      return ResModel.fromJson(responseData);
    } else {
      return ResModel(
        status: 0,
        message: "Invalid response format",
        data: responseData,
      );
    }
  }

  /// ✅ GET
  Future<Response> getRequest(String endpoint) async {
    return await get(endpoint);
  }
}
