import 'dart:developer';

import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio;

  NetworkService({String baseUrl = ''})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl, ));

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      log('Connection Timeout');
    } else if (error.type == DioExceptionType.sendTimeout) {
      log('Send Timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      log('Receive Timeout');
    } else if (error.type == DioExceptionType.badResponse) {
      log('Server Error: ${error.response?.statusCode}');
    } else if (error.type == DioExceptionType.cancel) {
      log('Request Cancelled');
    } else {
      log('Unexpected Error: ${error.message}');
    }
  }
}