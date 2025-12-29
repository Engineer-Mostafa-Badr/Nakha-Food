import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';

abstract class BaseNotificationsRemoteDataSource {
  Future<BaseResponse<List<NotificationsModel>>> getNotifications(
    PaginationParameters parameters,
  );
}

class NotificationsRemoteDataSource extends BaseNotificationsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  NotificationsRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<List<NotificationsModel>>> getNotifications(
    PaginationParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.notifications,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<NotificationsModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => NotificationsModel.fromJson(e))
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
}
