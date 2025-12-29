import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/favourite/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/favourite/domain/repositories/base_repo.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_providers_usecase.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class FavouriteRepositoryImpl implements BaseFavouriteRepository {
  FavouriteRepositoryImpl(this.remoteDataSource);

  final FavouriteRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseResponse<List<ProvidersModel>>>>
  getFavouriteProviders(FavouriteProvidersParameters parameters) async {
    try {
      final response = await remoteDataSource.getFavouriteProviders(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ProvidersModel>>>
  toggleFavouriteProviders(
    ToggleFavouriteProvidersParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.toggleFavouriteProviders(
        parameters,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<ProductsModel>>>>
  getFavouriteProducts(FavouriteProductsParameters parameters) async {
    try {
      final response = await remoteDataSource.getFavouriteProducts(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ProductsModel>>> toggleFavouriteProducts(
    ToggleFavouriteProductsParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.toggleFavouriteProducts(
        parameters,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
