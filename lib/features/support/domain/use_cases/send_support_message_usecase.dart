import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/domain/entities/send_support_message_params.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';

class SendSupportMessageUseCase
    extends BaseUseCase<BaseResponse, SendSupportMessageParams> {
  final BaseSupportChatRepository repository;

  SendSupportMessageUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(
    SendSupportMessageParams parameters,
  ) {
    return repository.sendSupportChat(parameters);
  }
}
