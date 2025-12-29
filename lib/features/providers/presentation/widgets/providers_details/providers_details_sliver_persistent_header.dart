import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ProvidersDetailsSliverPersistentHeader extends StatelessWidget {
  const ProvidersDetailsSliverPersistentHeader({super.key, this.onTap});

  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        TabBar(
          labelColor: AppColors.cPrimary,
          indicatorColor: Colors.blue,
          unselectedLabelColor: AppColors.grey54Color,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: AppConst.fontName(context),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: AppConst.fontName(context),
          ),
          dividerColor: const Color(0xFFEFEEEA),
          tabs: [
            Tab(text: 'shop_info'.tr()),
            Tab(text: 'products'.tr()),
          ],
          onTap: onTap,
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.mediumPadding,
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(
        context,
      ).scaffoldBackgroundColor, // tabBar background color
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
