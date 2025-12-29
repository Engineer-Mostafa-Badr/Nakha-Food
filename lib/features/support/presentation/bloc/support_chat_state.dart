part of 'support_chat_bloc.dart';

class SupportChatState extends Equatable {
  final RequestState getSupportChatState;
  final BaseResponse<ChatTicketModel> getSupportChatResponse;
  final RequestState sendSupportMessageState;
  final BaseResponse sendSupportMessageResponse;

  /// store ticket
  final RequestState storeTicketState;
  final BaseResponse<TicketModel> storeTicketResponse;

  /// get all tickets
  final RequestState getAllTicketsState;
  final BaseResponse<List<TicketModel>> getAllTicketsResponse;

  /// close ticket
  final RequestState closeTicketState;
  final BaseResponse<CloseTicketParams> closeTicketResponse;

  const SupportChatState({
    this.getSupportChatState = RequestState.initial,
    this.getSupportChatResponse = const BaseResponse(),
    this.sendSupportMessageState = RequestState.initial,
    this.sendSupportMessageResponse = const BaseResponse(),

    /// store ticket
    this.storeTicketState = RequestState.initial,
    this.storeTicketResponse = const BaseResponse(),

    /// get all tickets
    this.getAllTicketsState = RequestState.loading,
    this.getAllTicketsResponse = const BaseResponse(),

    /// close ticket
    this.closeTicketState = RequestState.initial,
    this.closeTicketResponse = const BaseResponse(),
  });

  SupportChatState copyWith({
    RequestState getSupportChatState = RequestState.initial,
    BaseResponse<ChatTicketModel>? getSupportChatResponse,
    RequestState? sendSupportMessageState,
    BaseResponse? sendSupportMessageResponse,

    /// store ticket
    RequestState storeTicketState = RequestState.initial,
    BaseResponse<TicketModel>? storeTicketResponse,

    /// get all tickets
    RequestState getAllTicketsState = RequestState.initial,
    BaseResponse<List<TicketModel>>? getAllTicketsResponse,

    /// close ticket
    RequestState closeTicketState = RequestState.initial,
    BaseResponse<CloseTicketParams>? closeTicketResponse,
  }) {
    return SupportChatState(
      getSupportChatState: getSupportChatState,
      getSupportChatResponse:
          getSupportChatResponse ?? this.getSupportChatResponse,
      sendSupportMessageState:
          sendSupportMessageState ?? this.sendSupportMessageState,
      sendSupportMessageResponse:
          sendSupportMessageResponse ?? this.sendSupportMessageResponse,

      /// store ticket
      storeTicketState: storeTicketState,
      storeTicketResponse: storeTicketResponse ?? this.storeTicketResponse,

      /// get all tickets
      getAllTicketsState: getAllTicketsState,
      getAllTicketsResponse:
          getAllTicketsResponse ?? this.getAllTicketsResponse,

      /// close ticket
      closeTicketState: closeTicketState,
      closeTicketResponse: closeTicketResponse ?? this.closeTicketResponse,
    );
  }

  @override
  List<Object> get props => [
    getSupportChatState,
    getSupportChatResponse,
    sendSupportMessageState,
    sendSupportMessageResponse,

    /// store ticket
    storeTicketState,
    storeTicketResponse,

    /// get all tickets
    getAllTicketsState,
    getAllTicketsResponse,

    /// close ticket
    closeTicketState,
    closeTicketResponse,
  ];
}
