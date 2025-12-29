import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class OrdersStatusContainer extends StatelessWidget {
  const OrdersStatusContainer({super.key, this.status = 'pending'});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding8,
        vertical: AppPadding.padding4,
      ),
      decoration: BoxDecoration(
        color: MostUsedFunctions.statusColor(status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
      ),
      child: Text(
        status,
        style: AppStyles.subtitle500.copyWith(
          fontSize: AppFontSize.f14,
          color: MostUsedFunctions.statusColor(status),
        ),
      ).tr(),
    );
  }
}
