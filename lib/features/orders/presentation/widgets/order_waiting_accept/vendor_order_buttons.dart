import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/cancel_order_bottom_sheet.dart';

class VendorOrderButtons extends StatelessWidget {
  const VendorOrderButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) =>
          previous.showOrderState != current.showOrderState ||
          previous.showOrderResponse != current.showOrderResponse,
      listener: (context, state) {
        if (state.updateOrderStatusState == RequestState.error) {
          state.payOrderResponse.msg!.showTopSuccessToast;
          OrdersBloc.get(context).add(
            ShowOrderEvent(
              ShowOrderParams(orderId: state.showOrderResponse.data?.id ?? 0),
            ),
          );
        } else if (state.updateOrderStatusState == RequestState.loaded) {
          state.payOrderResponse.msg!.showTopErrorToast;
        }
      },
      builder: (context, state) {
        return state.showOrderResponse.data?.step == 0 &&
                OrdersStatusEnum.pending.name ==
                    state.showOrderResponse.data?.status
            ? ContainerForBottomNavButtons(
                child: Row(
                  children: [
                    Expanded(
                      child: ReusedRoundedButton(
                        text: 'accept_order',
                        color: AppColors.cSuccess,
                        isLoading:
                            state.updateOrderStatusState ==
                                RequestState.loading &&
                            state.updateOrderStatusParameters?.status ==
                                OrdersStatusEnum.approved,
                        onPressed: () {
                          if (state.updateOrderStatusState !=
                              RequestState.loading) {
                            // Handle accept order action
                            OrdersBloc.get(context).add(
                              UpdateOrderStatusEvent(
                                UpdateOrderStatusParameters(
                                  orderId: state.showOrderResponse.data!.id,
                                  status: OrdersStatusEnum.approved,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    AppPadding.mediumPadding.sizedWidth,
                    Expanded(
                      child: ReusedRoundedButton(
                        text: 'cancel_order',
                        color: AppColors.cError,
                        isLoading:
                            state.updateOrderStatusState ==
                                RequestState.loading &&
                            state.updateOrderStatusParameters?.status ==
                                OrdersStatusEnum.cancelled,
                        onPressed: () {
                          // Handle payment action
                          if (state.updateOrderStatusState !=
                              RequestState.loading) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) {
                                return CancelBottomSheet(
                                  onCancel: (reason) {
                                    OrdersBloc.get(context).add(
                                      UpdateOrderStatusEvent(
                                        UpdateOrderStatusParameters(
                                          orderId:
                                              state.showOrderResponse.data!.id,
                                          cancelReason: reason,
                                          status: OrdersStatusEnum.cancelled,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            : state.showOrderResponse.data?.step == 2
            ? ContainerForBottomNavButtons(
                child: ReusedRoundedButton(
                  text: 'make_as_completed',
                  color: AppColors.cSuccess,
                  isLoading:
                      state.updateOrderStatusState == RequestState.loading,
                  onPressed: () {
                    // Handle accept order action
                    if (state.updateOrderStatusState != RequestState.loading) {
                      OrdersBloc.get(context).add(
                        UpdateOrderStatusEvent(
                          UpdateOrderStatusParameters(
                            orderId: state.showOrderResponse.data!.id,
                            status: OrdersStatusEnum.completed,
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
