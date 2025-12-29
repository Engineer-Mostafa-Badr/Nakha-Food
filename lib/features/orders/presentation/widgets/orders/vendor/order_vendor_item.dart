import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/pages/order_waiting_accept_page.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_item_widget.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/cancel_order_bottom_sheet.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/remaining_time_count_down.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/orders_status_container.dart';

class OrderVendorItem extends StatelessWidget {
  const OrderVendorItem({super.key, required this.ordersModel});

  final OrdersModel ordersModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) =>
          previous.updateOrderStatusState != current.updateOrderStatusState &&
          previous.updateOrderStatusParameters?.orderId ==
              current.updateOrderStatusParameters?.orderId,
      listener: (context, state) {
        if (state.updateOrderStatusState == RequestState.error) {
          state.updateOrderStatusResponse.msg!.showTopErrorToast;
        } else if (state.updateOrderStatusState == RequestState.loaded) {
          state.updateOrderStatusResponse.msg!.showTopSuccessToast;
          OrdersBloc.get(
            context,
          ).add(ReplaceOrderEvent(state.updateOrderStatusResponse.data!));
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(AppPadding.padding12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
            border: Border.all(
              color: AppColors.greyD2Color.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${'order_number'.tr()}: ${ordersModel.orderNumber}',
                      style: AppStyles.subtitle400.copyWith(
                        fontSize: AppFontSize.f14,
                      ),
                    ),
                  ),
                  OrdersStatusContainer(status: ordersModel.status),
                ],
              ),
              AppPadding.largePadding.sizedHeight,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ordersModel.items.length,
                addAutomaticKeepAlives: false,
                itemBuilder: (context, index) {
                  final it = ordersModel.items[index];
                  return CartItemWidget(
                    key: ValueKey('${it.product.id}-${it.qty}'),
                    price: it.price,
                    image: it.product.image,
                    productName: it.product.name,
                    quantity: it.qty,
                    imageSize: const Size(62, 56),
                  );
                },
              ),
              AppPadding.largePadding.sizedHeight,
              Row(
                children: [
                  const AssetSvgImage(AssetImagesPath.dateSVG),
                  AppPadding.smallPadding.sizedWidth,
                  Text(
                    ordersModel.createdAt,
                    style: AppStyles.subtitle500.copyWith(
                      fontSize: AppFontSize.f14,
                    ),
                  ),
                ],
              ),
              if (OrdersStatusEnum.cancelled.name == ordersModel.status) ...[
                AppPadding.largePadding.sizedHeight,
                Text(
                  '${'cancelled_reason'.tr()}: ${ordersModel.cancelledReason}',
                  style: AppStyles.subtitle700.copyWith(
                    color: AppColors.grey54Color,
                  ),
                ),
              ],

              if (ordersModel.step == 0 &&
                  OrdersStatusEnum.pending.name == ordersModel.status) ...[
                AppPadding.largePadding.sizedHeight,
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${tr('remaining_time')}: ',
                            style: AppStyles.title700.copyWith(
                              fontSize: AppFontSize.f12,
                              color: AppColors.grey54Color,
                            ),
                          ),
                          RemainingTimeCountDown(
                            endTimeString: ordersModel.orderTimer,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${'total'.tr()}: ${ordersModel.totalPrice}',
                      style: AppStyles.subtitle700.copyWith(
                        color: AppColors.grey54Color,
                      ),
                    ),
                  ],
                ),
                AppPadding.padding30.sizedHeight,
                Column(
                  children: [
                    ReusedRoundedButton(
                      text: 'accept_order',
                      height: 36,
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
                                orderId: ordersModel.id,
                                status: OrdersStatusEnum.approved,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    AppPadding.smallPadding.sizedHeight,
                    ReusedRoundedButton(
                      text: 'cancel_order',
                      height: 36,
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
                                        orderId: ordersModel.id,
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
                  ],
                ),
              ],

              if (ordersModel.step == 2) ...[
                AppPadding.padding30.sizedHeight,
                ReusedRoundedButton(
                  text: 'make_as_completed',
                  color: AppColors.cSuccess,
                  height: 36,
                  isLoading:
                      state.updateOrderStatusState == RequestState.loading,
                  onPressed: () {
                    // Handle accept order action
                    if (state.updateOrderStatusState != RequestState.loading) {
                      OrdersBloc.get(context).add(
                        UpdateOrderStatusEvent(
                          UpdateOrderStatusParameters(
                            orderId: ordersModel.id,
                            status: OrdersStatusEnum.completed,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ],
          ),
        );
      },
    ).addAction(
      borderRadius: 16,
      onTap: () {
        context.navigateToPage(
          OrderWaitingAcceptPage(ordersModel: ordersModel),
        );
      },
    );
  }
}
