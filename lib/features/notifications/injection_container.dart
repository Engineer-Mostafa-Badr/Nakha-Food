import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/notifications/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/notifications/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/notifications/domain/repositories/base_notifications_repo.dart';
import 'package:nakha/features/notifications/domain/use_cases/get_notifications_usecase.dart';
import 'package:nakha/features/notifications/presentation/bloc/notifications_bloc.dart';

Future<void> getNotificationsModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl<BaseNotificationsRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseNotificationsRepository>(
    () => NotificationsRepositoryImpl(sl<NotificationsRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<NotificationsBloc>(
    () => NotificationsBloc(sl<GetNotificationsUseCase>()),
  );
}
