import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/auth/domain/entities/delete_account_params.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/domain/entities/logout_params.dart';
import 'package:nakha/features/auth/domain/entities/register_params.dart';
import 'package:nakha/features/auth/domain/entities/social_login_params.dart';
import 'package:nakha/features/auth/domain/use_cases/verify_use_case.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, BaseResponse>> startLogin(LoginParameters parameters);

  Future<Either<Failure, BaseResponse<UserModel?>>> startSocialLogin(
    SocialLoginParameters parameters,
  );

  Future<Either<Failure, BaseResponse>> startLogout(
    LogoutParameters parameters,
  );

  Future<Either<Failure, BaseResponse>> startDeleteAccount(
    DeleteAccountParameters parameters,
  );

  Future<Either<Failure, BaseResponse>> startRegister(
    RegisterParams parameters,
  );

  Future<Either<Failure, BaseResponse<UserModel>>> startVerify(
    VerifyParams parameters,
  );

  Future<Either<Failure, BaseResponse>> startResendCode(
    LoginParameters parameters,
  );
}
