import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/orders/data/models/add_to_cart_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/use_cases/add_products_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/add_to_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/checkout_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/get_orders_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/pay_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_to_cart_usecase.dart';

abstract class BaseOrdersRepository {
  Future<Either<Failure, BaseResponse<OrdersDataModel>>> getOrders(
    OrdersParameters parameters,
  );

  Future<Either<Failure, BaseResponse<AddToCartModel>>> addToCart(
    AddToCartParameters parameters,
  );

  Future<Either<Failure, BaseResponse<CartModel>>> getCart();

  Future<Either<Failure, BaseResponse<AddToCartModel>>> updateToCart(
    UpdateToCartParameters parameters,
  );

  Future<Either<Failure, BaseResponse<OrdersModel>>> checkoutCart(
    CheckoutCartParameters parameters,
  );

  Future<Either<Failure, BaseResponse<OrdersModel>>> showOrder(
    ShowOrderParams parameters,
  );

  Future<Either<Failure, BaseResponse<String>>> payOrder(
    PayOrderParameters parameters,
  );

  Future<Either<Failure, BaseResponse>> rateProducts(AllRatesParams parameters);

  Future<Either<Failure, BaseResponse<OrdersModel>>> updateOrderStatus(
    UpdateOrderStatusParameters parameters,
  );
}
