part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    /// request home utils
    this.requestUtilsState = RequestState.loading,
    this.responseUtils = const BaseResponse(),

    /// generate new pay link
    this.requestGenerateNewPayLinkState = RequestState.initial,
    this.responseGenerateNewPayLink = const BaseResponse(),

    /// categories
    this.requestCategoriesState = RequestState.loading,
    this.responseCategories = const BaseResponse(),
  });

  /// request home utils
  final RequestState requestUtilsState;
  final BaseResponse<HomeModel> responseUtils;

  /// generate new pay link
  final RequestState requestGenerateNewPayLinkState;
  final BaseResponse<String> responseGenerateNewPayLink;

  /// categories
  final RequestState requestCategoriesState;
  final BaseResponse<List<CategoriesModel>> responseCategories;

  HomeState copyWith({
    /// request home utils
    RequestState? requestUtilsState,
    BaseResponse<HomeModel>? responseUtils,

    /// generate new pay link
    RequestState requestGenerateNewPayLinkState = RequestState.initial,
    BaseResponse<String>? responseGenerateNewPayLink,

    /// categories
    RequestState requestCategoriesState = RequestState.initial,
    BaseResponse<List<CategoriesModel>>? responseCategories,
  }) {
    return HomeState(
      /// request home utils
      requestUtilsState: requestUtilsState ?? this.requestUtilsState,
      responseUtils: responseUtils ?? this.responseUtils,

      /// generate new pay link
      requestGenerateNewPayLinkState: requestGenerateNewPayLinkState,
      responseGenerateNewPayLink:
          responseGenerateNewPayLink ?? this.responseGenerateNewPayLink,

      /// categories
      requestCategoriesState: requestCategoriesState,
      responseCategories: responseCategories ?? this.responseCategories,
    );
  }

  @override
  List<Object?> get props => [
    /// request home utils
    requestUtilsState,
    responseUtils,

    /// generate new pay link
    requestGenerateNewPayLinkState,
    responseGenerateNewPayLink,

    /// categories
    requestCategoriesState,
    responseCategories,
  ];
}
