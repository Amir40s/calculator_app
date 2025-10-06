import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../config/base/base_api_services.dart';
import '../base/base_url.dart';
import '../exception/app_exception.dart';

class ApiService extends BaseApiServices {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = BaseUrl.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // ------------------------ GET ------------------------
  @override
  Future<dynamic> getApi({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("🔵 GET URL: ${_dio.options.baseUrl}$url");
      if (headers != null) _dio.options.headers.addAll(headers);

      final response = await _dio.get(url, queryParameters: data);
      log("✅ GET Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        log("📩 GET Response: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // ------------------------ POST ------------------------
  @override
  Future<dynamic> postApi({
    required String url,
    var data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("🟢 POST URL: ${_dio.options.baseUrl}$url");
      log("📦 POST DATA: $data");

      if (headers != null) _dio.options.headers.addAll(headers);

      final response = await _dio.post(url, data: data);
      log("✅ POST Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("📩 POST Response: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("❌ Dio POST error: ${e.response?.statusCode} - ${e.message}");
      throw _handleDioException(e);
    }
  }

  // ------------------------ PATCH ------------------------
  @override
  Future<dynamic> patchApi({
    required String url,
    required var data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("🟠 PATCH URL: ${_dio.options.baseUrl}$url");
      if (headers != null) _dio.options.headers.addAll(headers);

      final response = await _dio.patch(url, data: data);
      log("✅ PATCH Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("❌ PATCH Dio error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }

  // ------------------------ DELETE ------------------------
  @override
  Future<dynamic> deleteApi({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("🔴 DELETE URL: ${_dio.options.baseUrl}$url");
      if (headers != null) _dio.options.headers.addAll(headers);

      final response = await _dio.delete(url, data: data);
      log("✅ DELETE Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("❌ DELETE Dio error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }

  // ------------------------ FILE UPLOAD ------------------------
  @override
  Future postUploadFile({
    required String url,
    required File file,
    Map<String, String>? extraData,
    Map<String, dynamic>? headers,
    required Function(int sentBytes, int totalBytes) onSendProgress,
  }) async {
    try {
      log("📤 UPLOAD URL: ${_dio.options.baseUrl}$url");
      if (headers != null) _dio.options.headers.addAll(headers);

      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        if (extraData != null) ...extraData,
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _dio.post(
        url,
        data: formData,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("✅ UPLOAD Success: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("❌ Upload Dio error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }

  // ------------------------ ERROR HANDLERS ------------------------
  Exception _handleDioException(DioException e) {
    if (e.response?.statusCode == 500) {
      return ServerErrorException("Server error");
    } else if (e.response == null) {
      return InternetExceptions("Check your internet connection");
    } else {
      final responseData = e.response?.data;
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('error')) {
        return BadRequestException(responseData['error']);
      }
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        return BadRequestException(responseData['message']);
      }
      return BadRequestException(
          "Unexpected error (${e.response?.statusCode}): ${e.message}");
    }
  }

  dynamic _handleError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException("Bad request (400)");
      case 404:
        throw UrlNotFoundException("Resource not found (404)");
      case 500:
        throw ServerErrorException("Server error (500)");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }
}

// Custom Exception
class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
  @override
  String toString() => "BadRequestException: $message";
}
