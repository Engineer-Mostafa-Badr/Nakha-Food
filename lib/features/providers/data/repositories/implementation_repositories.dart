import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_provider_profile_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_providers_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/show_product_usecase.dart';

class ProvidersRepositoryImpl implements BaseProvidersRepository {
  ProvidersRepositoryImpl(this.remoteDataSource);

  final ProvidersRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseResponse<List<ProvidersModel>>>> getProviders(
    ProvidersParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getProviders(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ProviderProfileModel>>>
  getProviderProfile(ProviderProfileParameters parameters) async {
    try {
      final response = await remoteDataSource.getProviderProfile(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ShowProductModel>>> showProduct(
    ShowProductParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.showProduct(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> getProducts(
    ProductsParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getProducts(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> getVendorProducts(
    PaginationParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getVendorProducts(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ProductsModel>>> addProduct(
    AddProductParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.addProduct(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ProductsModel>>> updateProduct(
    AddProductParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.updateProduct(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<int>>> deleteProduct(
    int productId,
  ) async {
    try {
      final response = await remoteDataSource.deleteProduct(productId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
