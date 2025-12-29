import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({
    super.key,
    this.topWidget,
    this.body,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.isBottomNavVisible = true,
  });

  final Widget? topWidget;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool isBottomNavVisible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundImage(child: topWidget),
          Container(
            margin: EdgeInsets.only(top: 226.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppBorderRadius.radius30),
              ),
            ),
            child: body,
          ),
          if (Navigator.canPop(context))
            const SafeArea(child: BackButton(color: Colors.white)),
        ],
      ),
      bottomSheet: bottomSheet == null
          ? null
          : ContainerForBottomNavButtons(
              isBottomNavVisible: isBottomNavVisible,
              child: bottomSheet!,
            ),
      bottomNavigationBar: bottomNavigationBar != null
          ? ContainerForBottomNavButtons(
              isBottomNavVisible: isBottomNavVisible,
              child: bottomNavigationBar!,
            )
          : null,
    );
  }
}

class ProfileBackgroundImage extends StatelessWidget {
  const ProfileBackgroundImage({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 264.h,
      width: 1.sw,
      decoration: const BoxDecoration(
        color: AppColors.cSecondary,
        // image: DecorationImage(
        //   image: AssetImage(AssetImagesPath.myAccountBackground),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: SafeArea(child: child ?? const SizedBox.shrink()),
    );
  }
}
