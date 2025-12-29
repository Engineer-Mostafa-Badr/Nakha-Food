part of 'providers_bloc.dart';

final class ProvidersState extends Equatable {
  const ProvidersState({
    /// get providers state
    this.getProvidersState = RequestState.loading,
    this.getProvidersResponse = const BaseResponse(),
    this.getProvidersParameters = const ProvidersParameters(),

    /// get provider profile state
    this.getProviderProfileState = RequestState.loading,
    this.getProviderProfileResponse = const BaseResponse(),

    /// show product state
    this.showProductState = RequestState.loading,
    this.showProductResponse = const BaseResponse(),

    /// get products state
    this.getProductsState = RequestState.loading,
    this.getProductsResponse = const BaseResponse(),
    this.getProductsParameters = const ProductsParameters(),

    /// get vendor products state
    this.getVendorProductsState = RequestState.loading,
    this.getVendorProductsResponse = const BaseResponse(),
    this.getVendorProductsParameters = const PaginationParameters(),

    /// add product state
    this.addProductState = RequestState.initial,
    this.addProductResponse = const BaseResponse(),

    /// update product state
    this.updateProductState = RequestState.initial,
    this.updateProductResponse = const BaseResponse(),

    /// delete product state
    this.deleteProductState = RequestState.initial,
    this.deleteProductResponse = const BaseResponse(),
  });

  /// get providers state
  final RequestState getProvidersState;
  final BaseResponse<List<ProvidersModel>> getProvidersResponse;
  final ProvidersParameters getProvidersParameters;

  /// get provider profile state
  final RequestState getProviderProfileState;
  final BaseResponse<ProviderProfileModel> getProviderProfileResponse;

  /// show product state
  final RequestState showProductState;
  final BaseResponse<ShowProductModel> showProductResponse;

  /// get products state
  final RequestState getProductsState;
  final BaseResponse<List<ProductsModel>> getProductsResponse;
  final ProductsParameters getProductsParameters;

  /// get vendor products state
  final RequestState getVendorProductsState;
  final BaseResponse<List<ProductsModel>> getVendorProductsResponse;
  final PaginationParameters getVendorProductsParameters;

  /// add product state
  final RequestState addProductState;
  final BaseResponse<ProductsModel> addProductResponse;

  /// update product state
  final RequestState updateProductState;
  final BaseResponse<ProductsModel> updateProductResponse;

  /// delete product state
  final RequestState deleteProductState;
  final BaseResponse<int> deleteProductResponse;

  ProvidersState copyWith({
    /// get providers state
    RequestState? getProvidersState,
    BaseResponse<List<ProvidersModel>>? getProvidersResponse,
    ProvidersParameters? getProvidersParameters,

    /// get provider profile state
    RequestState getProviderProfileState = RequestState.initial,
    BaseResponse<ProviderProfileModel>? getProviderProfileResponse,

    /// show product state
    RequestState showProductState = RequestState.initial,
    BaseResponse<ShowProductModel>? showProductResponse,

    /// get products state
    RequestState getProductsState = RequestState.initial,
    BaseResponse<List<ProductsModel>>? getProductsResponse,
    ProductsParameters? getProductsParameters,

    /// get vendor products state
    RequestState getVendorProductsState = RequestState.initial,
    BaseResponse<List<ProductsModel>>? getVendorProductsResponse,
    PaginationParameters? getVendorProductsParameters,

    /// add product state
    RequestState addProductState = RequestState.initial,
    BaseResponse<ProductsModel>? addProductResponse,

    /// update product state
    RequestState updateProductState = RequestState.initial,
    BaseResponse<ProductsModel>? updateProductResponse,

    /// delete product state
    RequestState deleteProductState = RequestState.initial,
    BaseResponse<int>? deleteProductResponse,
  }) {
    return ProvidersState(
      /// get providers state
      getProvidersState: getProvidersState ?? this.getProvidersState,
      getProvidersResponse: getProvidersResponse ?? this.getProvidersResponse,
      getProvidersParameters:
          getProvidersParameters ?? this.getProvidersParameters,

      /// get provider profile state
      getProviderProfileState: getProviderProfileState,
      getProviderProfileResponse:
          getProviderProfileResponse ?? this.getProviderProfileResponse,

      /// show product state
      showProductState: showProductState,
      showProductResponse: showProductResponse ?? this.showProductResponse,

      /// get products state
      getProductsState: getProductsState,
      getProductsResponse: getProductsResponse ?? this.getProductsResponse,
      getProductsParameters:
          getProductsParameters ?? this.getProductsParameters,

      /// get vendor products state
      getVendorProductsState: getVendorProductsState,
      getVendorProductsResponse:
          getVendorProductsResponse ?? this.getVendorProductsResponse,
      getVendorProductsParameters:
          getVendorProductsParameters ?? this.getVendorProductsParameters,

      /// add product state
      addProductState: addProductState,
      addProductResponse: addProductResponse ?? this.addProductResponse,

      /// update product state
      updateProductState: updateProductState,
      updateProductResponse:
          updateProductResponse ?? this.updateProductResponse,

      /// delete product state
      deleteProductState: deleteProductState,
      deleteProductResponse:
          deleteProductResponse ?? this.deleteProductResponse,
    );
  }

  @override
  List<Object> get props => [
    /// get provider profile state
    getProvidersState,
    getProvidersResponse,
    getProvidersParameters,

    /// get provider profile state
    getProviderProfileState,
    getProviderProfileResponse,

    /// show product state
    showProductState,
    showProductResponse,

    /// get products state
    getProductsState,
    getProductsResponse,
    getProductsParameters,

    /// get vendor products state
    getVendorProductsState,
    getVendorProductsResponse,
    getVendorProductsParameters,

    /// add product state
    addProductState,
    addProductResponse,

    /// update product state
    updateProductState,
    updateProductResponse,

    /// delete product state
    deleteProductState,
    deleteProductResponse,
  ];
}
