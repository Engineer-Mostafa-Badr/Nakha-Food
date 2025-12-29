part of 'favourite_providers_bloc.dart';

final class FavouriteProvidersState extends Equatable {
  const FavouriteProvidersState({
    /// get providers state
    this.getFavouriteProvidersState = RequestState.loading,
    this.getFavouriteProvidersResponse = const BaseResponse(),
    this.getFavouriteProvidersParameters = const FavouriteProvidersParameters(),

    /// toggle favourite providers state
    this.toggleFavouriteProvidersState = RequestState.initial,
    this.toggleFavouriteProvidersResponse = const BaseResponse(),
  });

  /// get providers state
  final RequestState getFavouriteProvidersState;
  final BaseResponse<List<ProvidersModel>> getFavouriteProvidersResponse;
  final FavouriteProvidersParameters getFavouriteProvidersParameters;

  /// toggle favourite providers state
  final RequestState toggleFavouriteProvidersState;
  final BaseResponse<ProvidersModel> toggleFavouriteProvidersResponse;

  FavouriteProvidersState copyWith({
    /// get providers state
    RequestState? getFavouriteProvidersState,
    BaseResponse<List<ProvidersModel>>? getFavouriteProvidersResponse,
    FavouriteProvidersParameters? getFavouriteProvidersParameters,

    /// toggle favourite providers state
    RequestState toggleFavouriteProvidersState = RequestState.initial,
    BaseResponse<ProvidersModel> toggleFavouriteProvidersResponse =
        const BaseResponse<ProvidersModel>(),
  }) {
    return FavouriteProvidersState(
      /// get providers state
      getFavouriteProvidersState:
          getFavouriteProvidersState ?? this.getFavouriteProvidersState,
      getFavouriteProvidersResponse:
          getFavouriteProvidersResponse ?? this.getFavouriteProvidersResponse,
      getFavouriteProvidersParameters:
          getFavouriteProvidersParameters ??
          this.getFavouriteProvidersParameters,

      /// toggle favourite providers state
      toggleFavouriteProvidersState: toggleFavouriteProvidersState,
      toggleFavouriteProvidersResponse: toggleFavouriteProvidersResponse,
    );
  }

  @override
  List<Object> get props => [
    /// get provider profile state
    getFavouriteProvidersState,
    getFavouriteProvidersResponse,
    getFavouriteProvidersParameters,

    /// toggle favourite providers state
    toggleFavouriteProvidersState,
    toggleFavouriteProvidersResponse,
  ];
}
