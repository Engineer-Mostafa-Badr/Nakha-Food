import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/wallet/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/wallet/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/wallet/domain/repositories/base_repo.dart';
import 'package:nakha/features/wallet/domain/use_cases/get_wallet_usecase.dart';
import 'package:nakha/features/wallet/presentation/bloc/wallet_bloc.dart';

Future<void> getWalletModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetWalletUseCase>(
    () => GetWalletUseCase(sl<BaseWalletRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseWalletRepository>(
    () => WalletRepositoryImpl(sl<WalletRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<WalletBloc>(() => WalletBloc(sl<GetWalletUseCase>()));
}
