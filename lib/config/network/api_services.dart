import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../config/base/base_api_services.dart';
import '../base/base_url.dart';
import '../exception/app_exception.dart';

class ApiService extends BaseApiServices {
  late final Dio _dio;
  late final CacheOptions _cacheOptions;

  ApiService() {
    // Configure cache options
    _cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    );

    // Setup Dio instance
    _dio = Dio(BaseOptions(
      baseUrl: BaseUrl.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ))
      ..interceptors.add(DioCacheInterceptor(options: _cacheOptions));
  }
  // ------------------------ GET ------------------------
  @override
  Future<dynamic> getApi({
    required String url,
    var data,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: data,
        options: _cacheOptions.toOptions(),
      );

      if (response.statusCode == 200) {
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
      throw _handleDioException(e);    }
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
