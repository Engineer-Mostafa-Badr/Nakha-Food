import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_provider_profile_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_providers_usecase.dart';

import '../../../domain/use_cases/show_product_usecase.dart'
    show ShowProductParameters;

abstract class BaseProvidersRemoteDataSource {
  Future<BaseResponse<List<ProvidersModel>>> getProviders(
    ProvidersParameters parameters,
  );

  Future<BaseResponse<ProviderProfileModel>> getProviderProfile(
    ProviderProfileParameters parameters,
  );

  Future<BaseResponse<ShowProductModel>> showProduct(
    ShowProductParameters parameters,
  );

  Future<BaseResponse<List<ProductsModel>>> getProducts(
    ProductsParameters parameters,
  );

  Future<BaseResponse<List<ProductsModel>>> getVendorProducts(
    PaginationParameters parameters,
  );

  Future<BaseResponse<ProductsModel>> addProduct(
    AddProductParameters parameters,
  );

  Future<BaseResponse<ProductsModel>> updateProduct(
    AddProductParameters parameters,
  );

  Future<BaseResponse<int>> deleteProduct(int productId);
}

class ProvidersRemoteDataSource extends BaseProvidersRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ProvidersRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<List<ProvidersModel>>> getProviders(
    ProvidersParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.providers,
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
  Future<BaseResponse<ProviderProfileModel>> getProviderProfile(
    ProviderProfileParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.providerProfile,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );
    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ProviderProfileModel>(
        status: response.data[BaseResponse.statusKey],
        data: ProviderProfileModel.fromJson(
          response.data[BaseResponse.dataKey],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<ShowProductModel>> showProduct(
    ShowProductParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.showProduct(parameters.productId),
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ShowProductModel>(
        status: response.data[BaseResponse.statusKey],
        data: ShowProductModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<List<ProductsModel>>> getProducts(
    ProductsParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.products,
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
  Future<BaseResponse<List<ProductsModel>>> getVendorProducts(
    PaginationParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.vendorProducts,
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
  Future<BaseResponse<ProductsModel>> addProduct(
    AddProductParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.addProduct,
      authenticated: true,
      data: await parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ProductsModel>(
        status: response.data[BaseResponse.statusKey],
        data: ProductsModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<ProductsModel>> updateProduct(
    AddProductParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.updateProduct(parameters.productId),
      authenticated: true,
      data: await parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ProductsModel>(
        status: response.data[BaseResponse.statusKey],
        data: ProductsModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<int>> deleteProduct(int productId) async {
    final response = await _apiConsumer.delete(
      EndPoints.deleteProduct(productId),
      authenticated: true,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<int>(
        status: response.data[BaseResponse.statusKey],
        data: productId,
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
