import 'package:nakha/config/navigator_key/navigator_key.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/injection_container.dart';

Future<dynamic> goToLoginAndBackToContinue() async {
  return NavigatorKey.context.navigateToPage(
    const LoginPage(startReturnScreen: true),
  );
}

class CheckLoginDelay {
  static void checkIfNeedLogin({required Function() onExecute}) async {
    // onExecute.call();
    // return;

    final isLogin = await sl<MainSecureStorage>().getIsLoggedIn();
    if (isLogin) {
      onExecute.call();
    } else {
      'login_to_continue'.showTopInfoToast;
      await goToLoginAndBackToContinue().then((value) {
        if (value != null) {
          // NavigatorKey.context.navigateToPageWithClearStack(
          //   const LandingPage(),
          // );
          onExecute.call();
        }
      });
    }
  }
}
