part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final RequestState getNotificationsState;
  final BaseResponse<List<NotificationsModel>> getNotificationsResponse;

  const NotificationsState({
    this.getNotificationsState = RequestState.initial,
    this.getNotificationsResponse = const BaseResponse(),
  });

  NotificationsState copyWith({
    RequestState? getNotificationsState,
    BaseResponse<List<NotificationsModel>>? getNotificationsResponse,
  }) {
    return NotificationsState(
      getNotificationsState:
          getNotificationsState ?? this.getNotificationsState,
      getNotificationsResponse:
          getNotificationsResponse ?? this.getNotificationsResponse,
    );
  }

  @override
  List<Object> get props => [getNotificationsState, getNotificationsResponse];
}
