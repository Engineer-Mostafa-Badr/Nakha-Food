import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/orders/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';
import 'package:nakha/features/orders/domain/use_cases/add_products_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/add_to_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/checkout_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/get_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/get_orders_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/pay_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_to_cart_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';

Future<void> getOrdersModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetOrdersUseCase>(
    () => GetOrdersUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<UpdateToCartUseCase>(
    () => UpdateToCartUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<CheckoutCartUseCase>(
    () => CheckoutCartUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<ShowOrderUseCase>(
    () => ShowOrderUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<PayOrderUseCase>(
    () => PayOrderUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<RateProductsUseCase>(
    () => RateProductsUseCase(sl<BaseOrdersRepository>()),
  );
  sl.registerLazySingleton<UpdateOrderStatusUseCase>(
    () => UpdateOrderStatusUseCase(sl<BaseOrdersRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseOrdersRepository>(
    () => OrdersRepositoryImpl(sl<OrdersRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<OrdersBloc>(
    () => OrdersBloc(
      sl<GetOrdersUseCase>(),
      sl<AddToCartUseCase>(),
      sl<GetCartUseCase>(),
      sl<UpdateToCartUseCase>(),
      sl<CheckoutCartUseCase>(),
      sl<ShowOrderUseCase>(),
      sl<PayOrderUseCase>(),
      sl<RateProductsUseCase>(),
      sl<UpdateOrderStatusUseCase>(),
    ),
  );
}
