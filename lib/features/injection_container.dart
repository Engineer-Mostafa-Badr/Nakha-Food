import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/dio_consumer.dart';
import 'package:nakha/core/cubit/app_cubit.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/check_permissions.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/features/auth/injection_container.dart';
import 'package:nakha/features/chat/injection_container.dart';
import 'package:nakha/features/favourite/injection_container.dart';
import 'package:nakha/features/home/injection_container.dart';
import 'package:nakha/features/notifications/injection_container.dart';
import 'package:nakha/features/orders/injection_container.dart';
import 'package:nakha/features/profile/injection_container.dart';
import 'package:nakha/features/providers/injection_container.dart';
import 'package:nakha/features/support/injection_container.dart';
import 'package:nakha/features/wallet/injection_container.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Blocs
  sl.registerFactory<MainAppCubit>(() => MainAppCubit());

  /// Use cases

  /// Repository

  /// Data sources

  /// Features

  /// Core

  /// APIs
  sl.registerFactory(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  /// interceptors
  sl.registerLazySingleton(
    () => PrettyDioLogger(requestBody: true, requestHeader: true),
  );
  sl.registerLazySingleton(() => ImageUtils());

  /// Local
  sl.registerFactory<MainSecureStorage>(() => MainSecureStorage());

  /// Utils
  sl.registerFactory<CheckAppPermissions>(() => CheckAppPermissions());

  /// Features
  loginModule();
  getNotificationsModule();
  getProfileModule();
  getSupportChatModule();
  getHomeModule();
  getProvidersModule();
  getOrdersModule();
  getFavouriteModule();
  getWalletModule();
  getChatsModule();
}
