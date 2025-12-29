import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/domain/entities/get_home_utils_params.dart';

abstract class BaseHomeRemoteDataSource {
  Future<BaseResponse<HomeModel>> getHomeUtils(GetHomeUtilsParams params);

  Future<BaseResponse<String>> generateNewPayLink();

  Future<BaseResponse<List<CategoriesModel>>> getCategories(
    NoParameters parameters,
  );
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  final ApiConsumer _apiConsumer;

  HomeRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<HomeModel>> getHomeUtils(
    GetHomeUtilsParams params,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.home,
      authenticated: true,
      queryParameters: await params.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<HomeModel>(
        status: response.data[BaseResponse.statusKey],
        data: HomeModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<String>> generateNewPayLink() async {
    final response = await _apiConsumer.get(
      EndPoints.generateNewPayLink,
      authenticated: true,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<String>(
        status: response.data[BaseResponse.statusKey],
        data: response.data[BaseResponse.dataKey]['payment_link'],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<List<CategoriesModel>>> getCategories(
    NoParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.categories,
      authenticated: true,
    );
    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<CategoriesModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => CategoriesModel.fromJson(e))
            .toList(),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
