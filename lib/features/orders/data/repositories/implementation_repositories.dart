import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/orders/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/orders/data/models/add_to_cart_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';
import 'package:nakha/features/orders/domain/use_cases/add_products_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/add_to_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/checkout_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/get_orders_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/pay_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_to_cart_usecase.dart';

class OrdersRepositoryImpl implements BaseOrdersRepository {
  OrdersRepositoryImpl(this.remoteDataSource);

  final OrdersRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseResponse<OrdersDataModel>>> getOrders(
    OrdersParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getOrders(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddToCartModel>>> addToCart(
    AddToCartParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.addToCart(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CartModel>>> getCart() async {
    try {
      final response = await remoteDataSource.getCart();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddToCartModel>>> updateToCart(
    UpdateToCartParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.updateToCart(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<OrdersModel>>> checkoutCart(
    CheckoutCartParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.checkoutCart(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<OrdersModel>>> showOrder(
    ShowOrderParams parameters,
  ) async {
    try {
      final response = await remoteDataSource.showOrder(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> payOrder(
    PayOrderParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.payOrder(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> rateProducts(
    AllRatesParams parameters,
  ) async {
    try {
      final response = await remoteDataSource.rateProducts(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<OrdersModel>>> updateOrderStatus(
    UpdateOrderStatusParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.updateOrderStatus(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
