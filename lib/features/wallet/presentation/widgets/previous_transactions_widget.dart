import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/orders_status_container.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';

class PreviousTransactionsWidget extends StatelessWidget {
  const PreviousTransactionsWidget({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.padding12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
        border: Border.all(color: AppColors.greyD2Color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          // const AssetSvgImage(AssetImagesPath.transactionSVG),
          Container(
            padding: const EdgeInsets.all(AppPadding.padding8),
            decoration: BoxDecoration(
              color: transaction.inOut == 'in'
                  ? AppColors.cSuccess.withValues(alpha: 0.1)
                  : AppColors.cError.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.inOut == 'in'
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: transaction.inOut == 'in'
                  ? AppColors.cSuccess
                  : AppColors.cError,
            ),
          ),

          AppPadding.padding12.sizedWidth,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.description, style: AppStyles.title500),
                AppPadding.padding4.sizedHeight,
                Row(
                  children: [
                    const AssetSvgImage(AssetImagesPath.dateSVG),
                    AppPadding.smallPadding.sizedWidth,
                    Text(
                      transaction.createdAt,
                      style: AppStyles.title400.copyWith(
                        fontSize: AppFontSize.f14,
                        color: AppColors.grey54Color,
                      ),
                    ).addPadding(top: AppPadding.padding4),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              OrdersStatusContainer(status: transaction.status),
              AppPadding.padding12.sizedHeight,
              Row(
                children: [
                  Text(
                    transaction.amount,
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
        ],
      ),
    );
  }
}
