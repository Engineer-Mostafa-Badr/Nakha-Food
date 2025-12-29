part of 'chats_bloc.dart';

class ChatsState extends Equatable {
  const ChatsState({
    /// get chats state
    this.getChatsState = RequestState.loading,
    this.getChatsResponse = const BaseResponse<List<ChatsModel>>(),
    this.parameters = const GetChatsParameters(),

    /// show chat state
    this.showChatState = RequestState.loading,
    this.showChatResponse = const BaseResponse<ShowChatModel>(),
    this.showChatParameters = const ShowChatParameters(receiverId: 0),

    /// send message state
    this.sendMessageState = RequestState.initial,
    this.sendMessageResponse = const BaseResponse<MessagesModel>(),
  });

  /// get chats state
  final RequestState getChatsState;
  final BaseResponse<List<ChatsModel>> getChatsResponse;
  final GetChatsParameters parameters;

  /// show chat state
  final RequestState showChatState;
  final BaseResponse<ShowChatModel> showChatResponse;
  final ShowChatParameters showChatParameters;

  /// send message state
  final RequestState sendMessageState;
  final BaseResponse sendMessageResponse;

  ChatsState copyWith({
    /// get chats state
    RequestState? getChatsState,
    BaseResponse<List<ChatsModel>>? getChatsResponse,
    GetChatsParameters? parameters,

    /// show chat state
    RequestState? showChatState,
    BaseResponse<ShowChatModel>? showChatResponse,
    ShowChatParameters? showChatParameters,

    /// send message state
    RequestState sendMessageState = RequestState.initial,
    BaseResponse? sendMessageResponse,
  }) {
    return ChatsState(
      /// get chats state
      getChatsState: getChatsState ?? this.getChatsState,
      getChatsResponse: getChatsResponse ?? this.getChatsResponse,
      parameters: parameters ?? this.parameters,

      /// show chat state
      showChatState: showChatState ?? this.showChatState,
      showChatResponse: showChatResponse ?? this.showChatResponse,
      showChatParameters: showChatParameters ?? this.showChatParameters,

      /// send message state
      sendMessageState: sendMessageState,
      sendMessageResponse: sendMessageResponse ?? this.sendMessageResponse,
    );
  }

  @override
  List<Object?> get props => [
    /// get chats state
    getChatsState,
    getChatsResponse,
    parameters,

    /// show chat state
    showChatState,
    showChatResponse,
    showChatParameters,

    /// send message state
    sendMessageState,
    sendMessageResponse,
  ];
}
