import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_providers_usecase.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

abstract class BaseFavouriteRemoteDataSource {
  Future<BaseResponse<List<ProvidersModel>>> getFavouriteProviders(
    FavouriteProvidersParameters parameters,
  );

  Future<BaseResponse<ProvidersModel>> toggleFavouriteProviders(
    ToggleFavouriteProvidersParameters parameters,
  );

  Future<BaseResponse<List<ProductsModel>>> getFavouriteProducts(
    FavouriteProductsParameters parameters,
  );

  Future<BaseResponse<ProductsModel>> toggleFavouriteProducts(
    ToggleFavouriteProductsParameters parameters,
  );
}

class FavouriteRemoteDataSource extends BaseFavouriteRemoteDataSource {
  final ApiConsumer _apiConsumer;

  FavouriteRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<List<ProvidersModel>>> getFavouriteProviders(
    FavouriteProvidersParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.favouriteProviders,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<ProvidersModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => ProvidersModel.fromJson(e))
            .toList(),
        pagination: PaginationModel.fromJson(
          response.data[BaseResponse.paginationKey],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<ProvidersModel>> toggleFavouriteProviders(
    ToggleFavouriteProvidersParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.toggleFavouriteProviders,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ProvidersModel>(
        status: response.data[BaseResponse.statusKey],
        data: ProvidersModel.fromJson(
          response.data[BaseResponse.dataKey]['vendor'],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<List<ProductsModel>>> getFavouriteProducts(
    FavouriteProductsParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.favouriteProducts,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<ProductsModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => ProductsModel.fromJson(e))
            .toList(),
        pagination: PaginationModel.fromJson(
          response.data[BaseResponse.paginationKey],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<ProductsModel>> toggleFavouriteProducts(
    ToggleFavouriteProductsParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.toggleFavouriteProducts,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ProductsModel>(
        status: response.data[BaseResponse.statusKey],
        data: ProductsModel.fromJson(
          response.data[BaseResponse.dataKey]['product'],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
