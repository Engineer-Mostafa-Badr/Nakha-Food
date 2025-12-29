import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';
import 'package:nakha/features/notifications/domain/use_cases/get_notifications_usecase.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(this.getNotificationsUseCase)
    : super(const NotificationsState()) {
    on<NotificationsFetchEvent>(_onNotificationsFetchEvent);
  }

  final GetNotificationsUseCase getNotificationsUseCase;

  static NotificationsBloc get(BuildContext context) =>
      BlocProvider.of<NotificationsBloc>(context);

  FutureOr<void> _onNotificationsFetchEvent(
    NotificationsFetchEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(getNotificationsState: RequestState.loading));

    final result = await getNotificationsUseCase(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getNotificationsState: RequestState.error,
            getNotificationsResponse: BaseResponse<List<NotificationsModel>>(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getNotificationsState: RequestState.loaded,
            getNotificationsResponse: data.copyWith(
              data:
                  state.getNotificationsResponse.data != null &&
                      event.params.page > 1
                  ? [...state.getNotificationsResponse.data!, ...data.data!]
                  : data.data,
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }
}
