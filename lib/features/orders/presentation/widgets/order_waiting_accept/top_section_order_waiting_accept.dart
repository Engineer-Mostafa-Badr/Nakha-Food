import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/total_price_list_tile.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/order_status_stepper.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/waiting_acceptance_count_down.dart';

class TopSectionOrderWaitingAccept extends StatelessWidget {
  const TopSectionOrderWaitingAccept({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) =>
          previous.showOrderState != current.showOrderState ||
          previous.showOrderResponse != current.showOrderResponse,
      builder: (context, state) {
        final details = state.showOrderResponse.data;
        return Column(
          children: [
            CacheImageReuse(
              imageUrl: details!.vendor.image,
              loadingHeight: 120,
              loadingWidth: 165,
              imageBuilder: (context, image) {
                return Image(image: image, width: 165.w, height: 120.h);
              },
            ),
            AppPadding.largePadding.sizedHeight,
            if (details.status == OrdersStatusEnum.pending.name) ...[
              Text(
                'waiting_for_acceptance',
                style: AppStyles.title900.copyWith(
                  color: AppColors.grey54Color,
                  fontSize: AppFontSize.f20,
                ),
              ).tr(),
              AppPadding.padding4.sizedHeight,
              Text(
                'waiting_for_acceptance_desc',
                style: AppStyles.title400.copyWith(
                  color: AppColors.grey54Color,
                ),
              ).tr(),
              if (details.orderTimer.isNotEmpty) ...[
                AppPadding.largePadding.sizedHeight,
                WaitingAcceptanceCountDown(endTimeString: details.orderTimer),
              ],
            ] else if (details.status != OrdersStatusEnum.cancelled.name) ...[
              OrderStatusStepper(activeStep: details.step - 1),
            ] else if (details.status == OrdersStatusEnum.cancelled.name) ...[
              Text(
                'rejected_order',
                style: AppStyles.title900.copyWith(color: AppColors.cError),
              ).tr(),
              AppPadding.padding4.sizedHeight,
              Text(
                details.cancelledReason.isNotEmpty
                    ? details.cancelledReason
                    : 'rejected_order_desc'.tr(),
                style: AppStyles.title400.copyWith(
                  color: AppColors.grey54Color,
                ),
              ),
            ],
            40.sizedHeight,
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'order_time',
                        style: AppStyles.title500.copyWith(
                          color: AppColors.grey67Color.withValues(alpha: .5),
                        ),
                      ).tr(),
                      Text(
                        ' ${details.time}',
                        style: AppStyles.title500.copyWith(
                          color: AppColors.grey54Color,
                        ),
                      ),
                    ],
                  ),
                ),
                AppPadding.smallPadding.sizedWidth,
                Row(
                  children: [
                    Text(
                      'order_number',
                      style: AppStyles.title500.copyWith(
                        color: AppColors.grey67Color.withValues(alpha: .5),
                      ),
                    ).tr(),
                    Text(
                      ' ${details.orderNumber}',
                      style: AppStyles.title500.copyWith(
                        color: AppColors.grey54Color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppPadding.mediumPadding.sizedHeight,
            TotalPriceListTile(price: details.totalPrice),
            44.sizedHeight,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'order_details',
                style: AppStyles.title500.copyWith(
                  color: AppColors.grey54Color,
                  fontSize: AppFontSize.f16,
                ),
              ).tr(),
            ),
          ],
        );
      },
    ).addPadding(all: AppPadding.largePadding);
  }
}
