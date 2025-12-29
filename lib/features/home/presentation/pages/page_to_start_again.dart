import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:nakha/core/components/utils/upgrader_reuse.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/main.dart';
import 'package:page_transition/page_transition.dart';

class PageToStartAgain extends StatefulWidget {
  const PageToStartAgain({super.key});

  @override
  State<PageToStartAgain> createState() => _PageToStartAgainState();
}

class _PageToStartAgainState extends State<PageToStartAgain> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      goToPage();
      MostUsedFunctions.subscribeToTopic();
    });
  }

  Future<void> goToPage() async {
    await sl<MainSecureStorage>().getUserId();
    // MainAppCubit.get(context).getCities();
    await startScreen();
    context.navigateToPageWithClearStack(
      UpgraderReuse(child: appStartScreen),
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImagesPath.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: RepaintBoundary(
          child: FadeInDown(
            duration: const Duration(seconds: 2),
            child: Center(
              child: Image.asset(
                AssetImagesPath.appLogo,
                width: 120,
                height: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
