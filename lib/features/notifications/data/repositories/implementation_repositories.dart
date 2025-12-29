import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/notifications/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';
import 'package:nakha/features/notifications/domain/repositories/base_notifications_repo.dart';

class NotificationsRepositoryImpl implements BaseNotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse<List<NotificationsModel>>>>
  getNotifications(PaginationParameters parameters) async {
    try {
      final response = await remoteDataSource.getNotifications(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
