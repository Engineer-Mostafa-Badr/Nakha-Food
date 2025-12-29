import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';

class GetSupportChatUseCase
    extends BaseUseCase<BaseResponse<ChatTicketModel>, int> {
  final BaseSupportChatRepository repository;

  GetSupportChatUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<ChatTicketModel>>> call(int parameters) {
    return repository.getSupportChat(parameters);
  }
}
