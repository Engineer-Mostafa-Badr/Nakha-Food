import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/orders/domain/use_cases/update_to_cart_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_item_widget.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => false,
      builder: (context, homeState) {
        return BlocConsumer<OrdersBloc, OrdersState>(
          listener: (context, state) {
            if (state.updateToCartState == RequestState.error) {
              state.updateToCartResponse.msg!.showTopErrorToast;
            } else {
              HomeBloc.get(context).add(
                UpdateHomeUtilsEvent(
                  homeState.responseUtils.data!.copyWith(
                    totalItemsInCart:
                        state.getCartResponse.data!.totalItemsInCart,
                  ),
                ),
              );
            }
          },
          buildWhen: (previous, current) =>
              previous.getCartResponse != current.getCartResponse,
          builder: (context, state) {
            return ListView.separated(
              padding: const EdgeInsets.all(AppPadding.largePadding),
              itemCount: state.getCartResponse.data!.items.length,
              separatorBuilder: (context, index) =>
                  AppPadding.mediumPadding.sizedHeight,
              itemBuilder: (context, index) => CartItemWidget(
                productName:
                    state.getCartResponse.data!.items[index].product.name,
                image: state.getCartResponse.data!.items[index].product.image,
                price: state.getCartResponse.data!.items[index].subtotal,
                quantity: state.getCartResponse.data!.items[index].qty,
                onQuantityChanged: (quantity) {
                  EasyDebounce.debounce(
                    'add_to_cart_debounce',
                    const Duration(milliseconds: 500),
                    () {
                      OrdersBloc.get(context).add(
                        UpdateToCartEvent(
                          UpdateToCartParameters(
                            productId: state
                                .getCartResponse
                                .data!
                                .items[index]
                                .product
                                .id,
                            qty: quantity,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
