import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/avatar_with_edit_icon.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/time_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/presentation/pages/pending_approval_page.dart';
import 'package:nakha/features/home/presentation/widgets/conversations_icon.dart';
import 'package:nakha/features/home/presentation/widgets/notification_icon.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nakha/features/profile/presentation/pages/profile_page.dart';

class SharedHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedHomeAppBar({
    super.key,
    this.showBackButton = false,
    this.actions = const [
      ConversationsIcon(),
      NotificationIcon(),
      SizedBox(width: 8),
    ],
  });

  final bool showBackButton;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.getProfileState == RequestState.loaded) {
          if (state.getProfileResponse.data!.status != 'active' &&
              state.getProfileResponse.data!.userType == 'vendor') {
            context.navigateToPageWithClearStack(const PendingApprovalPage());
          }
        }
      },
      builder: (context, state) {
        final userModel = state.getProfileResponse.data;
        return AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: showBackButton && Navigator.canPop(context)
              ? null
              : 200.w,
          leading: showBackButton && Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const AssetSvgImage(AssetImagesPath.backButtonSVG),
                )
              : Row(
                  children: [
                    AppPadding.mediumPadding.sizedWidth,
                    AvatarWithEditIcon(
                      imageUrl: AppConst.user?.image ?? userModel?.image,
                      containerSize: 46,
                      imageSize: 42,
                      padding: 4,
                      borderColor: AppColors.cPrimary,
                    ).addAction(
                      borderRadius: 100,
                      onTap: () {
                        context.navigateToPage(const ProfilePage());
                      },
                    ),
                    AppPadding.mediumPadding.sizedWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'welcome'.isNowPM ? 'good_evening' : 'good_morning',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppStyles.title400.copyWith(
                            fontSize: AppFontSize.f13,
                          ),
                        ).tr(),
                        Text(
                          // 'Welcome back',
                          (AppConst.user?.name ?? notSpecified).getFirstNWords(
                            2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.title500,
                        ),
                      ],
                    ),
                  ],
                ),
          actions: actions,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
