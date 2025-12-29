import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';

abstract class BaseNotificationsRepository {
  Future<Either<Failure, BaseResponse<List<NotificationsModel>>>>
  getNotifications(PaginationParameters parameters);
}
