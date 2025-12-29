import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/entities/send_support_message_params.dart';
import 'package:nakha/features/support/domain/use_cases/close_ticket_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/store_ticket_usecase.dart';

abstract class BaseSupportChatRepository {
  Future<Either<Failure, BaseResponse<ChatTicketModel>>> getSupportChat(
    int packageId,
  );

  Future<Either<Failure, BaseResponse>> sendSupportChat(
    SendSupportMessageParams params,
  );

  Future<Either<Failure, BaseResponse<TicketModel>>> storeTicket(
    StoreTicketParams parameters,
  );

  Future<Either<Failure, BaseResponse<List<TicketModel>>>> getAllSupportChat(
    PaginationParameters parameters,
  );

  Future<Either<Failure, BaseResponse<CloseTicketParams>>> closeTicket(
    CloseTicketParams parameters,
  );
}
