import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class RowIconText extends StatelessWidget {
  const RowIconText({
    super.key,
    required this.text,
    required this.iconPath,
    this.iconSize,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.textColor,
    this.iconColor,
    this.additionalWidget,
  });

  final String text;
  final String iconPath;
  final FontWeight fontWeight;
  final double? iconSize;
  final double fontSize;
  final Color? textColor;
  final Color? iconColor;
  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AssetSvgImage(
          iconPath,
          width: iconSize,
          height: iconSize,
          color: iconColor,
        ),
        AppPadding.padding4.sizedWidth,
        Text(
          text,
          style: AppStyles.title500.copyWith(
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
        if (additionalWidget != null) ...[additionalWidget!],
      ],
    );
  }
}
