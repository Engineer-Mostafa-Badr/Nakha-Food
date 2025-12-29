import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ButtonWithSvgIcon extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color textColor;
  final String? svgEndIcon;
  final String? svgStartIcon;
  final bool isLoading;
  final bool withShadow;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  const ButtonWithSvgIcon({
    required this.text,
    required this.onPressed,
    this.color = AppColors.cPrimary,
    this.textColor = Colors.white,
    this.svgEndIcon,
    this.svgStartIcon,
    this.isLoading = false,
    this.withShadow = true,
    this.borderRadius,
    this.border,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50.h),
      padding: const EdgeInsets.all(AppPadding.padding12),
      decoration: BoxDecoration(
        color: color,
        boxShadow: withShadow ? AppStyles.mostUsedBoxShadow : null,
        border: border,
        borderRadius:
            borderRadius ??
            BorderRadius.all(Radius.circular(AppBorderRadius.smallRadius)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgStartIcon != null) ...[
            AssetSvgImage(svgStartIcon!, color: textColor),
            AppPadding.smallPadding.sizedWidth,
          ],
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: AppStyles.title700.copyWith(color: textColor),
            ).tr(),
          ),
          if (svgEndIcon != null) ...[
            AppPadding.smallPadding.sizedWidth,
            AssetSvgImage(svgEndIcon!, color: textColor),
          ],
        ],
      ),
    ).addAction(borderRadius: 8, onTap: onPressed);
  }
}
