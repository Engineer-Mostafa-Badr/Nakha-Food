part of 'favourite_products_bloc.dart';

final class FavouriteProductsState extends Equatable {
  const FavouriteProductsState({
    /// get Products state
    this.getFavouriteProductsState = RequestState.loading,
    this.getFavouriteProductsResponse = const BaseResponse(),
    this.getFavouriteProductsParameters = const FavouriteProductsParameters(),

    /// toggle favourite Products state
    this.toggleFavouriteProductsState = RequestState.initial,
    this.toggleFavouriteProductsResponse = const BaseResponse(),
  });

  /// get Products state
  final RequestState getFavouriteProductsState;
  final BaseResponse<List<ProductsModel>> getFavouriteProductsResponse;
  final FavouriteProductsParameters getFavouriteProductsParameters;

  /// toggle favourite Products state
  final RequestState toggleFavouriteProductsState;
  final BaseResponse<ProductsModel> toggleFavouriteProductsResponse;

  FavouriteProductsState copyWith({
    /// get Products state
    RequestState? getFavouriteProductsState,
    BaseResponse<List<ProductsModel>>? getFavouriteProductsResponse,
    FavouriteProductsParameters? getFavouriteProductsParameters,

    /// toggle favourite Products state
    RequestState toggleFavouriteProductsState = RequestState.initial,
    BaseResponse<ProductsModel> toggleFavouriteProductsResponse =
        const BaseResponse<ProductsModel>(),
  }) {
    return FavouriteProductsState(
      /// get Products state
      getFavouriteProductsState:
          getFavouriteProductsState ?? this.getFavouriteProductsState,
      getFavouriteProductsResponse:
          getFavouriteProductsResponse ?? this.getFavouriteProductsResponse,
      getFavouriteProductsParameters:
          getFavouriteProductsParameters ?? this.getFavouriteProductsParameters,

      /// toggle favourite Products state
      toggleFavouriteProductsState: toggleFavouriteProductsState,
      toggleFavouriteProductsResponse: toggleFavouriteProductsResponse,
    );
  }

  @override
  List<Object> get props => [
    /// get provider profile state
    getFavouriteProductsState,
    getFavouriteProductsResponse,
    getFavouriteProductsParameters,

    /// toggle favourite Products state
    toggleFavouriteProductsState,
    toggleFavouriteProductsResponse,
  ];
}
