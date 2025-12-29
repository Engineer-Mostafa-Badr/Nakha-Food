import 'package:nakha/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class ContainerForBottomNavButtons extends StatelessWidget {
  const ContainerForBottomNavButtons({
    super.key,
    required this.child,
    this.isBottomNavVisible = true,
    this.isBottomNavigatorSheet = false,
  });

  final Widget child;
  final bool isBottomNavVisible;
  final bool isBottomNavigatorSheet;

  @override
  Widget build(BuildContext context) {
    return !isBottomNavVisible
        ? child
        : Container(
            padding: EdgeInsetsDirectional.only(
              start: AppPadding.largePadding,
              end: AppPadding.largePadding,
              bottom: isBottomNavigatorSheet
                  ? AppPadding.largePadding
                  : AppPadding.bottomSheetPadding(context),
              top: AppPadding.smallPadding,
            ),
            // alignment: Alignment.center,
            // constraints: BoxConstraints(
            //   minHeight: height.h,
            //   maxHeight: height.h,
            // ),
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            child: child,
          );
  }
}
