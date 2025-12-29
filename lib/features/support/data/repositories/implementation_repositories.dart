import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/entities/send_support_message_params.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';
import 'package:nakha/features/support/domain/use_cases/close_ticket_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/store_ticket_usecase.dart';

class SupportChatRepositoryImpl implements BaseSupportChatRepository {
  final SupportChatRemoteDataSource remoteDataSource;

  SupportChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse<ChatTicketModel>>> getSupportChat(
    int packageId,
  ) async {
    try {
      final response = await remoteDataSource.getSupportChat(packageId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> sendSupportChat(
    SendSupportMessageParams params,
  ) async {
    try {
      final response = await remoteDataSource.sendSupportChat(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TicketModel>>> storeTicket(
    StoreTicketParams parameters,
  ) async {
    try {
      final response = await remoteDataSource.storeTicket(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<TicketModel>>>> getAllSupportChat(
    PaginationParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getAllSupportChat(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CloseTicketParams>>> closeTicket(
    CloseTicketParams parameters,
  ) async {
    try {
      final response = await remoteDataSource.closeTicket(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
