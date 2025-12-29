import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class ContactUsListTile extends StatelessWidget {
  const ContactUsListTile({
    super.key,
    this.assetSvg = AssetImagesPath.time2SVG,
    this.value = '',
    this.url = '',
  });

  final String assetSvg;
  final String value;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AssetSvgImage(assetSvg, width: 28, height: 28),
        AppPadding.mediumPadding.sizedWidth,
        Expanded(child: Text(value, style: AppStyles.title500).tr()),
      ],
    ).addAction(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.padding14,
        horizontal: AppPadding.largePadding,
      ),
      onTap: () {
        if (url.isEmpty) return;
        MostUsedFunctions.urlLauncherFun(url);
      },
    );
  }
}
