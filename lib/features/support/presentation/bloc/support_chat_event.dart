part of 'support_chat_bloc.dart';

sealed class SupportChatEvent extends Equatable {
  const SupportChatEvent();
}

class SupportChatFetchEvent extends SupportChatEvent {
  final int packageId;

  const SupportChatFetchEvent(this.packageId);

  @override
  List<Object?> get props => [packageId];
}

class SendSupportMessageEvent extends SupportChatEvent {
  final SendSupportMessageParams params;

  const SendSupportMessageEvent(this.params);

  @override
  List<Object> get props => [params];
}

class SupportChatFetchPusherEvent extends SupportChatEvent {
  const SupportChatFetchPusherEvent();

  @override
  List<Object> get props => [];
}

class StoreTicketEvent extends SupportChatEvent {
  final StoreTicketParams params;

  const StoreTicketEvent(this.params);

  @override
  List<Object> get props => [params];
}

class GetAllTicketsEvent extends SupportChatEvent {
  final PaginationParameters parameters;

  const GetAllTicketsEvent({this.parameters = const PaginationParameters()});

  @override
  List<Object> get props => [parameters];
}

class UpdateTicketsLocalEvent extends SupportChatEvent {
  final List<TicketModel> tickets;

  const UpdateTicketsLocalEvent(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class CloseTicketEvent extends SupportChatEvent {
  final CloseTicketParams params;

  const CloseTicketEvent(this.params);

  @override
  List<Object> get props => [params];
}
