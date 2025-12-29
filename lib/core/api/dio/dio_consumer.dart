import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nakha/config/navigator_key/navigator_key.dart';
import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/injection_container.dart' as di;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final httpClient = HttpClient()
        ..connectionTimeout = const Duration(seconds: 60)
        ..idleTimeout = const Duration(seconds: 60)
        ..maxConnectionsPerHost = 5;
      return httpClient;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveDataWhenStatusError = true
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    if (kDebugMode) {
      client.interceptors.add(di.sl<PrettyDioLogger>());
    }
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required bool authenticated,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Device-ID': await MostUsedFunctions.getDeviceId(),
            'Accept-Language': EasyLocalization.of(
              NavigatorKey.context,
            )!.locale.languageCode,
            if (authenticated)
              'Authorization':
                  'Bearer ${await di.sl<MainSecureStorage>().getToken()}',
            ...?headers,
          },
        ),
      );
      checkIfNeedLogin(response);
      return response;
    } on DioException catch (error) {
      throw await _handleDioError(error);
    }
  }

  @override
  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    bool formDataIsEnabled = true,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    required bool authenticated,
  }) async {
    try {
      final response = await client.post(
        path,
        data: formDataIsEnabled ? FormData.fromMap(data!) : data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Device-ID': await MostUsedFunctions.getDeviceId(),
            'Accept-Language': EasyLocalization.of(
              NavigatorKey.context,
            )!.locale.languageCode,
            if (authenticated)
              'Authorization':
                  'Bearer ${await di.sl<MainSecureStorage>().getToken()}',
            ...?headers,
          },
        ),
        queryParameters: queryParameters,
      );
      checkIfNeedLogin(response);
      return response;
    } on DioException catch (error) {
      throw await _handleDioError(error);
    }
  }

  @override
  Future<Response> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool responseIsParsing = true,
    Map<String, dynamic>? queryParameters,
    required bool authenticated,
  }) async {
    try {
      final response = await client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Device-ID': await MostUsedFunctions.getDeviceId(),
            'Accept-Language': EasyLocalization.of(
              NavigatorKey.context,
            )!.locale.languageCode,
            if (authenticated)
              'Authorization':
                  'Bearer ${await di.sl<MainSecureStorage>().getToken()}',
            ...?headers,
          },
        ),
      );
      checkIfNeedLogin(response);
      return response;
    } on DioException catch (error) {
      throw await _handleDioError(error);
    }
  }

  @override
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required bool authenticated,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Device-ID': await MostUsedFunctions.getDeviceId(),
            'Accept-Language': EasyLocalization.of(
              NavigatorKey.context,
            )!.locale.languageCode,
            if (authenticated)
              'Authorization':
                  'Bearer ${await di.sl<MainSecureStorage>().getToken()}',
            ...?headers,
          },
        ),
      );
      checkIfNeedLogin(response);
      return response;
    } on DioException catch (error) {
      throw await _handleDioError(error);
    }
  }

  @override
  Future<String> openFileFromAssets(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (error) {
      throw AssetsException(message: error.toString());
    }
  }

  dynamic _handleDioError(DioException error) async {
    // if 401 logout
    if (error.response?.statusCode == StatusCode.unauthorized) {
      await di.sl<MainSecureStorage>().logout();
      NavigatorKey.context.navigateToPageWithClearStack(const LoginPage());
    }

    if (error.response != null &&
        error.response!.data[BaseResponse.msgKey] != null) {
      throw ServerException(message: error.response!.data[BaseResponse.msgKey]);
    } else if (error.response?.statusCode == StatusCode.internalServerError) {
      throw const ServerException(message: 'internal_server_error');
    } else if (error.error is SocketException) {
      throw const ServerException(message: 'no_internet_connection');
    } else if (error.error is TimeoutException) {
      throw const ServerException(message: 'timeout_error');
    } else {
      throw const ServerException(message: AppConst.errorText);
    }

    // else if (error.response?.statusCode == StatusCode.unauthorized) {
    //   throw const ServerException(message: 'unauthorized');
    // } else if (error.response?.statusCode == StatusCode.notFound) {
    //   throw const ServerException(message: 'not_found');
    // } else if (error.response?.statusCode == StatusCode.badRequest) {
    //   throw const ServerException(message: 'bad_request');
    // } else if (error.response?.statusCode == StatusCode.internalServerError) {
    //   throw const ServerException(message: 'internal_server_error');
    // } else if (error.response?.statusCode == StatusCode.forbidden) {
    //   throw const ServerException(message: 'forbidden');
    // }
  }

  void checkIfNeedLogin(Response? response) async {
    if (response?.statusCode == StatusCode.unauthorized) {
      await di.sl<MainSecureStorage>().logout();
      NavigatorKey.context.navigateToPageWithClearStack(const LoginPage());
    }
  }
}
