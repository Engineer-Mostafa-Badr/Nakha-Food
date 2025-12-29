import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/navigator_key/navigator_key.dart';
import 'package:nakha/core/components/utils/close_keyboard.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/services/notifications_handler/firebase_notification_handler_plus.dart';
import 'package:nakha/core/utils/delay_login.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/core/utils/responsive_helper.dart';
import 'package:nakha/features/chat/presentation/pages/chat_messages_page.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_products/favourite_products_bloc.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_providers/favourite_providers_bloc.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/home/presentation/pages/page_to_start_again.dart';
import 'package:nakha/features/injection_container.dart' as di;
import 'package:nakha/features/notifications/presentation/pages/notifications_page.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

import 'config/themes/dark.dart';
import 'config/themes/light.dart';
import 'core/cubit/app_cubit.dart';
import 'core/utils/app_const.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainAppCubit>(
          create: (context) => di.sl<MainAppCubit>()
            // ..getCities()
            ..checkInternetConnection(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<ProfileBloc>()..add(const GetProfileEvent()),
        ),
        BlocProvider(create: (context) => di.sl<HomeBloc>()),
        BlocProvider(create: (context) => di.sl<FavouriteProvidersBloc>()),
        BlocProvider(
          create: (context) =>
              di.sl<FavouriteProductsBloc>()
                ..add(const FavouriteProductsFetchEvent()),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize:
            ResponsiveHelper.isTablet(context) ||
                ResponsiveHelper.isDesktop(context)
            ? const Size(768, 1024)
            : const Size(414, 896),
        builder: (context, child) {
          return CloseKeyBoardWidget(
            child: MaterialApp(
              title: AppConst.appName,
              navigatorKey: NavigatorKey.navigatorKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: lightTheme(context),
              darkTheme: darkTheme(context),
              themeMode: di.sl<MainAppCubit>().isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: BlocBuilder<MainAppCubit, MainAppCubitState>(
                builder: (context, state) {
                  return Center(child: child);
                },
              ),
            ),
          );
        },
        child: FirebaseNotificationsHandlerPlus(
          defaultNavigatorKey: NavigatorKey.navigatorKey,
          onTap: (navigatorKey, appState, payload) async {
            CheckLoginDelay.checkIfNeedLogin(
              onExecute: () {
                final String type =
                    payload['type'] ?? NotificationsEnum.notification.name;
                final int? itemId = int.tryParse('${payload['item_id']}');

                if (type == NotificationsEnum.message.name && itemId != null) {
                  NavigatorKey.context.navigateToPage(
                    ChatMessagesPage(receiverId: itemId),
                  );
                  return;
                }
                NavigatorKey.context.navigateToPage(const NotificationsPage());
              },
            );
          },
          onFCMTokenInitialize: (context, token) {
            AppConst.fcmToken = token ?? '';
            MostUsedFunctions.subscribeToTopic();
          },
          onFCMTokenUpdate: (context, token) {
            AppConst.fcmToken = token ?? '';
            MostUsedFunctions.subscribeToTopic();
          },
          child: const PageToStartAgain(),
        ),
      ),
    );
  }
}
