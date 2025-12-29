part of 'login_bloc.dart';

class LoginState extends Equatable {
  final RequestState requestState;
  final BaseResponse response;
  final RequestState loginWithSocialRequestState;
  final BaseResponse<UserModel?> loginWithSocialResponse;
  final RequestState logoutRequestState;
  final BaseResponse logoutResponse;
  final RequestState deleteAccountRequestState;
  final BaseResponse deleteAccountResponse;
  final RequestState registerRequestState;
  final BaseResponse registerResponse;

  /// Verify
  final BaseResponse<UserModel> verifyResponse;
  final RequestState verifyRequestState;

  /// Resend
  final BaseResponse resendResponse;
  final RequestState resendRequestState;

  const LoginState({
    this.requestState = RequestState.initial,
    this.response = const BaseResponse(),
    this.loginWithSocialRequestState = RequestState.initial,
    this.loginWithSocialResponse = const BaseResponse(),
    this.logoutResponse = const BaseResponse(),
    this.logoutRequestState = RequestState.initial,
    this.deleteAccountRequestState = RequestState.initial,
    this.deleteAccountResponse = const BaseResponse(),
    this.registerRequestState = RequestState.initial,
    this.registerResponse = const BaseResponse(),

    /// Verify
    this.verifyResponse = const BaseResponse(),
    this.verifyRequestState = RequestState.initial,

    /// Resend
    this.resendResponse = const BaseResponse(),
    this.resendRequestState = RequestState.initial,
  });

  LoginState copyWith({
    RequestState requestState = RequestState.initial,
    BaseResponse response = const BaseResponse(),
    RequestState loginWithSocialRequestState = RequestState.initial,
    BaseResponse<UserModel?> loginWithSocialResponse = const BaseResponse(),
    RequestState logoutRequestState = RequestState.initial,
    BaseResponse? logoutResponse,
    RequestState deleteAccountRequestState = RequestState.initial,
    BaseResponse? deleteAccountResponse,
    RequestState registerRequestState = RequestState.initial,
    BaseResponse registerAsIndividualResponse = const BaseResponse(),

    /// Verify
    BaseResponse<UserModel> verifyResponse = const BaseResponse(),
    RequestState verifyRequestState = RequestState.initial,

    /// Resend
    BaseResponse resendResponse = const BaseResponse(),
    RequestState resendRequestState = RequestState.initial,
  }) {
    return LoginState(
      requestState: requestState,
      response: response,
      loginWithSocialRequestState: loginWithSocialRequestState,
      loginWithSocialResponse: loginWithSocialResponse,
      logoutRequestState: logoutRequestState,
      logoutResponse: logoutResponse ?? this.logoutResponse,
      deleteAccountRequestState: deleteAccountRequestState,
      deleteAccountResponse:
          deleteAccountResponse ?? this.deleteAccountResponse,
      registerRequestState: registerRequestState,
      registerResponse: registerAsIndividualResponse,

      /// Verify
      verifyResponse: verifyResponse,
      verifyRequestState: verifyRequestState,

      /// Resend
      resendResponse: resendResponse,
      resendRequestState: resendRequestState,
    );
  }

  @override
  List<Object> get props => [
    requestState,
    response,
    loginWithSocialRequestState,
    loginWithSocialResponse,
    logoutRequestState,
    logoutResponse,
    deleteAccountRequestState,
    deleteAccountResponse,
    registerRequestState,
    registerResponse,

    /// Verify
    verifyResponse,
    verifyRequestState,

    /// Resend
    resendResponse,
    resendRequestState,
  ];
}
