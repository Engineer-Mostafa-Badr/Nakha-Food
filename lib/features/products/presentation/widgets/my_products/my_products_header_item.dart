import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class MyProductsHeaderItem extends StatelessWidget {
  const MyProductsHeaderItem({super.key, required this.text, this.assSvg});

  final String text;
  final String? assSvg;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.subtitle500,
        ).tr(),

        if (assSvg != null)
          AssetSvgImage(assSvg!).addPadding(start: AppPadding.padding4),
      ],
    );
  }
}
