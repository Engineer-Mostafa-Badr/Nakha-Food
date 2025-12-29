import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/chat/domain/repositories/base_repo.dart';

class ShowChatsUseCase
    extends BaseUseCase<BaseResponse<ShowChatModel>, ShowChatParameters> {
  ShowChatsUseCase(this.repository);

  final BaseChatsRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ShowChatModel>>> call(
    ShowChatParameters parameters,
  ) {
    return repository.showChats(parameters);
  }
}

class ShowChatParameters extends Equatable {
  const ShowChatParameters({required this.receiverId});

  final int receiverId;

  Map<String, dynamic> toJson() {
    return {'receiver_id': receiverId};
  }

  @override
  List<Object?> get props => [receiverId];
}
