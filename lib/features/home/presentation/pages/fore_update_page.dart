import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';

class ForeUpdatePage extends StatelessWidget {
  const ForeUpdatePage({super.key, required this.settingsModel});

  final HomeModel? settingsModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()
        ..add(
          settingsModel != null
              ? const MakeCounterNotificationZeroEvent()
              : const GetHomeUtilsEvent(),
        ),
      child: Scaffold(
        backgroundColor: AppColors.cPrimary,
        body: BlocConsumer<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.requestUtilsState != current.requestUtilsState,
          listener: (context, state) {
            if (state.requestUtilsState == RequestState.loaded) {
              if (state.responseUtils.data!.androidVersionNumber <=
                      AppConst.versionNumber &&
                  Platform.isAndroid) {
                sl<MainSecureStorage>().putIsAppUpdated(true);
                context.navigateToPageWithClearStack(const LandingPage());
              } else if (state.responseUtils.data!.iosVersionNumber <=
                      AppConst.versionNumber &&
                  Platform.isIOS) {
                sl<MainSecureStorage>().putIsAppUpdated(true);
                context.navigateToPageWithClearStack(const LandingPage());
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const AssetSvgImage(
                  //   AssetImagesPath.waitUpdateSvg,
                  // ),
                  AppPadding.padding24.sizedHeight,
                  Text(
                    'update_app_message',
                    textAlign: TextAlign.center,
                    style: AppStyles.title500.copyWith(color: Colors.white),
                  ).tr(),
                  AppPadding.padding24.sizedHeight,
                  ReusedRoundedButton(
                    text: 'update_app',
                    color: Colors.white,
                    textColor: AppColors.cPrimary,
                    onPressed: () {
                      if (state.responseUtils.data != null) {
                        MostUsedFunctions.urlLauncherFun(
                          Platform.isIOS
                              ? state.responseUtils.data?.iosUrl ??
                                    settingsModel!.iosUrl
                              : state.responseUtils.data?.androidUrl ??
                                    settingsModel!.androidUrl,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
