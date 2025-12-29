import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/notifications/presentation/pages/notifications_page.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.responseUtils.data?.unreadNotifications !=
          current.responseUtils.data?.unreadNotifications,
      builder: (context, state) {
        return Badge.count(
          isLabelVisible:
              state.responseUtils.data?.unreadNotifications != null &&
              state.responseUtils.data!.unreadNotifications != 0,
          count: state.responseUtils.data?.unreadNotifications ?? 0,
          backgroundColor: AppColors.cPrimary,
          child: IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              HomeBloc.get(
                context,
              ).add(const MakeCounterNotificationZeroEvent());
              context.navigateToPage(const NotificationsPage());
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.cPrimary.withValues(alpha: 0.2),
                ),
              ),
              child: const AssetSvgImage(
                AssetImagesPath.bellSVG,
                color: AppColors.cPrimary,
                height: 18,
                width: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
