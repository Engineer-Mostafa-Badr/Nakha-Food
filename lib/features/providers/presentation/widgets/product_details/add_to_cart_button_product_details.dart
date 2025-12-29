import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/domain/use_cases/add_to_cart_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class AddToCartButtonProductDetails extends StatelessWidget {
  const AddToCartButtonProductDetails({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  final ShowProductModel product;
  final Function(ProductsModel) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => false,
      builder: (context, homeState) {
        return ContainerForBottomNavButtons(
          child: BlocProvider(
            create: (context) => sl<OrdersBloc>(),
            child: BlocConsumer<OrdersBloc, OrdersState>(
              listener: (context, state) {
                if (state.addToCartState == RequestState.loaded) {
                  state.addToCartResponse.msg!.showTopSuccessToast;
                  HomeBloc.get(context).add(
                    UpdateHomeUtilsEvent(
                      homeState.responseUtils.data!.copyWith(
                        totalItemsInCart:
                            homeState.responseUtils.data!.totalItemsInCart + 1,
                      ),
                    ),
                  );
                  onAddToCart(state.addToCartResponse.data!.item.product);
                } else if (state.addToCartState == RequestState.error) {
                  state.addToCartResponse.msg!.showTopErrorToast;
                }
              },
              builder: (context, state) {
                return ReusedRoundedButton(
                  text: 'add_to_cart'.tr(
                    namedArgs: {'count': product.qtyInCart.toString()},
                  ),
                  isLoading: state.addToCartState == RequestState.loading,
                  onPressed: () {
                    OrdersBloc.get(context).add(
                      AddToCartEvent(
                        AddToCartParameters(productId: product.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
