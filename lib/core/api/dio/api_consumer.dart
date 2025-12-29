import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required bool authenticated,
  });

  Future<Response> post(
    String path, {
    required Map<String, dynamic> data,
    bool formDataIsEnabled = true,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required bool authenticated,
  });

  Future<Response> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required bool authenticated,
  });

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required bool authenticated,
  });

  Future<String> openFileFromAssets(String path);
}
