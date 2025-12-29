import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/webview/payment_web_view_page.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/features/orders/domain/use_cases/pay_cart_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/pages/add_rating_page.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/payment_bottom_sheet.dart';

class OrderPayButton extends StatelessWidget {
  const OrderPayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) =>
          previous.showOrderState != current.showOrderState ||
          previous.showOrderResponse != current.showOrderResponse ||
          previous.payOrderState != current.payOrderState,
      listener: (context, state) {
        if (state.payOrderState == RequestState.loaded) {
          state.payOrderResponse.msg!.showTopSuccessToast;

          if (state.payOrderResponse.data != null &&
              state.payOrderResponse.data!.isNotEmpty) {
            context.navigateToPage(
              PaymentWebViewPage(
                payLink: state.payOrderResponse.data!,
                backTo: () {
                  Navigator.of(context).pop();
                  OrdersBloc.get(context).add(
                    ShowOrderEvent(
                      ShowOrderParams(
                        orderId: state.showOrderResponse.data?.id ?? 0,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else if (state.payOrderState == RequestState.error) {
          state.payOrderResponse.msg!.showTopErrorToast;
        }
      },
      builder: (context, state) {
        return state.showOrderState.isLoading
            ? const SizedBox.shrink()
            : state.showOrderResponse.data?.step == 0 &&
                  state.showOrderResponse.data?.status ==
                      OrdersStatusEnum.approved.name
            ? ContainerForBottomNavButtons(
                child: ReusedRoundedButton(
                  text: 'pay_details_button'.tr(
                    namedArgs: {
                      'price':
                          '${state.showOrderResponse.data?.totalPrice ?? 0}',
                    },
                  ),
                  isLoading: state.payOrderState == RequestState.loading,
                  color: AppColors.cSuccess,
                  onPressed: () {
                    // Handle payment action
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return PaymentBottomSheet(
                          ordersModel: state.showOrderResponse.data!,
                          onPay: () {
                            OrdersBloc.get(context).add(
                              PayOrderEvent(
                                PayOrderParameters(
                                  orderId: state.showOrderResponse.data!.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              )
            : state.showOrderResponse.data?.step == 3 &&
                  state.showOrderResponse.data?.isRated == false &&
                  state.showOrderResponse.data?.status ==
                      OrdersStatusEnum.completed.name
            ? ContainerForBottomNavButtons(
                child: ReusedRoundedButton(
                  text: 'add_rating',
                  onPressed: () async {
                    final value = await context.navigateToPage(
                      AddRatingPage(ordersModel: state.showOrderResponse.data),
                    );
                    if (value == true) {
                      OrdersBloc.get(context).add(
                        ShowOrderEvent(
                          ShowOrderParams(
                            orderId: state.showOrderResponse.data!.id,
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
