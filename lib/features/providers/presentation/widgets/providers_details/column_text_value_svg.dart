import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ColumnTextValueSvg extends StatelessWidget {
  const ColumnTextValueSvg({
    super.key,
    required this.value,
    this.svgPath = '',
    required this.title,
  });

  final String value;
  final String svgPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (svgPath.isNotEmpty) ...[
              AssetSvgImage(svgPath),
              AppPadding.padding4.sizedWidth,
            ],
            Text(
              value,
              style: AppStyles.title900.copyWith(
                color: AppColors.grey54Color,
                fontSize: AppFontSize.f20,
              ),
            ),
          ],
        ),
        AppPadding.padding4.sizedHeight,
        Text(
          title,
          style: AppStyles.title400.copyWith(color: AppColors.grey54Color),
        ).tr(),
      ],
    );
  }
}
