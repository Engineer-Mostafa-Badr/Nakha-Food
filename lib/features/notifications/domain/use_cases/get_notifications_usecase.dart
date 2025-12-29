import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';
import 'package:nakha/features/notifications/domain/repositories/base_notifications_repo.dart';

class GetNotificationsUseCase
    extends
        BaseUseCase<
          BaseResponse<List<NotificationsModel>>,
          PaginationParameters
        > {
  final BaseNotificationsRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<List<NotificationsModel>>>> call(
    PaginationParameters parameters,
  ) {
    return repository.getNotifications(parameters);
  }
}
