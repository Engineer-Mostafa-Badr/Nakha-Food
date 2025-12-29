import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class InvoiceTextValue extends StatelessWidget {
  const InvoiceTextValue({
    super.key,
    this.title = 'Enter Title',
    this.value = 'Enter Value',
    this.withRiyalSymbol = true,
    this.textStyle,
    this.valueTextStyle,
    this.symbolColor,
    this.border,
    this.icon,
  });

  final String title;
  final String value;
  final bool withRiyalSymbol;
  final TextStyle? textStyle;
  final TextStyle? valueTextStyle;
  final Color? symbolColor;
  final BoxBorder? border;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.padding10,
        horizontal: AppPadding.padding14,
      ),
      decoration: BoxDecoration(
        border: border ?? Border.all(color: AppColors.greyBDColor, width: 1.2),
        borderRadius: BorderRadius.circular(AppBorderRadius.smallRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  textStyle ??
                  AppStyles.title600.copyWith(color: const Color(0xff767676)),
            ).tr(),
          ),
          Row(
            children: [
              Text(value, style: valueTextStyle ?? AppStyles.title500),
              if (withRiyalSymbol) ...[
                AppPadding.smallPadding.sizedWidth,
                AssetSvgImage(
                  AssetImagesPath.saudiRiyalSymbolSVG,
                  color: symbolColor,
                ),
              ],
              if (icon != null) ...[AppPadding.smallPadding.sizedWidth, icon!],
            ],
          ),
        ],
      ),
    );
  }
}
