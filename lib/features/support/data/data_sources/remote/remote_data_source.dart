import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/entities/send_support_message_params.dart';
import 'package:nakha/features/support/domain/use_cases/close_ticket_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/store_ticket_usecase.dart';

abstract class BaseSupportChatRemoteDataSource {
  Future<BaseResponse<ChatTicketModel>> getSupportChat(int packageId);

  Future<BaseResponse> sendSupportChat(SendSupportMessageParams params);

  Future<BaseResponse<TicketModel>> storeTicket(StoreTicketParams parameters);

  Future<BaseResponse<List<TicketModel>>> getAllSupportChat(
    PaginationParameters parameters,
  );

  Future<BaseResponse<CloseTicketParams>> closeTicket(
    CloseTicketParams parameters,
  );
}

class SupportChatRemoteDataSource extends BaseSupportChatRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SupportChatRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<ChatTicketModel>> getSupportChat(int packageId) async {
    final response = await _apiConsumer.get(
      EndPoints.showSupportChat(packageId),
      authenticated: true,
      // queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ChatTicketModel>(
        status: response.data[BaseResponse.statusKey],
        data: ChatTicketModel.fromJson(
          response.data[BaseResponse.dataKey] ?? {},
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> sendSupportChat(SendSupportMessageParams params) async {
    final response = await _apiConsumer.post(
      EndPoints.addComment(params.packageId!),
      authenticated: true,
      data: await params.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ChatTicketModel>(
        status: response.data[BaseResponse.statusKey],
        data: ChatTicketModel.fromJson(
          response.data[BaseResponse.dataKey] ?? {},
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<TicketModel>> storeTicket(
    StoreTicketParams parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.storeTicket,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<TicketModel>(
        status: response.data[BaseResponse.statusKey],
        data: TicketModel.fromJson(response.data[BaseResponse.dataKey] ?? {}),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<List<TicketModel>>> getAllSupportChat(
    PaginationParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.getAllTickets,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<TicketModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => TicketModel.fromJson(e))
            .toList(),
        msg: response.data[BaseResponse.msgKey],
        pagination: PaginationModel.fromJson(
          response.data[BaseResponse.paginationKey] ?? {},
        ),
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<CloseTicketParams>> closeTicket(
    CloseTicketParams parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.closeTicket(parameters.id),
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<CloseTicketParams>(
        status: response.data[BaseResponse.statusKey],
        data: parameters,
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
