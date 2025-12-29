import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';
import 'package:nakha/features/wallet/domain/use_cases/get_wallet_usecase.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc(this.getWalletUseCase) : super(const WalletState()) {
    scrollController = ScrollController();
    on<WalletFetchEvent>(_onWalletFetchEvent);
  }

  final GetWalletUseCase getWalletUseCase;
  late final ScrollController scrollController;

  static WalletBloc get(BuildContext context) =>
      BlocProvider.of<WalletBloc>(context);

  FutureOr<void> _onWalletFetchEvent(
    WalletFetchEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(
      state.copyWith(
        getWalletState: RequestState.loading,
        getWalletParameters: event.params,
      ),
    );

    final result = await getWalletUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getWalletState: RequestState.error,
            getWalletResponse: state.getWalletResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getWalletState: RequestState.loaded,
            getWalletResponse: data.copyWith(
              data: data.data!.copyWith(
                id: data.data!.id,
                balance: data.data!.balance,
                transactions: event.params.page > 1
                    ? [
                        ...state.getWalletResponse.data!.transactions,
                        ...data.data!.transactions,
                      ]
                    : data.data!.transactions,
              ),
              pagination: data.pagination,
            ),
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
