part of 'providers_bloc.dart';

sealed class ProvidersEvent extends Equatable {
  const ProvidersEvent();
}

final class ProvidersFetchEvent extends ProvidersEvent {
  const ProvidersFetchEvent({this.params = const ProvidersParameters()});

  final ProvidersParameters params;

  @override
  List<Object> get props => [params];
}

final class ProviderProfileFetchEvent extends ProvidersEvent {
  const ProviderProfileFetchEvent({required this.params});

  final ProviderProfileParameters params;

  @override
  List<Object> get props => [params];
}

final class ShowProductFetchEvent extends ProvidersEvent {
  const ShowProductFetchEvent({required this.params});

  final ShowProductParameters params;

  @override
  List<Object> get props => [params];
}

final class ReplaceProviderEvent extends ProvidersEvent {
  const ReplaceProviderEvent(this.provider);

  final ProvidersModel provider;

  @override
  List<Object> get props => [provider];
}

final class ReplaceProductEvent extends ProvidersEvent {
  const ReplaceProductEvent(this.product);

  final ProductsModel product;

  @override
  List<Object> get props => [product];
}

final class ProductsFetchEvent extends ProvidersEvent {
  const ProductsFetchEvent({this.params = const ProductsParameters()});

  final ProductsParameters params;

  @override
  List<Object> get props => [params];
}

final class VendorProductsFetchEvent extends ProvidersEvent {
  const VendorProductsFetchEvent({this.params = const PaginationParameters()});

  final PaginationParameters params;

  @override
  List<Object> get props => [params];
}

final class AddProductEvent extends ProvidersEvent {
  const AddProductEvent(this.params);

  final AddProductParameters params;

  @override
  List<Object> get props => [params];
}

final class UpdateProductEvent extends ProvidersEvent {
  const UpdateProductEvent(this.params);

  final AddProductParameters params;

  @override
  List<Object> get props => [params];
}

final class DeleteProductEvent extends ProvidersEvent {
  const DeleteProductEvent(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}
