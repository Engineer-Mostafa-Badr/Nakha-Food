part of 'orders_bloc.dart';

final class OrdersState extends Equatable {
  const OrdersState({
    /// get providers state
    this.getOrdersState = RequestState.loading,
    this.getOrdersResponse = const BaseResponse(),
    this.getOrdersParameters = const OrdersParameters(),

    /// add to cart state
    this.addToCartState = RequestState.initial,
    this.addToCartResponse = const BaseResponse(),

    /// get cart state
    this.getCartState = RequestState.loading,
    this.getCartResponse = const BaseResponse(),

    /// update to cart state
    this.updateToCartState = RequestState.initial,
    this.updateToCartResponse = const BaseResponse(),

    /// checkout cart state
    this.checkoutCartState = RequestState.initial,
    this.checkoutCartResponse = const BaseResponse(),

    /// show order state
    this.showOrderState = RequestState.loading,
    this.showOrderResponse = const BaseResponse(),

    /// pay order state
    this.payOrderState = RequestState.initial,
    this.payOrderResponse = const BaseResponse(),

    /// rate products state
    this.rateProductsState = RequestState.initial,
    this.rateProductsResponse = const BaseResponse(),

    /// update order status state
    this.updateOrderStatusState = RequestState.initial,
    this.updateOrderStatusResponse = const BaseResponse(),
    this.updateOrderStatusParameters,
  });

  /// get providers state
  final RequestState getOrdersState;
  final BaseResponse<OrdersDataModel> getOrdersResponse;
  final OrdersParameters getOrdersParameters;

  /// add to cart state
  final RequestState addToCartState;

  final BaseResponse<AddToCartModel> addToCartResponse;

  /// get cart state
  final RequestState getCartState;
  final BaseResponse<CartModel> getCartResponse;

  /// update to cart state
  final RequestState updateToCartState;

  final BaseResponse<AddToCartModel> updateToCartResponse;

  /// checkout cart state
  final RequestState checkoutCartState;
  final BaseResponse<OrdersModel> checkoutCartResponse;

  /// show order state
  final RequestState showOrderState;
  final BaseResponse<OrdersModel> showOrderResponse;

  /// pay order state
  final RequestState payOrderState;
  final BaseResponse<String> payOrderResponse;

  /// rate products state
  final RequestState rateProductsState;

  final BaseResponse rateProductsResponse;

  /// update order status state
  final RequestState updateOrderStatusState;
  final BaseResponse<OrdersModel> updateOrderStatusResponse;
  final UpdateOrderStatusParameters? updateOrderStatusParameters;

  OrdersState copyWith({
    /// get providers state
    RequestState? getOrdersState,
    BaseResponse<OrdersDataModel>? getOrdersResponse,
    OrdersParameters? getOrdersParameters,

    /// add to cart state
    RequestState addToCartState = RequestState.initial,
    BaseResponse<AddToCartModel>? addToCartResponse,

    /// get cart state
    RequestState? getCartState,
    BaseResponse<CartModel>? getCartResponse,

    /// update to cart state
    RequestState updateToCartState = RequestState.initial,
    BaseResponse<AddToCartModel>? updateToCartResponse,

    /// checkout cart state
    RequestState checkoutCartState = RequestState.initial,
    BaseResponse<OrdersModel>? checkoutCartResponse,

    /// show order state
    RequestState? showOrderState,
    BaseResponse<OrdersModel>? showOrderResponse,

    /// pay order state
    RequestState payOrderState = RequestState.initial,
    BaseResponse<String>? payOrderResponse,

    /// rate products state
    RequestState rateProductsState = RequestState.initial,
    BaseResponse? rateProductsResponse,

    /// update order status state
    RequestState updateOrderStatusState = RequestState.initial,
    BaseResponse<OrdersModel>? updateOrderStatusResponse,
    UpdateOrderStatusParameters? updateOrderStatusParameters,
  }) {
    return OrdersState(
      /// get providers state
      getOrdersState: getOrdersState ?? this.getOrdersState,
      getOrdersResponse: getOrdersResponse ?? this.getOrdersResponse,
      getOrdersParameters: getOrdersParameters ?? this.getOrdersParameters,

      /// add to cart state
      addToCartState: addToCartState,
      addToCartResponse: addToCartResponse ?? this.addToCartResponse,

      /// get cart state
      getCartState: getCartState ?? this.getCartState,
      getCartResponse: getCartResponse ?? this.getCartResponse,

      /// update to cart state
      updateToCartState: updateToCartState,
      updateToCartResponse: updateToCartResponse ?? this.updateToCartResponse,

      /// checkout cart state
      checkoutCartState: checkoutCartState,
      checkoutCartResponse: checkoutCartResponse ?? this.checkoutCartResponse,

      /// show order state
      showOrderState: showOrderState ?? this.showOrderState,
      showOrderResponse: showOrderResponse ?? this.showOrderResponse,

      /// pay order state
      payOrderState: payOrderState,
      payOrderResponse: payOrderResponse ?? this.payOrderResponse,

      /// rate products state
      rateProductsState: rateProductsState,
      rateProductsResponse: rateProductsResponse ?? this.rateProductsResponse,

      /// update order status state
      updateOrderStatusState: updateOrderStatusState,
      updateOrderStatusResponse:
          updateOrderStatusResponse ?? this.updateOrderStatusResponse,
      updateOrderStatusParameters:
          updateOrderStatusParameters ?? this.updateOrderStatusParameters,
    );
  }

  @override
  List<Object?> get props => [
    /// get provider profile state
    getOrdersState,
    getOrdersResponse,
    getOrdersParameters,

    /// add to cart state
    addToCartState,
    addToCartResponse,

    /// get cart state
    getCartState,
    getCartResponse,

    /// update to cart state
    updateToCartState,
    updateToCartResponse,

    /// checkout cart state
    checkoutCartState,
    checkoutCartResponse,

    /// show order state
    showOrderState,
    showOrderResponse,

    /// pay order state
    payOrderState,
    payOrderResponse,

    /// rate products state
    rateProductsState,
    rateProductsResponse,

    /// update order status state
    updateOrderStatusState,
    updateOrderStatusResponse,
    updateOrderStatusParameters,
  ];
}
