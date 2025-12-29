import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_providers_usecase.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

part 'favourite_providers_event.dart';
part 'favourite_providers_state.dart';

class FavouriteProvidersBloc
    extends Bloc<FavouriteProvidersEvent, FavouriteProvidersState> {
  FavouriteProvidersBloc(
    this.getFavouriteProvidersUseCase,
    this.toggleFavouriteProvidersUseCase,
  ) : super(const FavouriteProvidersState()) {
    on<FavouriteProvidersFetchEvent>(_onFavouriteProvidersFetchEvent);
    on<FavouriteProvidersToggleEvent>(_onToggleFavouriteProvidersEvent);
  }

  final GetFavouriteProvidersUseCase getFavouriteProvidersUseCase;
  final ToggleFavouriteProvidersUseCase toggleFavouriteProvidersUseCase;

  static FavouriteProvidersBloc get(BuildContext context) =>
      BlocProvider.of<FavouriteProvidersBloc>(context);

  Future<void> _onFavouriteProvidersFetchEvent(
    FavouriteProvidersFetchEvent event,
    Emitter<FavouriteProvidersState> emit,
  ) async {
    emit(
      state.copyWith(
        getFavouriteProvidersState: RequestState.loading,
        getFavouriteProvidersParameters: event.params,
      ),
    );

    final result = await getFavouriteProvidersUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getFavouriteProvidersState: RequestState.error,
            getFavouriteProvidersResponse: state.getFavouriteProvidersResponse
                .copyWith(status: false, msg: failure.message),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getFavouriteProvidersState: RequestState.loaded,
            getFavouriteProvidersResponse: data.copyWith(
              data:
                  state.getFavouriteProvidersResponse.data != null &&
                      event.params.page > 1
                  ? [
                      ...state.getFavouriteProvidersResponse.data!,
                      ...data.data!,
                    ]
                  : data.data,
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onToggleFavouriteProvidersEvent(
    FavouriteProvidersToggleEvent event,
    Emitter<FavouriteProvidersState> emit,
  ) async {
    emit(state.copyWith(toggleFavouriteProvidersState: RequestState.loading));

    final result = await toggleFavouriteProvidersUseCase.call(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            toggleFavouriteProvidersState: RequestState.error,
            toggleFavouriteProvidersResponse: state
                .toggleFavouriteProvidersResponse
                .copyWith(status: false, msg: failure.message),
          ),
        );
      },
      (data) {
        final providers = List<ProvidersModel>.from(
          state.getFavouriteProvidersResponse.data ?? [],
        );
        final index = providers.indexWhere(
          (provider) => provider.id == data.data?.id,
        );
        if (index != -1) {
          providers[index] = data.data!;
        } else {
          providers.add(data.data!);
        }
        emit(
          state.copyWith(
            toggleFavouriteProvidersState: RequestState.loaded,
            toggleFavouriteProvidersResponse: data,
            getFavouriteProvidersResponse: state.getFavouriteProvidersResponse
                .copyWith(data: providers),
          ),
        );
      },
    );
  }
}
