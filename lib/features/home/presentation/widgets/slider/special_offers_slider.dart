import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/presentation/widgets/slider/slider_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSliders extends StatefulWidget {
  const HomeSliders({
    super.key,
    this.title = 'the_special_offers',
    this.items = const [],
    this.isLoading = false,
  });

  final bool isLoading;
  final String title;
  final List<SlidersModel> items;

  @override
  State<HomeSliders> createState() => _HomeSlidersState();
}

class _HomeSlidersState extends State<HomeSliders> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final sliders = widget.isLoading
        ? List.generate(
            4,
            (index) => SlidersModel(
              id: index,
              cover: AssetImagesPath.networkImage(),
              subtitle: '$notSpecified ' * 5,
              title: '$notSpecified ' * 3,
              specialText: '$notSpecified ' * 2,
            ),
          )
        : widget.items;

    return sliders.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title.isNotEmpty)
                Text(
                  widget.title,
                  style: AppStyles.title900.copyWith(
                    fontSize: AppFontSize.f20,
                    color: AppColors.grey54Color,
                  ),
                ).tr().addPadding(start: 28, top: 16, bottom: 10),
              CarouselSlider.builder(
                options: CarouselOptions(
                  aspectRatio: 344 / 144,
                  viewportFraction: 1,
                  autoPlay: sliders.length > 1,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  padEnds: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemCount: sliders.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      SliderItemWidget(sliders: sliders[index]),
                      if (sliders.length > 1) ...[
                        AnimatedSmoothIndicator(
                          activeIndex: _current,
                          count: sliders.length,
                          effect: WormEffect(
                            dotWidth: 8.w,
                            dotHeight: 8.h,
                            activeDotColor: AppColors.cPrimary,
                            dotColor: AppColors.cTextSubtitleLight.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ).addPadding(bottom: AppPadding.smallPadding),
                      ],
                    ],
                  );
                },
              ),
            ],
          );
  }
}
