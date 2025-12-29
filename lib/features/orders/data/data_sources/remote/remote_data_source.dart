import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
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

abstract class BaseOrdersRemoteDataSource {
  Future<BaseResponse<OrdersDataModel>> getOrders(OrdersParameters parameters);

  Future<BaseResponse<AddToCartModel>> addToCart(
    AddToCartParameters parameters,
  );

  Future<BaseResponse<CartModel>> getCart();

  Future<BaseResponse<AddToCartModel>> updateToCart(
    UpdateToCartParameters parameters,
  );

  Future<BaseResponse<OrdersModel>> checkoutCart(
    CheckoutCartParameters parameters,
  );

  Future<BaseResponse<OrdersModel>> showOrder(ShowOrderParams parameters);

  Future<BaseResponse<String>> payOrder(PayOrderParameters parameters);

  Future<BaseResponse> rateProducts(AllRatesParams parameters);

  Future<BaseResponse<OrdersModel>> updateOrderStatus(
    UpdateOrderStatusParameters parameters,
  );
}

class OrdersRemoteDataSource extends BaseOrdersRemoteDataSource {
  final ApiConsumer _apiConsumer;

  OrdersRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<OrdersDataModel>> getOrders(
    OrdersParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.ordersList,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<OrdersDataModel>(
        status: response.data[BaseResponse.statusKey],
        data: OrdersDataModel.fromJson(response.data[BaseResponse.dataKey]),
        pagination: PaginationModel.fromJson(
          response.data[BaseResponse.paginationKey],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<AddToCartModel>> addToCart(
    AddToCartParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.addToCart,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<AddToCartModel>(
        status: response.data[BaseResponse.statusKey],
        data: AddToCartModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<CartModel>> getCart() async {
    final response = await _apiConsumer.get(
      EndPoints.cart,
      authenticated: true,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<CartModel>(
        status: response.data[BaseResponse.statusKey],
        data: CartModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<AddToCartModel>> updateToCart(
    UpdateToCartParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.updateToCart,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<AddToCartModel>(
        status: response.data[BaseResponse.statusKey],
        data: AddToCartModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<OrdersModel>> checkoutCart(
    CheckoutCartParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.checkout,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<OrdersModel>(
        status: response.data[BaseResponse.statusKey],
        data: OrdersModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<OrdersModel>> showOrder(
    ShowOrderParams parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.showOrder(parameters.orderId),
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<OrdersModel>(
        status: response.data[BaseResponse.statusKey],
        data: OrdersModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<String>> payOrder(PayOrderParameters parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.payOrder,
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<String>(
        status: response.data[BaseResponse.statusKey],
        data: response.data[BaseResponse.dataKey],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse> rateProducts(AllRatesParams parameters) async {
    final response = await _apiConsumer.post(
      EndPoints.rateProducts(parameters.orderId),
      authenticated: true,
      data: parameters.toJson(),
      formDataIsEnabled: false,
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse(
        status: response.data[BaseResponse.statusKey],
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }

  @override
  Future<BaseResponse<OrdersModel>> updateOrderStatus(
    UpdateOrderStatusParameters parameters,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.updateOrderStatus(parameters.orderId),
      authenticated: true,
      data: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<OrdersModel>(
        status: response.data[BaseResponse.statusKey],
        data: OrdersModel.fromJson(response.data[BaseResponse.dataKey]),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
