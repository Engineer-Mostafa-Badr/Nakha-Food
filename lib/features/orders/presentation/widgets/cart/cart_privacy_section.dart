import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/presentation/widgets/accept_policy_row.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';
import 'package:nakha/features/orders/domain/use_cases/checkout_cart_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/pages/order_waiting_accept_page.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/total_price_list_tile.dart';

class CartPrivacySection extends StatefulWidget {
  const CartPrivacySection({super.key});

  @override
  State<CartPrivacySection> createState() => _CartPrivacySectionState();
}

class _CartPrivacySectionState extends State<CartPrivacySection> {
  bool _isPolicyAccepted = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => false,
      builder: (context, homeState) {
        return BlocConsumer<OrdersBloc, OrdersState>(
          listener: (context, state) {
            if (state.checkoutCartState == RequestState.error) {
              state.checkoutCartResponse.msg!.showTopErrorToast;
            } else if (state.checkoutCartState == RequestState.loaded) {
              state.checkoutCartResponse.msg!.showTopSuccessToast;
              HomeBloc.get(context).add(
                UpdateHomeUtilsEvent(
                  homeState.responseUtils.data!.copyWith(totalItemsInCart: 0),
                ),
              );
              context.navigateToPageWithClearStack(const LandingPage(index: 1));
              context.navigateToPage(
                OrderWaitingAcceptPage(
                  ordersModel: state.checkoutCartResponse.data!,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                AcceptPolicyRow(
                  onChanged: (value) {
                    // Handle policy acceptance
                    _isPolicyAccepted = value;
                  },
                ),
                AppPadding.smallPadding.sizedHeight,
                Row(
                  children: [
                    Expanded(
                      child: TotalPriceListTile(
                        title: 'delivery_fee',
                        price:
                            state.getCartResponse.data?.deliveryPrice ?? '0.00',
                      ),
                    ),
                    AppPadding.smallPadding.sizedWidth,
                    Expanded(
                      child: TotalPriceListTile(
                        title: 'tax_amount',
                        price: state.getCartResponse.data?.tax ?? '0.00',
                      ),
                    ),
                  ],
                ),
                AppPadding.smallPadding.sizedHeight,
                Row(
                  children: [
                    Expanded(
                      child: TotalPriceListTile(
                        title: 'admin_commission',
                        price:
                            state.getCartResponse.data?.adminCommission ??
                            '0.00',
                      ),
                    ),
                    AppPadding.smallPadding.sizedWidth,
                    Expanded(
                      child: TotalPriceListTile(
                        price: state.getCartResponse.data?.total ?? '0.00',
                      ),
                    ),
                  ],
                ),
                AppPadding.largePadding.sizedHeight,
                ReusedRoundedButton(
                  text: 'go_to_pay',
                  isLoading: state.checkoutCartState == RequestState.loading,
                  onPressed: () {
                    if (!_isPolicyAccepted) {
                      'please_accept_terms'.showTopInfoToast;
                      return;
                    }
                    OrdersBloc.get(
                      context,
                    ).add(const CheckoutCartEvent(CheckoutCartParameters()));
                  },
                ),
              ],
            );
          },
        );
      },
    ).addPadding(all: AppPadding.largePadding);
  }
}
