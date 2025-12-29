import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/auth/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/auth/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';
import 'package:nakha/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/login_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/register_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/resend_code_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/social_login_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/verify_use_case.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/injection_container.dart';

Future<void> loginModule() async {
  /// Use Cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<BaseLoginRepository>()),
  );

  sl.registerLazySingleton<SocialLoginUseCase>(
    () => SocialLoginUseCase(sl<BaseLoginRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<BaseLoginRepository>()),
  );

  sl.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(sl<BaseLoginRepository>()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<BaseLoginRepository>()),
  );

  sl.registerLazySingleton<VerifyUseCase>(
    () => VerifyUseCase(sl<BaseLoginRepository>()),
  );

  sl.registerLazySingleton<ResendCodeUseCase>(
    () => ResendCodeUseCase(sl<BaseLoginRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseLoginRepository>(
    () => LoginRepositoryImpl(sl<LoginRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      sl<LoginUseCase>(),
      sl<SocialLoginUseCase>(),
      sl<LogoutUseCase>(),
      sl<DeleteAccountUseCase>(),
      sl<RegisterUseCase>(),
      sl<VerifyUseCase>(),
      sl<ResendCodeUseCase>(),
    ),
  );
}
