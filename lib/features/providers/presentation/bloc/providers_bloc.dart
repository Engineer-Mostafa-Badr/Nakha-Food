import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/delete_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_provider_profile_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_providers_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/get_vendor_products_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/show_product_usecase.dart';
import 'package:nakha/features/providers/domain/use_cases/update_product_usecase.dart';

part 'providers_event.dart';
part 'providers_state.dart';

class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  ProvidersBloc(
    this.getProvidersUseCase,
    this.getProviderProfileUseCase,
    this.showProductUseCase,
    this.getProductsUseCase,
    this.getVendorProductsUseCase,
    this.addProductUseCase,
    this.updateProductUseCase,
    this.deleteProductUseCase,
  ) : super(const ProvidersState()) {
    on<ProvidersFetchEvent>(_onProvidersFetchEvent);
    on<ProviderProfileFetchEvent>(_onProviderProfileFetchEvent);
    on<ShowProductFetchEvent>(_onShowProductFetchEvent);
    on<ReplaceProviderEvent>(_onReplaceProviderEvent);
    on<ReplaceProductEvent>(_onReplaceProductEvent);
    on<ProductsFetchEvent>(_onProductsFetchEvent);
    on<VendorProductsFetchEvent>(_onVendorProductsFetchEvent);
    on<AddProductEvent>(_onAddProductEvent);
    on<UpdateProductEvent>(_onUpdateProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
  }

  final GetProvidersUseCase getProvidersUseCase;
  final GetProviderProfileUseCase getProviderProfileUseCase;
  final ShowProductUseCase showProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetVendorProductsUseCase getVendorProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  static ProvidersBloc get(BuildContext context) =>
      BlocProvider.of<ProvidersBloc>(context);

  Future<void> _onProvidersFetchEvent(
    ProvidersFetchEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(
      state.copyWith(
        getProvidersState: RequestState.loading,
        getProvidersParameters: event.params,
      ),
    );

    final result = await getProvidersUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getProvidersState: RequestState.error,
            getProvidersResponse: state.getProvidersResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getProvidersState: RequestState.loaded,
            getProvidersResponse: data.copyWith(
              data:
                  state.getProvidersResponse.data != null &&
                      event.params.page > 1
                  ? [...state.getProvidersResponse.data!, ...data.data!]
                  : data.data,
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onProviderProfileFetchEvent(
    ProviderProfileFetchEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(state.copyWith(getProviderProfileState: RequestState.loading));

    final result = await getProviderProfileUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getProviderProfileState: RequestState.error,
            getProviderProfileResponse: state.getProviderProfileResponse
                .copyWith(status: false, msg: failure.message),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getProviderProfileState: RequestState.loaded,
            getProviderProfileResponse: data,
          ),
        );
      },
    );
  }

  Future<void> _onShowProductFetchEvent(
    ShowProductFetchEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(state.copyWith(showProductState: RequestState.loading));

    final result = await showProductUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            showProductState: RequestState.error,
            showProductResponse: state.showProductResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            showProductState: RequestState.loaded,
            showProductResponse: data,
          ),
        );
      },
    );
  }

  // update provider in favorite list
  FutureOr<void> _onReplaceProviderEvent(
    ReplaceProviderEvent event,
    Emitter<ProvidersState> emit,
  ) {
    emit(state.copyWith(getProvidersState: RequestState.loading));
    final providers = state.getProvidersResponse.data;
    if (providers != null) {
      final index = providers.indexWhere((p) => p.id == event.provider.id);
      if (index != -1) {
        providers[index] = event.provider;
      } else {
        providers.add(event.provider);
      }
      emit(
        state.copyWith(
          getProvidersState: RequestState.loaded,
          getProvidersResponse: state.getProvidersResponse.copyWith(
            data: List.from(providers),
          ),
        ),
      );
    }
  }

  // update product in favorite list
  FutureOr<void> _onReplaceProductEvent(
    ReplaceProductEvent event,
    Emitter<ProvidersState> emit,
  ) {
    emit(
      state.copyWith(
        showProductState: RequestState.loading,
        getProviderProfileState: RequestState.loading,
        getProductsState: RequestState.loading,
      ),
    );

    /// for show product
    final product = state.showProductResponse.data?.copyWith(
      isFavorite: event.product.isFavourite,
      qtyInCart: event.product.qtyInCart,
    );

    /// for provider profile
    final products = state.getProviderProfileResponse.data?.products ?? [];
    final index = products.indexWhere((p) => p.id == event.product.id);
    if (index != -1) {
      products[index] = event.product;
    } else {
      products.add(event.product);
    }

    /// for all products
    final allProducts = state.getProductsResponse.data ?? [];
    final allIndex = allProducts.indexWhere((p) => p.id == event.product.id);
    if (allIndex != -1) {
      allProducts[allIndex] = event.product;
    } else {
      allProducts.add(event.product);
    }

    emit(
      state.copyWith(
        showProductState: RequestState.loaded,
        getProviderProfileState: RequestState.loaded,
        getProductsState: RequestState.loaded,
        showProductResponse: state.showProductResponse.copyWith(data: product),
        getProviderProfileResponse: state.getProviderProfileResponse.copyWith(
          data: state.getProviderProfileResponse.data?.copyWith(
            products: List.from(products),
          ),
        ),
        getProductsResponse: state.getProductsResponse.copyWith(
          data: List.from(allProducts),
        ),
      ),
    );
  }

  Future<void> _onProductsFetchEvent(
    ProductsFetchEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(
      state.copyWith(
        getProductsState: RequestState.loading,
        getProductsParameters: event.params,
      ),
    );

    final result = await getProductsUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getProductsState: RequestState.error,
            getProductsResponse: state.getProductsResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getProductsState: RequestState.loaded,
            getProductsResponse: data.copyWith(
              data:
                  state.getProductsResponse.data != null &&
                      event.params.page > 1
                  ? [...state.getProductsResponse.data!, ...data.data!]
                  : data.data,
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onVendorProductsFetchEvent(
    VendorProductsFetchEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(
      state.copyWith(
        getVendorProductsState: RequestState.loading,
        getVendorProductsParameters: event.params,
      ),
    );

    final result = await getVendorProductsUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getVendorProductsState: RequestState.error,
            getVendorProductsResponse: state.getVendorProductsResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getVendorProductsState: RequestState.loaded,
            getVendorProductsResponse: data.copyWith(
              data:
                  state.getVendorProductsResponse.data != null &&
                      event.params.page > 1
                  ? [...state.getVendorProductsResponse.data!, ...data.data!]
                  : data.data,
              pagination: data.pagination,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onAddProductEvent(
    AddProductEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(state.copyWith(addProductState: RequestState.loading));

    final result = await addProductUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            addProductState: RequestState.error,
            addProductResponse: state.addProductResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            addProductState: RequestState.loaded,
            addProductResponse: data,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateProductEvent(
    UpdateProductEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(state.copyWith(updateProductState: RequestState.loading));

    final result = await updateProductUseCase.call(event.params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            updateProductState: RequestState.error,
            updateProductResponse: state.updateProductResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            updateProductState: RequestState.loaded,
            updateProductResponse: data,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteProductEvent(
    DeleteProductEvent event,
    Emitter<ProvidersState> emit,
  ) async {
    emit(
      state.copyWith(
        getVendorProductsState: RequestState.loading,
        deleteProductState: RequestState.loading,
      ),
    );

    final result = await deleteProductUseCase.call(event.productId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getVendorProductsState: RequestState.loaded,
            deleteProductState: RequestState.error,
            deleteProductResponse: state.deleteProductResponse.copyWith(
              status: false,
              msg: failure.message,
            ),
          ),
        );
      },
      (data) {
        final products = state.getVendorProductsResponse.data;
        if (products != null) {
          products.removeWhere((product) => product.id == event.productId);
        }
        emit(
          state.copyWith(
            getVendorProductsState: RequestState.loaded,
            deleteProductState: RequestState.loaded,
            deleteProductResponse: data,
            getProductsResponse: state.getProductsResponse.copyWith(
              data: products,
            ),
          ),
        );
      },
    );
  }
}
