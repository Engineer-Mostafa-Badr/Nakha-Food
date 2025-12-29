import 'package:dio/dio.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/features/injection_container.dart';

class StatusCode {
  static const int ok = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int internalServerError = 500;
  static const int methodNotAllowed = 505;
  static const int notAllowed = 405;

  static String? errorMessage(Response<dynamic>? response) {
    // if response is json format and contains message key return it
    if (response?.data is Map<String, dynamic> &&
        response?.data['message'] != null) {
      return response?.data['message'];
    }

    switch (response?.statusCode) {
      case badRequest:
        return 'bad_request';
      case unauthorized:
        sl<MainSecureStorage>().logout();
        return 'unauthorized';
      case forbidden:
        return 'forbidden';
      case notFound:
        return 'not_found';
      case conflict:
        return 'conflict';
      case internalServerError:
        return 'internal_server_error';
      case methodNotAllowed:
        return 'method_not_allowed';
      case notAllowed:
        return 'not_allowed';
      default:
        return 'unknown_error';
    }
  }

  static bool isSuccessful(Response<dynamic>? response) {
    return (response?.statusCode == ok && response?.statusCode == created) ||
        response?.data[BaseResponse.statusKey] == true;
  }

  static bool isSuccessfulPrayer(Response<dynamic>? response) {
    return response?.statusCode == ok;
  }
}
