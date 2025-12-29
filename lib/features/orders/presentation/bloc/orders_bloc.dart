import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/add_to_cart_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/use_cases/add_products_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/add_to_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/checkout_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/get_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/get_orders_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/pay_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_to_cart_usecase.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc(
    this.getOrdersUseCase,
    this.addToCartUseCase,
    this.getCartUseCase,
    this.updateToCartUseCase,
    this.checkoutCartUseCase,
    this.showOrderUseCase,
    this.payOrderUseCase,
    this.rateProductsUseCase,
    this.updateOrderStatusUseCase,
  ) : super(const OrdersState()) {
    on<OrdersFetchEvent>(_onOrdersFetchEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<GetCartEvent>(_onGetCartEvent);
    on<UpdateToCartEvent>(_onUpdateToCartEvent);
    on<CheckoutCartEvent>(_onCheckoutCartEvent);
    on<ShowOrderEvent>(_onShowOrderEvent);
    on<PayOrderEvent>(_onPayOrderEvent);
    on<RateProductsEvent>(_onRateProductsEvent);
    on<UpdateOrderStatusEvent>(_onUpdateOrderStatusEvent);
    on<ReplaceOrderEvent>(_onReplaceOrderEvent);
  }

  final GetOrdersUseCase getOrdersUseCase;
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final UpdateToCartUseCase updateToCartUseCase;
  final CheckoutCartUseCase checkoutCartUseCase;
  final ShowOrderUseCase showOrderUseCase;
  final PayOrderUseCase payOrderUseCase;
  final RateProductsUseCase rateProductsUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;

  static OrdersBloc get(BuildContext context) =>
      BlocProvider.of<OrdersBloc>(context);

  FutureOr<void> _onOrdersFetchEvent(
    OrdersFetchEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(
      state.copyWith(
        getOrdersState: RequestState.loading,
        getOrdersParameters: event.params,
      ),
    );

    final result = await getOrdersUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getOrdersState: RequestState.error,
            getOrdersResponse: state.getOrdersResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getOrdersState: RequestState.loaded,
            getOrdersResponse: data.copyWith(
              data: data.data!.copyWith(
                allOrdersCount: data.data!.allOrdersCount,
                pendingOrders: data.data!.pendingOrders,
                approvedCompletedOrders: data.data!.approvedCompletedOrders,
                cancelledOrders: data.data!.cancelledOrders,
                orders: event.params.page > 1
                    ? [
                        ...state.getOrdersResponse.data!.orders,
                        ...data.data!.orders,
                      ]
                    : data.data!.orders,
              ),
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onAddToCartEvent(
    AddToCartEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(addToCartState: RequestState.loading));
    final result = await addToCartUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            addToCartState: RequestState.error,
            addToCartResponse: state.addToCartResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            addToCartState: RequestState.loaded,
            addToCartResponse: data,
            getCartResponse: BaseResponse<CartModel>(
              status: true,
              msg: 'Added to cart successfully',
              data: data.data?.cart,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onGetCartEvent(
    GetCartEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(getCartState: RequestState.loading));
    final result = await getCartUseCase.call(const NoParameters());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getCartState: RequestState.error,
            getCartResponse: state.getCartResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getCartState: RequestState.loaded,
            getCartResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateToCartEvent(
    UpdateToCartEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(updateToCartState: RequestState.loading));
    final result = await updateToCartUseCase.call(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            updateToCartState: RequestState.error,
            updateToCartResponse: state.updateToCartResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            updateToCartState: RequestState.loaded,
            updateToCartResponse: data,
            getCartResponse: BaseResponse<CartModel>(
              status: true,
              msg: 'Updated cart successfully',
              data: data.data?.cart,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onCheckoutCartEvent(
    CheckoutCartEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(checkoutCartState: RequestState.loading));
    final result = await checkoutCartUseCase.call(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            checkoutCartState: RequestState.error,
            checkoutCartResponse: state.checkoutCartResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            checkoutCartState: RequestState.loaded,
            checkoutCartResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onShowOrderEvent(
    ShowOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(showOrderState: RequestState.loading));
    final result = await showOrderUseCase.call(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            showOrderState: RequestState.error,
            showOrderResponse: state.showOrderResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            showOrderState: RequestState.loaded,
            showOrderResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onPayOrderEvent(
    PayOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(payOrderState: RequestState.loading));
    final result = await payOrderUseCase.call(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            payOrderState: RequestState.error,
            payOrderResponse: state.payOrderResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            payOrderState: RequestState.loaded,
            payOrderResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onRateProductsEvent(
    RateProductsEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(rateProductsState: RequestState.loading));
    final result = await rateProductsUseCase.call(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            rateProductsState: RequestState.error,
            rateProductsResponse: state.rateProductsResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            rateProductsState: RequestState.loaded,
            rateProductsResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateOrderStatusEvent(
    UpdateOrderStatusEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(
      state.copyWith(
        updateOrderStatusParameters: event.params,
        // showOrderState: RequestState.loading,
        updateOrderStatusState: RequestState.loading,
      ),
    );
    final result = await updateOrderStatusUseCase.call(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            updateOrderStatusState: RequestState.error,
            updateOrderStatusResponse: state.updateOrderStatusResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            // showOrderState: RequestState.loaded,
            // showOrderResponse: data,
            updateOrderStatusState: RequestState.loaded,
            updateOrderStatusResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onReplaceOrderEvent(
    ReplaceOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(getOrdersState: RequestState.loading));
    final orders = state.getOrdersResponse.data?.orders ?? [];
    final orderIndex = orders.indexWhere((order) => order.id == event.order.id);
    await Future.delayed(const Duration(milliseconds: 500));
    if (orderIndex != -1) {
      orders[orderIndex] = event.order;
    } else {
      orders.add(event.order);
    }
    emit(
      state.copyWith(
        getOrdersState: RequestState.loaded,
        getOrdersResponse: state.getOrdersResponse.copyWith(
          data: state.getOrdersResponse.data?.copyWith(orders: orders),
        ),
      ),
    );
  }
}
