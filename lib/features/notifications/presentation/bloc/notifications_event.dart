part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class NotificationsFetchEvent extends NotificationsEvent {
  final PaginationParameters params;

  const NotificationsFetchEvent(this.params);

  @override
  List<Object> get props => [];
}
