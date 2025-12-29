import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class VendorHomeContainer extends StatelessWidget {
  const VendorHomeContainer({
    super.key,
    this.containerColor = Colors.white,
    required this.assetName,
    required this.value,
    required this.title,
  });

  final Color containerColor;
  final String assetName;
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.h,
      width: 96.w,
      padding: const EdgeInsets.all(AppPadding.smallPadding),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
      ),
      child: Column(
        children: [
          AssetSvgImage(assetName),
          AppPadding.smallPadding.sizedHeight,
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.title700.copyWith(fontSize: AppFontSize.f13),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.title500.copyWith(
              fontSize: AppFontSize.f11,
              color: Colors.black54,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
