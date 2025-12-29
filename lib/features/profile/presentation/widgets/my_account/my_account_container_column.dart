import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class MyAccountContainerColumn extends StatelessWidget {
  const MyAccountContainerColumn({
    super.key,
    required this.children,
    required this.title,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.padding10,
        horizontal: AppPadding.padding12,
      ),
      decoration: BoxDecoration(
        color: AppColors.cPrimary.withValues(alpha: .04),
        borderRadius: BorderRadius.circular(AppBorderRadius.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.subtitle400.copyWith(fontSize: AppFontSize.f14),
          ).tr(),
          AppPadding.padding10.sizedHeight,
          ...children,
        ],
      ),
    );
  }
}
