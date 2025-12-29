import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/avatar_with_edit_icon.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

class MyAccountImageTitle extends StatelessWidget {
  const MyAccountImageTitle({
    super.key,
    this.text = '',
    this.textColor = Colors.black,
    this.showName = true,
  });

  final String text;
  final Color textColor;
  final bool showName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return Column(
          children: [
            AvatarWithEditIcon(
              imageUrl: AppConst.user?.image,
              containerSize: 100,
              padding: 0,
              onImageChanged: (imagePath) {
                ProfileBloc.get(context).add(
                  UpdateProfileEvent(UpdateProfileParams(image: imagePath)),
                );
              },
            ),
            if (showName) ...[
              AppPadding.padding12.sizedHeight,
              Text(
                AppConst.user?.name ?? '',
                style: AppStyles.title700.copyWith(color: textColor),
              ),
            ],
            if (text.isNotEmpty) ...[
              AppPadding.padding8.sizedHeight,
              Text(
                text,
                textAlign: TextAlign.center,
                style: AppStyles.title500.copyWith(color: textColor),
              ),
            ],
          ],
        );
      },
    );
  }
}
