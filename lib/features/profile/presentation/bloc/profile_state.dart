part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  /// get profile
  final RequestState getProfileState;
  final BaseResponse<UserModel> getProfileResponse;

  /// update profile
  final RequestState updateProfileState;
  final BaseResponse<UserModel> updateProfileResponse;

  /// get my invoices
  final RequestState getMyInvoicesState;
  final BaseResponse<List<InvoiceModel>> getMyInvoicesResponse;
  final PaginationParameters invoicesParameters;

  /// contact us
  final RequestState contactUsState;
  final BaseResponse contactUsResponse;

  const ProfileState({
    /// get profile
    this.getProfileState = RequestState.loading,
    this.getProfileResponse = const BaseResponse<UserModel>(),

    /// update profile
    this.updateProfileState = RequestState.initial,
    this.updateProfileResponse = const BaseResponse<UserModel>(),

    /// get my invoices
    this.getMyInvoicesState = RequestState.loading,
    this.getMyInvoicesResponse = const BaseResponse<List<InvoiceModel>>(),
    this.invoicesParameters = const PaginationParameters(),

    /// contact us
    this.contactUsState = RequestState.initial,
    this.contactUsResponse = const BaseResponse(),
  });

  ProfileState copyWith({
    /// get profile
    RequestState getProfileState = RequestState.initial,
    BaseResponse<UserModel>? getProfileResponse,

    /// update profile
    RequestState updateProfileState = RequestState.initial,
    BaseResponse<UserModel>? updateProfileResponse,

    /// get my invoices
    RequestState getMyInvoicesState = RequestState.initial,
    BaseResponse<List<InvoiceModel>>? getMyInvoicesResponse,
    PaginationParameters? invoicesParameters,

    /// contact us
    RequestState contactUsState = RequestState.initial,
    BaseResponse? contactUsResponse,
  }) {
    return ProfileState(
      /// get profile
      getProfileState: getProfileState,
      getProfileResponse: getProfileResponse ?? this.getProfileResponse,

      /// update profile
      updateProfileState: updateProfileState,
      updateProfileResponse:
          updateProfileResponse ?? this.updateProfileResponse,

      /// get my invoices
      getMyInvoicesState: getMyInvoicesState,
      getMyInvoicesResponse:
          getMyInvoicesResponse ?? this.getMyInvoicesResponse,
      invoicesParameters: invoicesParameters ?? this.invoicesParameters,

      /// contact us
      contactUsState: contactUsState,
      contactUsResponse: contactUsResponse ?? this.contactUsResponse,
    );
  }

  @override
  List<Object> get props => [
    /// get profile
    getProfileState,
    getProfileResponse,

    /// update profile
    updateProfileState,
    updateProfileResponse,

    /// get my invoices
    getMyInvoicesState,
    getMyInvoicesResponse,
    invoicesParameters,

    /// contact us
    contactUsState,
    contactUsResponse,
  ];
}
