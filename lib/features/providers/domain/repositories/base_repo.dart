import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_provider_profile_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_providers_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/show_product_usecase.dart';

abstract class BaseProvidersRepository {
  Future<Either<Failure, BaseResponse<List<ProvidersModel>>>> getProviders(
    ProvidersParameters parameters,
  );

  Future<Either<Failure, BaseResponse<ProviderProfileModel>>>
  getProviderProfile(ProviderProfileParameters parameters);

  Future<Either<Failure, BaseResponse<ShowProductModel>>> showProduct(
    ShowProductParameters parameters,
  );

  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> getProducts(
    ProductsParameters parameters,
  );

  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> getVendorProducts(
    PaginationParameters parameters,
  );

  Future<Either<Failure, BaseResponse<ProductsModel>>> addProduct(
    AddProductParameters parameters,
  );

  Future<Either<Failure, BaseResponse<ProductsModel>>> updateProduct(
    AddProductParameters parameters,
  );

  Future<Either<Failure, BaseResponse<int>>> deleteProduct(int productId);
}
