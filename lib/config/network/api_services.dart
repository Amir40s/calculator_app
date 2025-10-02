import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../config/base/base_api_services.dart';
import '../base/base_url.dart';
import '../exception/app_exception.dart';


class ApiService extends BaseApiServices{

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: Duration(seconds: 5000),
    receiveTimeout: Duration(seconds: 3000),
    headers: {
      HttpHeaders.authorizationHeader: 'Basic ${base64Encode(utf8.encode('${BaseUrl.authUsername}:${BaseUrl.authPassword}'))}',
    },
  ));


  @override
  Future<dynamic> getApi({required String url, dynamic data, Map<String, dynamic>? headers,}) async {
    try {
      log("POST URL: $url");
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      Response response = await _dio.get(url,queryParameters: data);

      if (response.statusCode == 200) {
        log("GET response: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("Dio error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }

  @override
  Future<dynamic> postApi({required String url, var data,  Map<String, dynamic>? headers,}) async {
    try {
      log("POST URL: $url");
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      Response response = await _dio.post(url, data: data);
      log("Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        log("POST response: ${response.data}");
        return response.data;
      } else {
        log("Message:: ${response.statusMessage}");
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("Dio error: ${e.response?.extra['message']}");
      throw _handleDioException(e);
    }
  }

  @override
  Future<dynamic> patchApi({
    required String url,
    required var data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("PATCH URL: $url");
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      Response response = await _dio.patch(url, data: data);
      log("PATCH Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        log("PATCH response: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("PATCH Dio error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }


  @override
  Future<dynamic> deleteApi({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("DELETE URL: $url");
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      Response response = await _dio.delete(
        url,
        data: data, // optional body (can be null)
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log("DELETE response: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      final responseData = e.response?.data;
      String errorMessage = "Something went wrong";
      if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
        errorMessage = responseData['message'];
      }
      log("Dio DELETE error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }


  // Exception _handleDioException(DioException e) {
  //   if (e.response?.statusCode == 500) {
  //     return ServerErrorException("Server error");
  //   } else if (e.response == null) {
  //     return InternetExceptions("Check your internet connection");
  //   } else {
  //     return Exception("Error: ${e.response?.statusMessage}");
  //   }
  // }
  Exception _handleDioException(DioException e) {
    if (e.response?.statusCode == 500) {
      return ServerErrorException("Server error");
    } else if (e.response == null) {
      return InternetExceptions("Check your internet connection");
    } else {
      final responseData = e.response?.data;

      // ✅ Extract the "message" field from the response if available
      if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
        return BadRequestException(responseData['message']);
      }

      // Fallback if no message is present
      return BadRequestException("Something went wrong (${e.response?.statusMessage})");
    }
  }


  dynamic _handleError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw UrlNotFoundException("URL not found");
      case 404:
        throw UrlNotFoundException("Resource not found");
      case 500:
        throw ServerErrorException("Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  @override
  Future postUploadFile({ required String url,
    required File file,
    Map<String, String>? extraData,
    Map<String, dynamic>? headers,
    required Function(int sentBytes, int totalBytes) onSendProgress}) async{
    try {
      log("UPLOAD URL: $url");
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        if (extraData != null) ...extraData,
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await _dio.post(
        url,
        data: formData,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("UPLOAD success: ${response.data}");
        return response.data;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw InternetExceptions("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on DioException catch (e) {
      log("Upload Dio error: ${e.response?.statusCode}");
      throw _handleDioException(e);
    }
  }
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
  @override
  String toString() => "BadRequestException: $message";
}