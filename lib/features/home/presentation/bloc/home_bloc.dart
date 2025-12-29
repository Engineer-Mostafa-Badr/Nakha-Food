import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/domain/entities/get_home_utils_params.dart';
import 'package:nakha/features/home/domain/use_cases/generate_new_pay_link_usecase.dart';
import 'package:nakha/features/home/domain/use_cases/get_categories_usecase.dart';
import 'package:nakha/features/home/domain/use_cases/get_home_utils_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static HomeBloc get(BuildContext context) => BlocProvider.of(context);

  final GetHomeUtilsUseCase getHomeUtilsUseCase;
  final GenerateNewPayLinkUseCase generateNewPayLinkUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeBloc(
    this.getHomeUtilsUseCase,
    this.generateNewPayLinkUseCase,
    this.getCategoriesUseCase,
  ) : super(const HomeState()) {
    on<GetHomeUtilsEvent>(_getHomeUtils);
    on<MakeCounterNotificationZeroEvent>(_makeCounterNotificationZero);
    on<GenerateNewPayLinkEvent>(_generateNewPayLink);
    on<GetCategoriesEvent>(_getCategories);
    on<ReplaceProviderEvent>(_replaceProvider);
    on<UpdateHomeUtilsEvent>(_updateHomeUtils);
    on<AddMinusUnreadConversationsEvent>(_addMinusUnreadConversations);
  }

  FutureOr<void> _getHomeUtils(
    GetHomeUtilsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(requestUtilsState: RequestState.loading));
    final result = await getHomeUtilsUseCase(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            requestUtilsState: RequestState.error,
            responseUtils: BaseResponse(status: false, msg: failure.message),
          ),
        );
      },
      (data) {
        AppConst.appInReview = data.data!.appInReview;
        AppConst.absenceAppointmentCost = data.data!.alternateCourseCost;
        emit(
          state.copyWith(
            requestUtilsState: RequestState.loaded,
            responseUtils: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _makeCounterNotificationZero(
    MakeCounterNotificationZeroEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        responseUtils: BaseResponse<HomeModel>(
          data: state.responseUtils.data?.copyWith(unreadNotifications: 0),
        ),
      ),
    );
  }

  FutureOr<void> _generateNewPayLink(
    GenerateNewPayLinkEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(requestGenerateNewPayLinkState: RequestState.loading));
    final result = await generateNewPayLinkUseCase(const NoParameters());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            requestGenerateNewPayLinkState: RequestState.error,
            responseGenerateNewPayLink: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            requestGenerateNewPayLinkState: RequestState.loaded,
            responseGenerateNewPayLink: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getCategories(
    GetCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(requestCategoriesState: RequestState.loading));
    final result = await getCategoriesUseCase(const NoParameters());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            requestCategoriesState: RequestState.error,
            responseCategories: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            requestCategoriesState: RequestState.loaded,
            responseCategories: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _replaceProvider(
    ReplaceProviderEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(requestUtilsState: RequestState.loading));
    final List<ProvidersModel> providers = List.from(
      state.responseUtils.data?.vendors ?? [],
    );
    final int index = providers.indexWhere(
      (provider) => provider.id == event.provider.id,
    );

    if (index != -1) {
      providers[index] = event.provider;
    } else {
      providers.add(event.provider);
    }

    emit(
      state.copyWith(
        requestUtilsState: RequestState.loaded,
        responseUtils: state.responseUtils.copyWith(
          data: state.responseUtils.data?.copyWith(vendors: providers),
        ),
      ),
    );
  }

  FutureOr<void> _updateHomeUtils(
    UpdateHomeUtilsEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        requestUtilsState: RequestState.loaded,
        responseUtils: state.responseUtils.copyWith(data: event.homeUtils),
      ),
    );
  }

  FutureOr<void> _addMinusUnreadConversations(
    AddMinusUnreadConversationsEvent event,
    Emitter<HomeState> emit,
  ) {
    final int currentCount = state.responseUtils.data?.unreadConversations ?? 0;
    final int newCount = event.isAdd
        ? currentCount + 1
        : (currentCount - 1).clamp(0, double.infinity).toInt();

    emit(
      state.copyWith(
        responseUtils: BaseResponse<HomeModel>(
          data: state.responseUtils.data?.copyWith(
            unreadConversations: newCount,
          ),
        ),
      ),
    );
  }
}
