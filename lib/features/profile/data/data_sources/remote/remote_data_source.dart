import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/domain/use_cases/contact_us_usecase.dart';

abstract class BaseProfileRemoteDataSource {
  Future<BaseResponse<UserModel>> getProfile();

  Future<BaseResponse<UserModel>> updateProfile(UpdateProfileParams parameters);

  Future<BaseResponse<List<InvoiceModel>>> getMyInvoices(
    PaginationParameters params,
  );

  Future<BaseResponse> contactUs(ContactUsParams parameters);
}

class ProfileRemoteDataSource extends BaseProfileRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ProfileRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<UserModel>> getProfile() async {
    final response = await _apiConsumer.get(
      EndPoints.profile,
      authenticated: true,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<UserModel>(
        status: response.data[BaseResponse.statusKey],
        data: UserModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<UserModel>> updateProfile(
    UpdateProfileParams parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.profile,
      data: await parameters.toJson(),
      authenticated: true,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<UserModel>(
        status: response.data[BaseResponse.statusKey],
        data: UserModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<List<InvoiceModel>>> getMyInvoices(
    PaginationParameters params,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.myInvoices,
      authenticated: true,
      queryParameters: params.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<InvoiceModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => InvoiceModel.fromJson(e))
            .toList(),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> contactUs(ContactUsParams parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.contactUs,
      data: await parameters.toJson(),
      authenticated: true,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
