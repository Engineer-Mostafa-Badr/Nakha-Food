import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/favourite/domain/use_cases/get_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

part 'favourite_products_event.dart';
part 'favourite_products_state.dart';

class FavouriteProductsBloc
    extends Bloc<FavouriteProductsEvent, FavouriteProductsState> {
  FavouriteProductsBloc(
    this.getFavouriteProductsUseCase,
    this.toggleFavouriteProductsUseCase,
  ) : super(const FavouriteProductsState()) {
    on<FavouriteProductsFetchEvent>(_onFavouriteProductsFetchEvent);
    on<FavouriteProductsToggleEvent>(_onToggleFavouriteProductsEvent);
  }

  final GetFavouriteProductsUseCase getFavouriteProductsUseCase;
  final ToggleFavouriteProductsUseCase toggleFavouriteProductsUseCase;

  static FavouriteProductsBloc get(BuildContext context) =>
      BlocProvider.of<FavouriteProductsBloc>(context);

  Future<void> _onFavouriteProductsFetchEvent(
    FavouriteProductsFetchEvent event,
    Emitter<FavouriteProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        getFavouriteProductsState: RequestState.loading,
        getFavouriteProductsParameters: event.params,
      ),
    );

    final result = await getFavouriteProductsUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getFavouriteProductsState: RequestState.error,
            getFavouriteProductsResponse: state.getFavouriteProductsResponse
                .copyWith(status: false, msg: failure.message),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getFavouriteProductsState: RequestState.loaded,
            getFavouriteProductsResponse: data.copyWith(
              data:
                  state.getFavouriteProductsResponse.data != null &&
                      event.params.page > 1
                  ? [...state.getFavouriteProductsResponse.data!, ...data.data!]
                  : data.data,
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onToggleFavouriteProductsEvent(
    FavouriteProductsToggleEvent event,
    Emitter<FavouriteProductsState> emit,
  ) async {
    emit(state.copyWith(toggleFavouriteProductsState: RequestState.loading));

    final result = await toggleFavouriteProductsUseCase.call(event.parameters);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            toggleFavouriteProductsState: RequestState.error,
            toggleFavouriteProductsResponse: state
                .toggleFavouriteProductsResponse
                .copyWith(status: false, msg: failure.message),
          ),
        );
      },
      (data) {
        final products = List<ProductsModel>.from(
          state.getFavouriteProductsResponse.data ?? [],
        );
        final index = products.indexWhere(
          (provider) => provider.id == data.data?.id,
        );
        if (index != -1) {
          products[index] = data.data!;
        } else {
          products.add(data.data!);
        }
        emit(
          state.copyWith(
            toggleFavouriteProductsState: RequestState.loaded,
            toggleFavouriteProductsResponse: data,
            getFavouriteProductsResponse: state.getFavouriteProductsResponse
                .copyWith(data: products),
          ),
        );
      },
    );
  }
}
