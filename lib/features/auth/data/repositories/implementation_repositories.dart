import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/auth/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/auth/domain/entities/delete_account_params.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/domain/entities/logout_params.dart';
import 'package:nakha/features/auth/domain/entities/register_params.dart';
import 'package:nakha/features/auth/domain/entities/social_login_params.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';
import 'package:nakha/features/auth/domain/use_cases/verify_use_case.dart';

class LoginRepositoryImpl implements BaseLoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse>> startLogin(
    LoginParameters parameters,
  ) async {
    try {
      final result = await remoteDataSource.startLogin(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.message,
          // errNum: failure.errNum,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, BaseResponse<UserModel?>>> startSocialLogin(
    SocialLoginParameters parameters,
  ) async {
    try {
      final result = await remoteDataSource.startSocialLogin(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> startLogout(
    LogoutParameters parameters,
  ) async {
    try {
      final result = await remoteDataSource.startLogout(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.message,
          // errNum: failure.errNum,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> startDeleteAccount(
    DeleteAccountParameters parameters,
  ) async {
    try {
      final result = await remoteDataSource.startDeleteAccount(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.message,
          // errNum: failure.errNum,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> startRegister(
    RegisterParams parameters,
  ) async {
    try {
      final result = await remoteDataSource.startRegister(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.message,
          // errNum: failure.errNum,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> startVerify(
    VerifyParams parameters,
  ) async {
    try {
      final result = await remoteDataSource.startVerify(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.message,
          // errNum: failure.errNum,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> startResendCode(
    LoginParameters parameters,
  ) async {
    try {
      final result = await remoteDataSource.startResendCode(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.message,
          // errNum: failure.errNum,
        ),
      );
    }
  }
}
