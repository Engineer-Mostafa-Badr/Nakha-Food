import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/presentation/pages/order_waiting_accept_page.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/orders_status_container.dart';

class OrdersItemWidget extends StatelessWidget {
  const OrdersItemWidget({super.key, required this.ordersModel});

  final OrdersModel ordersModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.padding12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
        border: Border.all(color: AppColors.greyD2Color.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CacheImageReuse(
                imageUrl: ordersModel.vendor.image,
                loadingHeight: 56,
                loadingWidth: 78,
                imageBuilder: (context, image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.mediumRadius,
                    ),
                    child: Image(
                      image: image,
                      width: 78.w,
                      height: 56.h,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              AppPadding.padding12.sizedWidth,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ordersModel.vendor.name,
                      style: AppStyles.title500.copyWith(
                        fontSize: AppFontSize.f16,
                      ),
                    ),
                    AppPadding.padding4.sizedHeight,
                    Text(
                      '${'order_number'.tr()}: ${ordersModel.orderNumber}',
                      style: AppStyles.subtitle400.copyWith(
                        fontSize: AppFontSize.f14,
                      ),
                    ),
                  ],
                ),
              ),
              OrdersStatusContainer(status: ordersModel.status),
            ],
          ),
          26.sizedHeight,
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const AssetSvgImage(AssetImagesPath.dateSVG),
                    AppPadding.smallPadding.sizedWidth,
                    Text(
                      ordersModel.createdAt,
                      style: AppStyles.subtitle500.copyWith(
                        fontSize: AppFontSize.f14,
                      ),
                    ).addPadding(top: AppPadding.padding4),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    ordersModel.totalPrice,
                    style: AppStyles.title900.copyWith(
                      color: AppColors.grey54Color,
                      fontSize: AppFontSize.f20,
                    ),
                  ),
                  AppPadding.padding4.sizedWidth,
                  Text(
                    'r.s',
                    style: AppStyles.title400.copyWith(
                      color: AppColors.grey54Color,
                    ),
                  ).tr(),
                ],
              ),
            ],
          ),
          if (ordersModel.status == OrdersStatusEnum.cancelled.name &&
              ordersModel.cancelledReason.isNotEmpty) ...[
            AppPadding.padding8.sizedHeight,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding4,
                vertical: AppPadding.padding2,
              ),
              decoration: BoxDecoration(
                color: AppColors.cError.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.smallRadius,
                ),
              ),
              child: Text(
                '${'cancelled_reason'.tr()}: ${ordersModel.cancelledReason}',
                style: AppStyles.subtitle400.copyWith(
                  fontSize: AppFontSize.f14,
                ),
              ),
            ),
          ],
        ],
      ),
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
