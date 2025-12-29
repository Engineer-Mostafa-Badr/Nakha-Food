import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/domain/entities/get_home_utils_params.dart';
import 'package:nakha/features/home/domain/repositories/base_home_repo.dart';

class HomeRepositoryImpl implements BaseHomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse<HomeModel>>> getHomeUtils(
    GetHomeUtilsParams params,
  ) async {
    try {
      final response = await remoteDataSource.getHomeUtils(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> generateNewPayLink() async {
    try {
      final response = await remoteDataSource.generateNewPayLink();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<CategoriesModel>>>> getCategories(
    NoParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getCategories(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
