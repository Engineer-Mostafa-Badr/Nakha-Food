import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/services/pusher/pusher_service.dart';
import 'package:nakha/core/services/pusher/utils/pusher_constant.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/chat/domain/use_cases/get_chats_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/show_chat_usecase.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc(
    this.getChatsUseCase,
    this.showChatsUseCase,
    this.sendMessageUseCase,
  ) : super(const ChatsState()) {
    chatsScrollController = ScrollController();
    on<GetChatsEvent>(_onGetChatsEvent);
    on<MakeChatAsSeenEvent>(_onMakeChatAsSeenEvent);
    on<ShowChatEvent>(_onShowChatEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<ConnectToChatSocketEvent>(_onConnectToChatSocketEvent);
    on<NewMessageReceivedEvent>(_onNewMessageReceivedEvent);
    on<MakeAllMessagesAsSeenEvent>(_onMakeAllMessagesAsSeenEvent);
  }

  static ChatsBloc get(BuildContext context) =>
      BlocProvider.of<ChatsBloc>(context);

  final ChatsUseCase getChatsUseCase;
  final ShowChatsUseCase showChatsUseCase;
  final SendMessageUseCase sendMessageUseCase;
  bool thereIsNewMessage = false;
  late final ScrollController chatsScrollController;

  FutureOr<void> _onGetChatsEvent(
    GetChatsEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(
      state.copyWith(
        parameters: event.parameters,
        getChatsState: RequestState.loading,
      ),
    );

    final result = await getChatsUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getChatsState: RequestState.error,
            getChatsResponse: state.getChatsResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getChatsState: RequestState.loaded,
            getChatsResponse: event.parameters.page == 1
                ? data
                : state.getChatsResponse.copyWith(
                    data: [...state.getChatsResponse.data!, ...data.data!],
                    pagination: data.pagination,
                  ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onMakeChatAsSeenEvent(
    MakeChatAsSeenEvent event,
    Emitter<ChatsState> emit,
  ) {
    emit(state.copyWith(getChatsState: RequestState.loading));
    final chats = List<ChatsModel>.from(
      state.getChatsResponse.data ?? const [],
    );
    final index = chats.indexWhere((c) => c.id == event.chatId);
    if (index != -1) {
      chats[index] = chats[index].copyWith(unreadMessages: 0);
      emit(
        state.copyWith(
          getChatsState: RequestState.loaded,
          getChatsResponse: state.getChatsResponse.copyWith(data: chats),
        ),
      );
    } else {
      // Optional: go back to loaded to avoid stuck loading
      emit(state.copyWith(getChatsState: RequestState.loaded));
    }
  }

  FutureOr<void> _onShowChatEvent(
    ShowChatEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(
      state.copyWith(
        showChatParameters: event.parameters,
        showChatState: RequestState.loading,
      ),
    );

    final result = await showChatsUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            showChatState: RequestState.error,
            showChatResponse: state.showChatResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        add(ConnectToChatSocketEvent(data.data!.id));
        emit(
          state.copyWith(
            showChatState: RequestState.loaded,
            showChatResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onSendMessageEvent(
    SendMessageEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(state.copyWith(sendMessageState: RequestState.loading));

    final result = await sendMessageUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            sendMessageState: RequestState.error,
            sendMessageResponse: state.sendMessageResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            sendMessageState: RequestState.loaded,
            sendMessageResponse: data,
          ),
        );
      },
    );
  }

  // Pusher service instance for real-time chat
  PusherServices? _pusherServices;

  /// Connects to Pusher channel for real-time chat messages
  /// Listens to incoming events and dispatches appropriate bloc events
  FutureOr<void> _onConnectToChatSocketEvent(
    ConnectToChatSocketEvent event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      // Initialize pusher service with chat channel
      _pusherServices = PusherServices(
        chatChannelName: PusherConstant.orderChatChannel(
          event.appointmentId.toString(),
        ),
        onEvent: (pusherEvent) {
          try {
            // Log event details for debugging
            MostUsedFunctions.printFullText(
              'Chat Event: ${pusherEvent.channelName}\n'
              'Data: ${pusherEvent.data}\n'
              'Event Name: ${pusherEvent.eventName}',
            );

            // Ignore subscription success events or null data
            if (pusherEvent.eventName == 'pusher:subscription_succeeded' ||
                pusherEvent.data == null) {
              return;
            }

            // Verify the event is for the correct channel
            if (!pusherEvent.channelName.contains(
              PusherConstant.orderChatChannel(event.appointmentId.toString()),
            )) {
              return;
            }

            // Parse the incoming message data
            final Map<String, dynamic> jsonData = json.decode(
              pusherEvent.data!,
            );
            final Map<String, dynamic> messageData = jsonData['message'];

            // Convert to message model
            final MessagesModel message = MessagesModel.fromJson(messageData);

            // Handle message based on chat type
            if (event.isSupportChat) {
              add(NewSupportMessageReceivedEvent(message));
            } else {
              // Mark messages as seen if from other user
              if (AppConst.userId != message.sender.id) {
                add(const MakeAllMessagesAsSeenEvent());
              } else {
                MostUsedFunctions.printFullText(
                  'Own message received via socket, not marking as seen.',
                );
              }
              add(NewMessageReceivedEvent(message));
            }
          } catch (e) {
            MostUsedFunctions.printFullText('Error parsing chat event: $e');
          }
        },
      );
    } catch (e) {
      MostUsedFunctions.printFullText('Error connecting to chat socket: $e');
    }
  }

  // NEW: Handle messages in a separate event handler (safe to emit here)
  FutureOr<void> _onNewMessageReceivedEvent(
    NewMessageReceivedEvent event,
    Emitter<ChatsState> emit,
  ) {
    emit(state.copyWith(showChatState: RequestState.loading));
    thereIsNewMessage = true;

    final currentMessages =
        state.showChatResponse.data?.messages ?? const <MessagesModel>[];

    // Always copy the list to keep state immutable
    final updatedMessages = List<MessagesModel>.from(currentMessages)
      ..add(event.message);

    final updatedShowChatResponse = state.showChatResponse.copyWith(
      data: state.showChatResponse.data?.copyWith(messages: updatedMessages),
    );

    emit(
      state.copyWith(
        showChatState: RequestState.loaded,
        showChatResponse: updatedShowChatResponse,
      ),
    );
  }

  FutureOr<void> _onMakeAllMessagesAsSeenEvent(
    MakeAllMessagesAsSeenEvent event,
    Emitter<ChatsState> emit,
  ) {
    emit(state.copyWith(showChatState: RequestState.loading));
    final messages = state.showChatResponse.data?.messages ?? [];
    final updatedMessages = messages
        .map((msg) => msg.isRead == false ? msg.copyWith(isRead: true) : msg)
        .toList();

    final updatedShowChatResponse = state.showChatResponse.copyWith(
      data: state.showChatResponse.data?.copyWith(messages: updatedMessages),
    );

    emit(
      state.copyWith(
        showChatState: RequestState.loaded,
        showChatResponse: updatedShowChatResponse,
      ),
    );
  }

  /// Clean up resources when bloc is disposed
  @override
  Future<void> close() async {
    // Disconnect from pusher service
    _pusherServices?.disconnectFromPusher();
    chatsScrollController.dispose();
    return super.close();
  }
}
