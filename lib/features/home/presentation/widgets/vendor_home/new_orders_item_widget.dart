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
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/use_cases/update_order_status_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/pages/order_waiting_accept_page.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_item_widget.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/cancel_order_bottom_sheet.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/orders_status_container.dart';

class NewOrderVendorItem extends StatelessWidget {
  const NewOrderVendorItem({super.key, required this.ordersModel});

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
          HomeBloc.get(context).add(const GetHomeUtilsEvent());
          // OrdersBloc.get(
          //   context,
          // ).add(ReplaceOrderEvent(state.updateOrderStatusResponse.data!));
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
              if (ordersModel.items.isNotEmpty) ...[
                CartItemWidget(
                  key: ValueKey(
                    '${ordersModel.items.first.product.id}-${ordersModel.items.first.qty}',
                  ),
                  price: ordersModel.items.first.price,
                  image: ordersModel.items.first.product.image,
                  productName: ordersModel.items.first.product.name,
                  quantity: ordersModel.items.first.qty,
                  priceFontSize: 12,
                  productFontSize: 12,
                  imageSize: const Size(44, 34),
                ),
                if (ordersModel.items.length > 1) ...[
                  AppPadding.smallPadding.sizedHeight,
                  Text(
                    '+ ${ordersModel.items.length - 1} ${'another_product'.tr()}',
                    style: AppStyles.subtitle700.copyWith(
                      fontSize: AppFontSize.f12,
                      color: AppColors.grey54Color,
                    ),
                  ),
                ],
              ],
              AppPadding.largePadding.sizedHeight,
              Row(
                children: [
                  const AssetSvgImage(AssetImagesPath.dateSVG),
                  AppPadding.smallPadding.sizedWidth,
                  Expanded(
                    child: Text(
                      ordersModel.createdAt,
                      style: AppStyles.subtitle700.copyWith(
                        fontSize: AppFontSize.f14,
                      ),
                    ),
                  ),

                  Text(
                    '${'total'.tr()}: ${ordersModel.totalPrice}',
                    style: AppStyles.subtitle700.copyWith(
                      fontSize: AppFontSize.f14,
                    ),
                  ).tr(),
                ],
              ),

              if (ordersModel.step == 0 &&
                  OrdersStatusEnum.pending.name == ordersModel.status) ...[
                AppPadding.padding14.sizedHeight,
                Row(
                  children: [
                    Expanded(
                      child: ReusedRoundedButton(
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
                    ),
                    AppPadding.smallPadding.sizedWidth,
                    Expanded(
                      child: ReusedRoundedButton(
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
                    ),
                  ],
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
