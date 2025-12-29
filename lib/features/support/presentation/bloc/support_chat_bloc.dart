import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/entities/send_support_message_params.dart';
import 'package:nakha/features/support/domain/use_cases/close_ticket_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/get_all_tickets_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/get_support_chat_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/send_support_message_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/store_ticket_usecase.dart';

part 'support_chat_event.dart';
part 'support_chat_state.dart';

class SupportChatBloc extends Bloc<SupportChatEvent, SupportChatState> {
  final GetSupportChatUseCase getSupportChatUseCase;
  final SendSupportMessageUseCase sendSupportMessageUseCase;
  final StoreTicketUseCase storeTicketUseCase;
  final GetAllTicketsUseCase getAllTicketsUseCase;
  final CloseTicketUseCase closeTicketUseCase;
  late final ScrollController scrollController;

  static SupportChatBloc get(BuildContext context) =>
      BlocProvider.of<SupportChatBloc>(context);

  SupportChatBloc(
    this.getSupportChatUseCase,
    this.sendSupportMessageUseCase,
    this.storeTicketUseCase,
    this.getAllTicketsUseCase,
    this.closeTicketUseCase,
  ) : super(const SupportChatState()) {
    scrollController = ScrollController();
    on<SupportChatFetchEvent>(_onSupportChatFetchEvent);
    on<SendSupportMessageEvent>(_onSendSupportMessageEvent);
    on<StoreTicketEvent>(_onStoreTicketEvent);
    on<GetAllTicketsEvent>(_onGetAllTicketsEvent);
    on<UpdateTicketsLocalEvent>(_onUpdateTicketsLocalEvent);
    on<CloseTicketEvent>(_onCloseTicketEvent);
  }

  FutureOr<void> _onSupportChatFetchEvent(
    SupportChatFetchEvent event,
    Emitter<SupportChatState> emit,
  ) async {
    emit(state.copyWith(getSupportChatState: RequestState.loading));

    final result = await getSupportChatUseCase(event.packageId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getSupportChatState: RequestState.error,
            getSupportChatResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getSupportChatState: RequestState.loaded,
            getSupportChatResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onSendSupportMessageEvent(
    SendSupportMessageEvent event,
    Emitter<SupportChatState> emit,
  ) async {
    emit(state.copyWith(sendSupportMessageState: RequestState.loading));

    final result = await sendSupportMessageUseCase(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            sendSupportMessageState: RequestState.error,
            sendSupportMessageResponse: BaseResponse(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            sendSupportMessageState: RequestState.loaded,
            sendSupportMessageResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onStoreTicketEvent(
    StoreTicketEvent event,
    Emitter<SupportChatState> emit,
  ) async {
    emit(state.copyWith(storeTicketState: RequestState.loading));

    final result = await storeTicketUseCase(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            storeTicketState: RequestState.error,
            storeTicketResponse: state.storeTicketResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            storeTicketState: RequestState.loaded,
            storeTicketResponse: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _onGetAllTicketsEvent(
    GetAllTicketsEvent event,
    Emitter<SupportChatState> emit,
  ) async {
    emit(state.copyWith(getAllTicketsState: RequestState.loading));

    final result = await getAllTicketsUseCase(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getAllTicketsState: RequestState.error,
            getAllTicketsResponse: BaseResponse<List<TicketModel>>(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getAllTicketsState: RequestState.loaded,
            getAllTicketsResponse: event.parameters.page == 1
                ? data
                : state.getAllTicketsResponse.copyWith(
                    data: [...?state.getAllTicketsResponse.data, ...?data.data],
                  ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateTicketsLocalEvent(
    UpdateTicketsLocalEvent event,
    Emitter<SupportChatState> emit,
  ) async {
    emit(
      state.copyWith(
        getAllTicketsState: RequestState.loading,
        getAllTicketsResponse: state.getAllTicketsResponse.copyWith(
          data: event.tickets,
        ),
      ),
    );
    emit(
      state.copyWith(
        getAllTicketsState: RequestState.loaded,
        getAllTicketsResponse: state.getAllTicketsResponse.copyWith(
          data: event.tickets,
        ),
      ),
    );
  }

  FutureOr<void> _onCloseTicketEvent(
    CloseTicketEvent event,
    Emitter<SupportChatState> emit,
  ) async {
    emit(state.copyWith(closeTicketState: RequestState.loading));

    final result = await closeTicketUseCase(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            closeTicketState: RequestState.error,
            closeTicketResponse: state.closeTicketResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            closeTicketState: RequestState.loaded,
            closeTicketResponse: data,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
