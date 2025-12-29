import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';

class StoreTicketUseCase
    extends BaseUseCase<BaseResponse<TicketModel>, StoreTicketParams> {
  final BaseSupportChatRepository repository;

  StoreTicketUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<TicketModel>>> call(
    StoreTicketParams parameters,
  ) {
    return repository.storeTicket(parameters);
  }
}

class StoreTicketParams extends Equatable {
  final String title;
  final String description;

  const StoreTicketParams({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }

  @override
  List<Object?> get props => [title, description];
}
