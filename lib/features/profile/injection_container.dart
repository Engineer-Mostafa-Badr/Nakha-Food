import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/profile/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/profile/domain/repositories/base_profile_repo.dart';
import 'package:nakha/features/profile/domain/use_cases/contact_us_usecase.dart';
import 'package:nakha/features/profile/domain/use_cases/get_my_invoices_usecase.dart';
import 'package:nakha/features/profile/domain/use_cases/get_profile_usecase.dart';
import 'package:nakha/features/profile/domain/use_cases/update_profile_usecase.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

Future<void> getProfileModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl<BaseProfileRepository>()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl<BaseProfileRepository>()),
  );
  sl.registerLazySingleton<GetMyInvoicesUseCase>(
    () => GetMyInvoicesUseCase(sl<BaseProfileRepository>()),
  );
  sl.registerLazySingleton<ContactUsUseCase>(
    () => ContactUsUseCase(sl<BaseProfileRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseProfileRepository>(
    () => ProfileRepositoryImpl(sl<ProfileRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      sl<GetProfileUseCase>(),
      sl<UpdateProfileUseCase>(),
      sl<GetMyInvoicesUseCase>(),
      sl<ContactUsUseCase>(),
    ),
  );
}
