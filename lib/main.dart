import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/bloc_observer.dart';
import 'package:nakha/config/firebase/firebase_options.dart';
import 'package:nakha/core/cubit/app_cubit.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/injection_container.dart' as di;
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';
import 'package:nakha/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:nakha/my_app.dart';
import 'package:package_info_plus/package_info_plus.dart';

Widget appStartScreen = const LoginPage();

Future<void> startScreen() async {
  // await Hive.initFlutter();
  // await Hive.openBox(AppConst.mainBoxName);
  di.sl<MainAppCubit>().isDark = await di.sl<MainSecureStorage>().getIsDark();
  final bool isLoggedIn = await di.sl<MainSecureStorage>().getIsLoggedIn();
  final isFirstTime = await di.sl<MainSecureStorage>().isOnboardingFinished();
  await di.sl<MainSecureStorage>().getUserId();
  await di.sl<MainSecureStorage>().getUserData();
  // final bool isAppUpdated = await di.sl<MainSecureStorage>().getIsAppUpdated();

  // if (!isAppUpdated) {
  //   appStartScreen = const ForeUpdatePage(settingsModel: null);
  // } else
  if (!isFirstTime) {
    appStartScreen = const OnboardingPage();
  } else if (isLoggedIn) {
    // final bool getIsVerified = await di.sl<MainSecureStorage>().getIsVerified();
    // if (getIsVerified) {
    //   appStartScreen = const LandingPage();
    // } else {
    //   appStartScreen = const WaitingApprovalPage();
    // }
    appStartScreen = const LandingPage();
  }
  // appStartScreen = const AllChatsPage();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppConst.versionNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
  await di.init();
  await EasyLocalization.ensureInitialized();
  await startScreen();
  Bloc.observer = MyBlocObserver();
  EasyLocalization.logger.enableBuildModes = [];
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
        Locale('ur', 'PK'),
      ],
      path: 'assets/translation',
      startLocale: const Locale('ar', 'SA'),
      child: const MyApp(),
    ),
  );
}
