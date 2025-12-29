import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/profile/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/domain/repositories/base_profile_repo.dart';
import 'package:nakha/features/profile/domain/use_cases/contact_us_usecase.dart';

class ProfileRepositoryImpl implements BaseProfileRepository {
  ProfileRepositoryImpl(this.remoteDataSource);

  final ProfileRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> updateProfile(
    UpdateProfileParams parameters,
  ) async {
    try {
      final response = await remoteDataSource.updateProfile(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<InvoiceModel>>>> getMyInvoices(
    PaginationParameters params,
  ) async {
    try {
      final response = await remoteDataSource.getMyInvoices(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> contactUs(
    ContactUsParams parameters,
  ) async {
    try {
      final response = await remoteDataSource.contactUs(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
