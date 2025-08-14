// 🌐 API Client
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../errors/exceptions.dart';
import '../utils/constants.dart';

class ApiClient {
  final Dio _dio;
  
  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: AppConstants.apiTimeout,
    receiveTimeout: AppConstants.apiTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  )) {
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add logging in debug mode
          if (kDebugMode) {
            print('REQUEST[${options.method}] => PATH: ${options.path}');
            print('HEADERS: ${options.headers}');
            print('DATA: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Add logging in debug mode
          if (kDebugMode) {
            print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
            print('DATA: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          // Handle errors
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            throw NetworkException('No internet connection');
          } else if (error.response?.statusCode == 401) {
            throw AuthenticationException('Unauthorized');
          } else if (error.response?.statusCode == 403) {
            throw AuthorizationException('Forbidden');
          } else if (error.response?.statusCode == 422) {
            throw ValidationException(
              'Validation error',
              errors: Map<String, List<String>>.from(
                error.response?.data['errors'] ?? {},
              ),
            );
          } else {
            throw ServerException(
              'Server error',
              statusCode: error.response?.statusCode,
              data: error.response?.data,
            );
          }
        },
      ),
    );
  }
  
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
