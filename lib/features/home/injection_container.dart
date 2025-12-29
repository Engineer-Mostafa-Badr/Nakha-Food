import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/home/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/home/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/home/domain/repositories/base_home_repo.dart';
import 'package:nakha/features/home/domain/use_cases/generate_new_pay_link_usecase.dart';
import 'package:nakha/features/home/domain/use_cases/get_categories_usecase.dart';
import 'package:nakha/features/home/domain/use_cases/get_home_utils_usecase.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/injection_container.dart';

Future<void> getHomeModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetHomeUtilsUseCase>(
    () => GetHomeUtilsUseCase(sl<BaseHomeRepository>()),
  );
  sl.registerLazySingleton<GenerateNewPayLinkUseCase>(
    () => GenerateNewPayLinkUseCase(sl<BaseHomeRepository>()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<BaseHomeRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseHomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl<GetHomeUtilsUseCase>(),
      sl<GenerateNewPayLinkUseCase>(),
      sl<GetCategoriesUseCase>(),
    ),
  );
}
