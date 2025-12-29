import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/auth/domain/entities/delete_account_params.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/domain/entities/logout_params.dart';
import 'package:nakha/features/auth/domain/entities/register_params.dart';
import 'package:nakha/features/auth/domain/entities/social_login_params.dart';
import 'package:nakha/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/login_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/register_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/resend_code_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/social_login_use_case.dart';
import 'package:nakha/features/auth/domain/use_cases/verify_use_case.dart';
import 'package:nakha/features/injection_container.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final SocialLoginUseCase socialLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final RegisterUseCase registerAsIndividualUseCase;
  final VerifyUseCase verifyUseCase;
  final ResendCodeUseCase resendCodeUseCase;

  static LoginBloc get(BuildContext context) => BlocProvider.of(context);

  LoginBloc(
    this.loginUseCase,
    this.socialLoginUseCase,
    this.logoutUseCase,
    this.deleteAccountUseCase,
    this.registerAsIndividualUseCase,
    this.verifyUseCase,
    this.resendCodeUseCase,
  ) : super(const LoginState()) {
    on<LoginButtonPressedEvent>(_startLogin);
    on<LoginWithSocialButtonPressedEvent>(_startSocialLogin);
    on<LogoutButtonPressedEvent>(_startLogout);
    on<DeleteAccountButtonPressedEvent>(_startDeleteAccount);
    on<RegisterButtonPressedEvent>(_startRegisterAsIndividual);
    on<VerifyButtonPressedEvent>(_startVerify);
    on<ResendCodeButtonPressedEvent>(_startResendCode);
  }

  FutureOr<void> _startLogin(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await loginUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            requestState: RequestState.error,
            response: BaseResponse<UserModel?>(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) async {
        emit(state.copyWith(requestState: RequestState.loaded, response: data));
      },
    );
  }

  FutureOr<void> _startSocialLogin(
    LoginWithSocialButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginWithSocialRequestState: RequestState.loading));
    final result = await socialLoginUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            loginWithSocialRequestState: RequestState.error,
            loginWithSocialResponse: BaseResponse<UserModel?>(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) async {
        emit(
          state.copyWith(
            loginWithSocialRequestState: RequestState.loaded,
            loginWithSocialResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _startLogout(
    LogoutButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(logoutRequestState: RequestState.loading));
    final result = await logoutUseCase(event.parameters);
    result.fold(
      (failure) {
        sl<MainSecureStorage>().logout();
        emit(
          state.copyWith(
            logoutRequestState: RequestState.error,
            logoutResponse: BaseResponse(status: false, msg: failure.message),
          ),
        );
      },
      (data) async {
        sl<MainSecureStorage>().logout();
        emit(
          state.copyWith(
            logoutRequestState: RequestState.loaded,
            logoutResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _startDeleteAccount(
    DeleteAccountButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(deleteAccountRequestState: RequestState.loading));
    final result = await deleteAccountUseCase(event.parameters);
    result.fold(
      (failure) {
        sl<MainSecureStorage>().logout();
        emit(
          state.copyWith(
            deleteAccountRequestState: RequestState.error,
            deleteAccountResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) async {
        sl<MainSecureStorage>().logout();
        emit(
          state.copyWith(
            deleteAccountRequestState: RequestState.loaded,
            deleteAccountResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _startRegisterAsIndividual(
    RegisterButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(registerRequestState: RequestState.loading));
    final result = await registerAsIndividualUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            registerRequestState: RequestState.error,
            registerAsIndividualResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) async {
        // if (event.parameters.type == UserRoleEnum.client.name) {
        //   sl<MainSecureStorage>().login(data.data!);
        // }
        emit(
          state.copyWith(
            registerRequestState: RequestState.loaded,
            registerAsIndividualResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _startVerify(
    VerifyButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(verifyRequestState: RequestState.loading));
    final result = await verifyUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            verifyRequestState: RequestState.error,
            verifyResponse: BaseResponse(status: false, msg: failure.message),
          ),
        );
      },
      (data) async {
        sl<MainSecureStorage>().login(data.data!);
        emit(
          state.copyWith(
            verifyRequestState: RequestState.loaded,
            verifyResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _startResendCode(
    ResendCodeButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(resendRequestState: RequestState.loading));
    final result = await resendCodeUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            resendRequestState: RequestState.error,
            resendResponse: BaseResponse(status: false, msg: failure.message),
          ),
        );
      },
      (data) async {
        emit(
          state.copyWith(
            resendRequestState: RequestState.loaded,
            resendResponse: data,
          ),
        );
      },
    );
  }
}
