import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class TotalPriceListTile extends StatelessWidget {
  const TotalPriceListTile({
    super.key,
    this.title = 'total_price',
    this.price = '39.49',
  });

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.smallPadding,
        vertical: AppPadding.padding12,
      ),
      decoration: BoxDecoration(
        color: AppColors.cPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppStyles.title500.copyWith(
                color: const Color(0xff676767),
                fontSize: AppFontSize.f13,
              ),
            ).tr(),
          ),
          AppPadding.padding4.sizedWidth,
          Row(
            children: [
              Text(
                price,
                style: AppStyles.title900.copyWith(
                  color: AppColors.cPrimary,
                  fontSize: AppFontSize.f16,
                ),
              ),
              AppPadding.padding4.sizedWidth,
              Text(
                'r.s',
                style: AppStyles.title400.copyWith(color: AppColors.cPrimary),
              ).tr(),
            ],
          ),
        ],
      ),
    );
  }
}
