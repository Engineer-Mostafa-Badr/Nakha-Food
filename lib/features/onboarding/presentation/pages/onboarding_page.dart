import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/injection_container.dart' as di;
import 'package:nakha/features/onboarding/domain/entities/onboarding_entities.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // late final PageController pageController;
  late int currentIndex;

  final List<OnboardingEntities> onboardingList = const [
    OnboardingEntities(
      imagePath: AssetImagesPath.onboarding1,
      firstTitle: 'onboarding1_title1',
      description: 'onboarding1_description',
    ),
    OnboardingEntities(
      imagePath: AssetImagesPath.onboarding2,
      firstTitle: 'onboarding2_title1',
      description: 'onboarding2_description',
    ),
    OnboardingEntities(
      imagePath: AssetImagesPath.onboarding3,
      firstTitle: 'onboarding3_title1',
      description: 'onboarding3_description',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // pageController = PageController();
    currentIndex = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final item in onboardingList) {
      precacheImage(AssetImage(item.imagePath), context);
    }
  }

  @override
  void dispose() {
    // pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: finishIntro,
            child: Text(
              'skip',
              style: AppStyles.title400.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ).tr(),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            onboardingList[currentIndex].imagePath,
            width: 342.w,
            height: 440.h,
          ).addPadding(horizontal: AppPadding.largePadding),
          AppPadding.padding26.sizedHeight,
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: onboardingList.length,
              effect: SlideEffect(
                dotHeight: 8.h,
                dotWidth: 46.w,
                activeDotColor: AppColors.cPrimary,
                dotColor: AppColors.cPrimary.withValues(alpha: .4),
              ),
            ),
          ),
          46.sizedHeight,

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.largePadding,
              ),
              children: [
                Text(
                  onboardingList[currentIndex].firstTitle,
                  textAlign: TextAlign.center,
                  style: AppStyles.title500.copyWith(fontSize: AppFontSize.f28),
                ).tr(),
                AppPadding.mediumPadding.sizedHeight,
                Text(
                  onboardingList[currentIndex].description,
                  textAlign: TextAlign.center,
                  style: AppStyles.title500.copyWith(fontSize: AppFontSize.f20),
                ).tr(),
                55.sizedHeight,

                ReusedRoundedButton(
                  text: currentIndex < onboardingList.length - 1
                      ? 'next_page'
                      : 'start',
                  onPressed: nextIntro,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> finishIntro() async {
    await di.sl<MainSecureStorage>().putValue(AppConst.introFinishBox, true);
    // ignore: use_build_context_synchronously
    context.navigateToPageWithClearStack(const LoginPage());
  }

  Future<void> nextIntro() async {
    setState(() {
      if (currentIndex < onboardingList.length - 1) {
        currentIndex++;
        // pageController.animateToPage(
        //   currentIndex,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeIn,
        // );
      } else {
        finishIntro();
      }
    });
  }
}
