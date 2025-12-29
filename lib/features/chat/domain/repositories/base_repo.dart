import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/chat/domain/use_cases/get_chats_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/show_chat_usecase.dart';

abstract class BaseChatsRepository {
  Future<Either<Failure, BaseResponse<List<ChatsModel>>>> getChats(
    GetChatsParameters parameters,
  );

  Future<Either<Failure, BaseResponse<ShowChatModel>>> showChats(
    ShowChatParameters parameters,
  );

  Future<Either<Failure, BaseResponse>> sendMessage(
    SendMessageParameters parameters,
  );
}
