import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/res/app_images.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.bottomWidget,
    this.onBackPressed,
    this.appBarHeight = kToolbarHeight,
  });

  final String title;
  final bool showBackButton;
  final Widget? bottomWidget;
  final double appBarHeight;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton && Navigator.canPop(context)
          ? IconButton(
              onPressed: () {
                if (onBackPressed != null) {
                  onBackPressed?.call();
                  return;
                } else if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              icon: const AssetSvgImage(AssetImagesPath.backButtonSVG),
            )
          : null,
      titleSpacing: showBackButton ? 0 : 16.w,
      title: Text(title).tr(),
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: bottomWidget!,
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((appBarHeight + (bottomWidget == null ? 0 : 30)).h);
}
