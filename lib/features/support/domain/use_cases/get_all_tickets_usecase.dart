import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';

class GetAllTicketsUseCase
    extends BaseUseCase<BaseResponse<List<TicketModel>>, PaginationParameters> {
  final BaseSupportChatRepository repository;

  GetAllTicketsUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<List<TicketModel>>>> call(
    PaginationParameters parameters,
  ) {
    return repository.getAllSupportChat(parameters);
  }
}
