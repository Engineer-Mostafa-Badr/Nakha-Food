import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/auth/domain/entities/delete_account_params.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/domain/entities/logout_params.dart';
import 'package:nakha/features/auth/domain/entities/register_params.dart';
import 'package:nakha/features/auth/domain/entities/social_login_params.dart';
import 'package:nakha/features/auth/domain/use_cases/verify_use_case.dart';

abstract class BaseLoginRemoteDataSource {
  Future<BaseResponse> startLogin(LoginParameters parameters);

  Future<BaseResponse> startSocialLogin(SocialLoginParameters parameters);

  Future<BaseResponse> startLogout(LogoutParameters parameters);

  Future<BaseResponse> startDeleteAccount(DeleteAccountParameters parameters);

  Future<BaseResponse> startRegister(RegisterParams parameters);

  Future<BaseResponse<UserModel>> startVerify(VerifyParams parameters);

  Future<BaseResponse> startResendCode(LoginParameters parameters);
}

class LoginRemoteDataSource extends BaseLoginRemoteDataSource {
  final ApiConsumer _apiConsumer;

  LoginRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse> startLogin(LoginParameters parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.login,
      authenticated: false,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<UserModel>(
        status: response.data[BaseResponse.statusKey],
        data: response.data[BaseResponse.dataKey] == null
            ? null
            : UserModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<UserModel?>> startSocialLogin(
    SocialLoginParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.socialLogin,
      authenticated: false,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<UserModel?>(
        status: response.data[BaseResponse.statusKey],
        data: response.data[BaseResponse.dataKey] == null
            ? null
            : UserModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> startLogout(LogoutParameters parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.logout,
      authenticated: true,
      data: await parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> startDeleteAccount(
    DeleteAccountParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.deleteAccount,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> startRegister(RegisterParams parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.register,
      authenticated: false,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<UserModel?>(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
        data: response.data[BaseResponse.dataKey] == null
            ? null
            : UserModel.fromJson(response.data[BaseResponse.dataKey]),
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<UserModel>> startVerify(VerifyParams parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.verifyOTP,
      authenticated: false,
      data: await parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<UserModel>(
        status: response.data[BaseResponse.statusKey],
        data: response.data[BaseResponse.dataKey] == null
            ? null
            : UserModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> startResendCode(LoginParameters parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.resendOTP,
      authenticated: false,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
