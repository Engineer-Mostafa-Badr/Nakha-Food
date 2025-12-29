import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/favourite/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/favourite/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/favourite/domain/repositories/base_repo.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_products/favourite_products_bloc.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_providers/favourite_providers_bloc.dart';
import 'package:nakha/features/injection_container.dart';

Future<void> getFavouriteModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetFavouriteProvidersUseCase>(
    () => GetFavouriteProvidersUseCase(sl<BaseFavouriteRepository>()),
  );
  sl.registerLazySingleton<ToggleFavouriteProvidersUseCase>(
    () => ToggleFavouriteProvidersUseCase(sl<BaseFavouriteRepository>()),
  );
  sl.registerLazySingleton<GetFavouriteProductsUseCase>(
    () => GetFavouriteProductsUseCase(sl<BaseFavouriteRepository>()),
  );
  sl.registerLazySingleton<ToggleFavouriteProductsUseCase>(
    () => ToggleFavouriteProductsUseCase(sl<BaseFavouriteRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseFavouriteRepository>(
    () => FavouriteRepositoryImpl(sl<FavouriteRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<FavouriteRemoteDataSource>(
    () => FavouriteRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<FavouriteProvidersBloc>(
    () => FavouriteProvidersBloc(
      sl<GetFavouriteProvidersUseCase>(),
      sl<ToggleFavouriteProvidersUseCase>(),
    ),
  );

  sl.registerFactory<FavouriteProductsBloc>(
    () => FavouriteProductsBloc(
      sl<GetFavouriteProductsUseCase>(),
      sl<ToggleFavouriteProductsUseCase>(),
    ),
  );
}
