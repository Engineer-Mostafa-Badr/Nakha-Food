import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: 'change_password'),
      body: ListView(
        padding: const EdgeInsets.all(AppPadding.largePadding * 2),
        children: [
          const AssetSvgImage(AssetImagesPath.loginSVG),
          66.sizedHeight,
          Text(
            'enter_new_password',
            textAlign: TextAlign.center,
            style: AppStyles.title500.copyWith(
              fontSize: AppFontSize.f16,
              color: AppColors.cPrimary,
            ),
          ).tr(),
          30.sizedHeight,
          const ReusedTextFormField(hintText: 'password', title: 'password'),
          AppPadding.largePadding.sizedHeight,
          const ReusedTextFormField(
            hintText: 'confirm_password',
            title: 'confirm_password',
          ),
          AppPadding.largePadding.sizedHeight,
          ReusedRoundedButton(text: 'change_password', onPressed: () {}),
        ],
      ),
    );
  }
}
