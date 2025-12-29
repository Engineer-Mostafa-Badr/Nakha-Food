import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class MyAccountListTile extends StatelessWidget {
  const MyAccountListTile({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.assetSvg,
    this.onTap,
    this.showForwardIcon = true,
    this.color,
    this.iconSize = 20,
  });

  final String title;
  final String subtitle;
  final String assetSvg;
  final Function()? onTap;
  final bool showForwardIcon;
  final Color? color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.largePadding,
        vertical: AppPadding.padding12,
      ),
      child: Row(
        children: [
          AssetSvgImage(
            assetSvg,
            width: iconSize,
            height: iconSize,
            color: color,
          ),
          AppPadding.mediumPadding.sizedWidth,
          Expanded(
            child: Text(
              title,
              style: AppStyles.title400.copyWith(
                color: const Color(0xff1A2530),
              ),
            ).tr(),
          ),
          if (subtitle.isNotEmpty) ...[
            Text(
              subtitle,
              textAlign: TextAlign.start,
              style: AppStyles.title400.copyWith(color: AppColors.cPrimary),
            ).tr(),
            AppPadding.padding24.sizedWidth,
          ],

          if (showForwardIcon)
            Icon(
              Icons.arrow_forward_ios,
              size: AppFontSize.f16,
              color: const Color(0xffA2A2A2),
            ),
        ],
      ),
    ).addAction(borderRadius: 8, onTap: onTap);
  }
}
