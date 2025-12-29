import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/avatar_with_edit_icon.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

class MyAccountImageNamePhone extends StatelessWidget {
  const MyAccountImageNamePhone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return Container(
          padding: const EdgeInsets.all(AppPadding.largePadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.largeRadius),
            image: const DecorationImage(
              image: AssetImage(AssetImagesPath.profileCard),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              AvatarWithEditIcon(
                imageUrl: AppConst.user?.image,
                onImageChanged: (imagePath) {
                  ProfileBloc.get(context).add(
                    UpdateProfileEvent(UpdateProfileParams(image: imagePath)),
                  );
                },
              ),
              AppPadding.padding12.sizedHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppConst.user?.name ?? '', style: AppStyles.title700),
                  AppPadding.smallPadding.sizedWidth,
                  const AssetSvgImage(AssetImagesPath.verifySVG),
                ],
              ),
              AppPadding.padding12.sizedHeight,
              Text(AppConst.user?.phone ?? '', style: AppStyles.title700),
            ],
          ),
        );
      },
    );
  }
}
