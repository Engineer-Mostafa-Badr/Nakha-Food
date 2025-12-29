import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/chat/domain/use_cases/get_chats_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/show_chat_usecase.dart';

abstract class BaseChatsRemoteDataSource {
  Future<BaseResponse<List<ChatsModel>>> getChats(
    GetChatsParameters parameters,
  );

  Future<BaseResponse<ShowChatModel>> showChats(ShowChatParameters parameters);

  Future<BaseResponse> sendMessage(SendMessageParameters parameters);
}

class ChatsRemoteDataSource extends BaseChatsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ChatsRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<List<ChatsModel>>> getChats(
    GetChatsParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.chats,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<List<ChatsModel>>(
        status: response.data[BaseResponse.statusKey],
        data: (response.data[BaseResponse.dataKey] as List)
            .map((e) => ChatsModel.fromJson(e))
            .toList(),
        msg: response.data[BaseResponse.msgKey],
        // statusCode: response.statusCode,
        pagination: PaginationModel.fromJson(
          response.data[BaseResponse.paginationKey] ?? {},
        ),
      );
    } else {
      throw ServerException(
        // statusCode: response.statusCode,
        message: StatusCode.errorMessage(response),
      );
    }
  }

  @override
  Future<BaseResponse<ShowChatModel>> showChats(
    ShowChatParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.showChat,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<ShowChatModel>(
        status: response.data[BaseResponse.statusKey],
        data: ShowChatModel.fromJson(response.data[BaseResponse.dataKey] ?? {}),
        msg: response.data[BaseResponse.msgKey],
        // statusCode: response.statusCode,
      );
    } else {
      throw ServerException(
        // statusCode: response.statusCode,
        message: StatusCode.errorMessage(response),
      );
    }
  }

  @override
  Future<BaseResponse> sendMessage(SendMessageParameters parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.sendMessage,
      authenticated: true,
      data: await parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
        // statusCode: response.statusCode,
      );
    } else {
      throw ServerException(
        // statusCode: response.statusCode,
        message: StatusCode.errorMessage(response),
      );
    }
  }
}
