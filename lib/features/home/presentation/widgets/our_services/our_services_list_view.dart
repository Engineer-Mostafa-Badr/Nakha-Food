import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/utils/container_for_menu.dart';
import 'package:nakha/core/components/utils/see_all_row.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class OurServicesListView extends StatelessWidget {
  const OurServicesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppPadding.mediumPadding.sizedHeight,
        const SeeAllRow(title: 'our_services').addPadding(
          start: AppPadding.mediumPadding,
          end: AppPadding.largePadding,
        ),
        CarouselSlider.builder(
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            padEnds: false,
            onPageChanged: (index, reason) {},
          ),
          itemCount: 10,
          itemBuilder: (context, index, realIndex) {
            return ContainerForMenu(
              padding: const EdgeInsets.all(AppPadding.mediumPadding),
              constraints: BoxConstraints(minWidth: .9.sw, maxWidth: .9.sw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CacheImageReuse(
                    imageUrl: AssetImagesPath.networkImage(),
                    loadingHeight: 70.h,
                    loadingWidth: 70.w,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 35.r,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  AppPadding.smallPadding.sizedHeight,
                  Text(
                    'الخدمة ${index + 1}',
                    style: AppStyles.title600.copyWith(
                      fontSize: AppFontSize.f16,
                    ),
                  ),
                  AppPadding.smallPadding.sizedHeight,
                  Text(
                    'وصف الخدمة ${index + 1} ' * 8,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.subtitle500.copyWith(
                      fontSize: AppFontSize.f14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).addPadding(vertical: AppPadding.largePadding);
          },
        ),
      ],
    );
  }
}
