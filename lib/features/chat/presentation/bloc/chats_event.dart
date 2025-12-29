part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();
}

final class GetChatsEvent extends ChatsEvent {
  const GetChatsEvent({this.parameters = const GetChatsParameters()});

  final GetChatsParameters parameters;

  @override
  List<Object?> get props => [parameters];
}

final class MakeChatAsSeenEvent extends ChatsEvent {
  const MakeChatAsSeenEvent({required this.chatId});

  final int chatId;

  @override
  List<Object?> get props => [chatId];
}

final class ShowChatEvent extends ChatsEvent {
  const ShowChatEvent({required this.parameters});

  final ShowChatParameters parameters;

  @override
  List<Object?> get props => [parameters];
}

final class SendMessageEvent extends ChatsEvent {
  const SendMessageEvent({required this.parameters});

  final SendMessageParameters parameters;

  @override
  List<Object?> get props => [parameters];
}

final class ConnectToChatSocketEvent extends ChatsEvent {
  const ConnectToChatSocketEvent(
    this.appointmentId, {
    this.isSupportChat = false,
  });

  final int appointmentId;
  final bool isSupportChat;

  @override
  List<Object?> get props => [appointmentId, isSupportChat];
}

final class NewMessageReceivedEvent extends ChatsEvent {
  const NewMessageReceivedEvent(this.message);

  final MessagesModel message;

  @override
  List<Object?> get props => [message];
}

final class MakeAllMessagesAsSeenEvent extends ChatsEvent {
  const MakeAllMessagesAsSeenEvent();

  @override
  List<Object?> get props => [];
}

final class NewSupportMessageReceivedEvent extends ChatsEvent {
  const NewSupportMessageReceivedEvent(this.message);

  final MessagesModel message;

  @override
  List<Object?> get props => [message];
}
