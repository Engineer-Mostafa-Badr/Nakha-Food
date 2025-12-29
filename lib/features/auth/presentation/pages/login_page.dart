import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/ritch_text_button_.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/auth/presentation/pages/individuals_register_page.dart';
import 'package:nakha/features/auth/presentation/widgets/login_with_phone_body.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.startReturnScreen = false});

  final bool startReturnScreen;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        // appBar: const SharedAppBar(title: 'login'),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppPadding.largePadding),
            children: [
              const MyAppLogo(),
              Text(
                'login',
                textAlign: TextAlign.center,
                style: AppStyles.title800.copyWith(
                  fontSize: AppFontSize.f18,
                  color: AppColors.cSecondary,
                ),
              ).tr(),
              AppPadding.padding8.sizedHeight,
              Image.asset(AssetImagesPath.login, width: 157.w, height: 143.h),

              LoginWithPhoneBody(startReturnScreen: widget.startReturnScreen),
              34.sizedHeight,
              RichTextButton(
                text1: 'dont_have_account',
                text2: 'lets_register',
                onPressed2: () {
                  context.navigateToPage(const IndividualsRegisterPage());
                },
              ),
              30.sizedHeight,
              // // const SocialLoginRow(),
              TextButton(
                onPressed: () {
                  sl<MainSecureStorage>().logout();
                  context.navigateToPageWithClearStack(const LandingPage());
                },
                child: Text(
                  'login_as_guest',
                  style: AppStyles.title500.copyWith(
                    color: AppColors.cSecondary,
                  ),
                ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
