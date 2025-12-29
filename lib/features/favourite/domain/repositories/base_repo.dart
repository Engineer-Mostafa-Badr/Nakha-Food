import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_providers_usecase.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

abstract class BaseFavouriteRepository {
  Future<Either<Failure, BaseResponse<List<ProvidersModel>>>>
  getFavouriteProviders(FavouriteProvidersParameters parameters);

  Future<Either<Failure, BaseResponse<ProvidersModel>>>
  toggleFavouriteProviders(ToggleFavouriteProvidersParameters parameters);

  Future<Either<Failure, BaseResponse<List<ProductsModel>>>>
  getFavouriteProducts(FavouriteProductsParameters parameters);

  Future<Either<Failure, BaseResponse<ProductsModel>>> toggleFavouriteProducts(
    ToggleFavouriteProductsParameters parameters,
  );
}
