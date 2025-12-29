part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();
}

final class OrdersFetchEvent extends OrdersEvent {
  const OrdersFetchEvent({this.params = const OrdersParameters()});

  final OrdersParameters params;

  @override
  List<Object> get props => [params];
}

final class AddToCartEvent extends OrdersEvent {
  const AddToCartEvent(this.params);

  final AddToCartParameters params;

  @override
  List<Object> get props => [params];
}

final class GetCartEvent extends OrdersEvent {
  const GetCartEvent();

  @override
  List<Object> get props => [];
}

final class UpdateToCartEvent extends OrdersEvent {
  const UpdateToCartEvent(this.params);

  final UpdateToCartParameters params;

  @override
  List<Object> get props => [params];
}

final class CheckoutCartEvent extends OrdersEvent {
  const CheckoutCartEvent(this.params);

  final CheckoutCartParameters params;

  @override
  List<Object> get props => [params];
}

final class ShowOrderEvent extends OrdersEvent {
  const ShowOrderEvent(this.params);

  final ShowOrderParams params;

  @override
  List<Object> get props => [params];
}

final class PayOrderEvent extends OrdersEvent {
  const PayOrderEvent(this.params);

  final PayOrderParameters params;

  @override
  List<Object> get props => [params];
}

final class RateProductsEvent extends OrdersEvent {
  const RateProductsEvent(this.params);

  final AllRatesParams params;

  @override
  List<Object> get props => [params];
}

final class UpdateOrderStatusEvent extends OrdersEvent {
  const UpdateOrderStatusEvent(this.params);

  final UpdateOrderStatusParameters params;

  @override
  List<Object> get props => [params];
}

final class ReplaceOrderEvent extends OrdersEvent {
  const ReplaceOrderEvent(this.order);

  final OrdersModel order;

  @override
  List<Object> get props => [order];
}
