import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';

class CloseTicketUseCase
    extends BaseUseCase<BaseResponse<CloseTicketParams>, CloseTicketParams> {
  final BaseSupportChatRepository repository;

  CloseTicketUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<CloseTicketParams>>> call(
    CloseTicketParams parameters,
  ) {
    return repository.closeTicket(parameters);
  }
}

class CloseTicketParams extends Equatable {
  final int id;

  const CloseTicketParams({required this.id});

  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  List<Object?> get props => [id];
}
