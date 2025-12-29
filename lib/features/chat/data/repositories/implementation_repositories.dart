import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/chat/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/chat/domain/repositories/base_repo.dart';
import 'package:nakha/features/chat/domain/use_cases/get_chats_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/show_chat_usecase.dart';

class ChatsRepositoryImpl implements BaseChatsRepository {
  ChatsRepositoryImpl(this.remoteDataSource);

  final ChatsRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseResponse<List<ChatsModel>>>> getChats(
    GetChatsParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getChats(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ShowChatModel>>> showChats(
    ShowChatParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.showChats(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> sendMessage(
    SendMessageParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.sendMessage(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
