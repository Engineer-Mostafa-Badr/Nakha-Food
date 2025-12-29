import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SharedHomeScaffold extends StatelessWidget {
  const SharedHomeScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 228.h,
                decoration: BoxDecoration(
                  color: AppColors.cSecondary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(AppBorderRadius.radius20),
                  ),
                ),
              ),
            ],
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
          ),
        ],
      ),
    );
  }
}
