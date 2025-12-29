import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/domain/use_cases/contact_us_usecase.dart';
import 'package:nakha/features/profile/domain/use_cases/get_my_invoices_usecase.dart';
import 'package:nakha/features/profile/domain/use_cases/get_profile_usecase.dart';
import 'package:nakha/features/profile/domain/use_cases/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.getMyInvoicesUseCase,
    this.contactUsUseCase,
  ) : super(const ProfileState()) {
    on<GetProfileEvent>(_onGetProfileEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<GetMyInvoicesEvent>(_onGetMyInvoicesEvent);
    on<ContactUsEvent>(_onContactUsEvent);
  }

  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetMyInvoicesUseCase getMyInvoicesUseCase;
  final ContactUsUseCase contactUsUseCase;

  static ProfileBloc get(BuildContext context) =>
      BlocProvider.of<ProfileBloc>(context);

  FutureOr<void> _onGetProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (AppConst.user == null) return;
    emit(state.copyWith(getProfileState: RequestState.loading));

    final result = await getProfileUseCase(const NoParameters());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getProfileState: RequestState.error,
            getProfileResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        // sl<MainSecureStorage>().putIsVerified(data.data!.isProfileCompleted);
        sl<MainSecureStorage>().saveUserData(data.data!);
        emit(
          state.copyWith(
            getProfileState: RequestState.loaded,
            getProfileResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(updateProfileState: RequestState.loading));

    final result = await updateProfileUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            updateProfileState: RequestState.error,
            updateProfileResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        sl<MainSecureStorage>().saveUserData(data.data!);
        emit(
          state.copyWith(
            updateProfileState: RequestState.loaded,
            updateProfileResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onGetMyInvoicesEvent(
    GetMyInvoicesEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        getMyInvoicesState: RequestState.loading,
        invoicesParameters: event.parameters,
      ),
    );

    final result = await getMyInvoicesUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getMyInvoicesState: RequestState.error,
            getMyInvoicesResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getMyInvoicesState: RequestState.loaded,
            getMyInvoicesResponse: event.parameters.page == 1
                ? data
                : state.getMyInvoicesResponse.copyWith(
                    data: [...state.getMyInvoicesResponse.data!, ...data.data!],
                    pagination: data.pagination,
                  ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onContactUsEvent(
    ContactUsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(contactUsState: RequestState.loading));

    final result = await contactUsUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            contactUsState: RequestState.error,
            contactUsResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            contactUsState: RequestState.loaded,
            contactUsResponse: data,
          ),
        );
      },
    );
  }
}
