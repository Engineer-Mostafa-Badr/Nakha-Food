part of 'favourite_products_bloc.dart';

sealed class FavouriteProductsEvent extends Equatable {
  const FavouriteProductsEvent();
}

final class FavouriteProductsFetchEvent extends FavouriteProductsEvent {
  const FavouriteProductsFetchEvent({
    this.params = const FavouriteProductsParameters(),
  });

  final FavouriteProductsParameters params;

  @override
  List<Object> get props => [params];
}

final class FavouriteProductsToggleEvent extends FavouriteProductsEvent {
  const FavouriteProductsToggleEvent(this.parameters);

  final ToggleFavouriteProductsParameters parameters;

  @override
  List<Object> get props => [parameters];
}
