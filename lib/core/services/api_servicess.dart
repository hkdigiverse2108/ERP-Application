import 'dart:convert';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ApiService extends GetxService {
  // Singleton
  static ApiService get to => Get.find<ApiService>();

  String? _getToken() => Get.find<StorageService>().token;

  final StorageService storageService = StorageService.instance;

  // BASE URL
  final String baseUrl = ApiConstants.baseUrl; // set your API base here

  bool _isNoInternetDialogShowing = false;
  final List<Completer<bool>> _connectivityCompleters = [];

  Future<bool> _checkAndHandleConnectivity() async {
    if (await hasConnection()) return true;

    final completer = Completer<bool>();
    _connectivityCompleters.add(completer);

    if (!_isNoInternetDialogShowing) {
      _isNoInternetDialogShowing = true;
      Get.dialog(
        PopScope(
          canPop: false,
          child: _NoInternetDialog(
            onRetry: () async {
              if (await hasConnection()) {
                _isNoInternetDialogShowing = false;
                Get.back();
                for (var c in _connectivityCompleters) {
                  if (!c.isCompleted) c.complete(true);
                }
                _connectivityCompleters.clear();
              }
            },
          ),
        ),
        barrierDismissible: false,
      ).then((_) {
        // Safety: if dialog closed without retry completing, fail all pending
        if (_isNoInternetDialogShowing) {
          _isNoInternetDialogShowing = false;
          for (var c in _connectivityCompleters) {
            if (!c.isCompleted) c.complete(false);
          }
          _connectivityCompleters.clear();
        }
      });
    }
    return completer.future;
  }

  // Check internet connectivity
  Future<bool> hasConnection() async {
    return await InternetConnection.createInstance(
      customCheckOptions: [
        // Primary: your own server
        InternetCheckOption(
          uri: Uri.parse(baseUrl),
          timeout: const Duration(seconds: 5),
        ),
        // Fallback: Cloudflare
        InternetCheckOption(
          uri: Uri.parse(ApiConstants.baseUrl),
          timeout: const Duration(seconds: 5),
        ),
      ],
    ).hasInternetAccess;
  }

  // GET request
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    if (!await _checkAndHandleConnectivity()) {
      return ResModel.offline('No internet');
    }

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      headers['authorization'] = "Bearer $token";
    }

    final url = Uri.parse('$baseUrl$endpoint');

    final http.Response response;
    try {
      response = await http
          .get(url, headers: headers)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
    } catch (e) {
      log("GET error: $e");
      if (e is TimeoutException) throw Exception("Request timeout");
      throw Exception("Connection failed. Please check your internet.");
    }
    return _handleResponse(response);
  }

  // GET Raw response
  Future<http.Response> getRaw(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    if (!await _checkAndHandleConnectivity()) {
      throw Exception("No internet");
    }

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      headers['authorization'] = "Bearer $token";
    }

    final url = Uri.parse('$baseUrl$endpoint');

    try {
      return await http
          .get(url, headers: headers)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
    } catch (e) {
      log("GET error: $e");
      if (e is TimeoutException) throw Exception("Request timeout");
      throw Exception("Connection failed. Please check your internet.");
    }
  }

  // GET Parsed response in Isolate
  Future<T> getParsed<T>(
    String endpoint,
    T Function(dynamic data) parser, {
    Map<String, String>? headers,
  }) async {
    final response = await getRaw(endpoint, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final String bodyStr = response.body;
      return await Isolate.run(() {
        final body = jsonDecode(bodyStr);
        final res = ResModel.fromJson(body);
        if (res.status == 200 && res.data != null) {
          return parser(res.data);
        }
        throw Exception(res.message ?? 'Failed to parse response');
      });
    } else if (response.statusCode == 401) {
      Get.find<StorageService>().clearSession();
      throw Exception("Token expired");
    } else {
      final String bodyStr = response.body;
      final resModel = await Isolate.run(() {
        final body = jsonDecode(bodyStr);
        return ResModel.fromJson(body);
      });
      throw Exception(resModel.message);
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await _checkAndHandleConnectivity()) {
      return ResModel.offline('No internet');
    }

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      headers['authorization'] = "Bearer $token";
    }

    final Uri url = Uri.parse('$baseUrl$endpoint');

    log(url.toString());

    final http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json', ...headers},
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
    } catch (e) {
      log("POST error: $e");
      if (e is TimeoutException) throw Exception("Request timeout");
      throw Exception("Something went wrong with the network.");
    }
    return _handleResponse(response);
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await _checkAndHandleConnectivity()) {
      return ResModel.offline('No internet');
    }

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      headers['authorization'] = "Bearer $token";
    }

    final Uri url = Uri.parse('$baseUrl$endpoint');
    final http.Response response;
    try {
      response = await http
          .put(
            url,
            headers: {'Content-Type': 'application/json', ...headers},
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
    } catch (e) {
      log("PUT error: $e");
      if (e is TimeoutException) throw Exception("Request timeout");
      throw Exception("Connection failed. Please check your internet.");
    }
    return _handleResponse(response);
  }

  Future<dynamic> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, String>? headers,
    List<http.MultipartFile>? files,
  }) async {
    if (!await _checkAndHandleConnectivity()) {
      return ResModel.offline('No internet');
    }

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      headers['authorization'] = "Bearer $token";
    }

    // IMPORTANT: Flutter MultipartRequest does NOT set these by default
    headers['Accept'] = 'application/json';

    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', url);

    request.headers.addAll(headers);

    if (fields != null) request.fields.addAll(fields);
    if (files != null) request.files.addAll(files);

    log("Multipart Request: $url");
    log("Headers: ${request.headers}");
    if (files != null) {
      for (var f in files) {
        log(
          "File key: ${f.field}, filename: ${f.filename}, length: ${f.length}",
        );
      }
    }

    final http.Response response;
    try {
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timeout"),
      );
      response = await http.Response.fromStream(streamedResponse);
    } catch (e) {
      log("Multipart POST error: $e");
      if (e is TimeoutException) throw Exception("Request timeout");
      throw Exception("File upload failed. Please try again.");
    }
    return _handleResponse(response);
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!await _checkAndHandleConnectivity()) {
      return ResModel.offline('No internet');
    }

    headers ??= {};
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      headers['authorization'] = "Bearer $token";
    }

    final Uri url = Uri.parse('$baseUrl$endpoint');
    final http.Response response;

    log("Delete Request: $url");
    try {
      response = await http
          .delete(
            url,
            headers: {'Content-Type': 'application/json', ...headers},
            // body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
    } catch (e) {
      log("DELETE error: $e");
      if (e is TimeoutException) throw Exception("Request timeout");
      throw Exception("Connection failed. Please try again later.");
    }
    return _handleResponse(response);
  }

  // Response handler
  dynamic _handleResponse(http.Response response) {
    log(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      return ResModel.fromJson(body);
    } else if (response.statusCode == 401) {
      Get.find<StorageService>().clearSession();
      throw Exception("Token expired");
    } else {
      final body = jsonDecode(response.body);
      final resModel = ResModel.fromJson(body);
      throw Exception(resModel.message);
    }
  }

  // Example for local storage with GetStorage
  void saveToStorage(String key, dynamic value) =>
      storageService.write(key, value);

  dynamic readFromStorage(String key) => storageService.read(key);

  void removeFromStorage(String key) => storageService.remove(key);
}

class _NoInternetDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const _NoInternetDialog({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIconsBold.wifiSlash,
                color: Colors.orange[700],
                size: 40,
              ),
            ),
            const Gap(24),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            Text(
              "Please check your internet settings and try again to continue.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Retry Connection",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
