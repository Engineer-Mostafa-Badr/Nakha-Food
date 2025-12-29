part of 'favourite_providers_bloc.dart';

sealed class FavouriteProvidersEvent extends Equatable {
  const FavouriteProvidersEvent();
}

final class FavouriteProvidersFetchEvent extends FavouriteProvidersEvent {
  const FavouriteProvidersFetchEvent({
    this.params = const FavouriteProvidersParameters(),
  });

  final FavouriteProvidersParameters params;

  @override
  List<Object> get props => [params];
}

final class FavouriteProvidersToggleEvent extends FavouriteProvidersEvent {
  const FavouriteProvidersToggleEvent(this.parameters);

  final ToggleFavouriteProvidersParameters parameters;

  @override
  List<Object> get props => [parameters];
}
