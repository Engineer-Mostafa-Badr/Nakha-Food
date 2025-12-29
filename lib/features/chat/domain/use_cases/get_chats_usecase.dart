import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/domain/repositories/base_repo.dart';

class ChatsUseCase
    extends BaseUseCase<BaseResponse<List<ChatsModel>>, GetChatsParameters> {
  ChatsUseCase(this.repository);

  final BaseChatsRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<ChatsModel>>>> call(
    GetChatsParameters parameters,
  ) {
    return repository.getChats(parameters);
  }
}

class GetChatsParameters extends PaginationParameters {
  const GetChatsParameters({super.page = 1, this.search = ''});

  final String search;

  @override
  Map<String, dynamic> toJson() {
    return {'page': page, if (search.isNotEmpty) 'search': search};
  }

  @override
  GetChatsParameters copyWith({int page = 1, String? search}) {
    return GetChatsParameters(page: page, search: search ?? this.search);
  }
}
