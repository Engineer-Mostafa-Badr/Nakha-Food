import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/providers/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/providers/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/delete_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_provider_profile_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_providers_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_vendor_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/show_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/update_product_usecase.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';

Future<void> getProvidersModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetProvidersUseCase>(
    () => GetProvidersUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<GetProviderProfileUseCase>(
    () => GetProviderProfileUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<ShowProductUseCase>(
    () => ShowProductUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<GetVendorProductsUseCase>(
    () => GetVendorProductsUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(sl<BaseProvidersRepository>()),
  );
  sl.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(sl<BaseProvidersRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseProvidersRepository>(
    () => ProvidersRepositoryImpl(sl<ProvidersRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<ProvidersRemoteDataSource>(
    () => ProvidersRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<ProvidersBloc>(
    () => ProvidersBloc(
      sl<GetProvidersUseCase>(),
      sl<GetProviderProfileUseCase>(),
      sl<ShowProductUseCase>(),
      sl<GetProductsUseCase>(),
      sl<GetVendorProductsUseCase>(),
      sl<AddProductUseCase>(),
      sl<UpdateProductUseCase>(),
      sl<DeleteProductUseCase>(),
    ),
  );
}
