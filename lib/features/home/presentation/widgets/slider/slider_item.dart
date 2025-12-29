import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

class SliderItemWidget extends StatelessWidget {
  const SliderItemWidget({super.key, required this.sliders});

  final SlidersModel sliders;

  @override
  Widget build(BuildContext context) {
    return CacheImageReuse(
      imageUrl: sliders.cover,
      loadingHeight: 171.h,
      loadingWidth: double.infinity,
      imageBuilder: (context, imageProvider) => Container(
        width: double.infinity,
        height: 171.h,
        padding: const EdgeInsets.all(AppPadding.mediumPadding),
        margin: EdgeInsets.symmetric(horizontal: AppPadding.mediumPadding.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.smallRadius),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sliders.specialText.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(sliders.specialText, style: AppStyles.title500),
              ),
              AppPadding.padding14.sizedHeight,
            ],
            if (sliders.title.isNotEmpty) ...[
              Text(
                sliders.title,
                style: AppStyles.title700.copyWith(
                  fontSize: AppFontSize.f16,
                  color: Colors.white,
                ),
              ),
            ],
            if (sliders.subtitle.isNotEmpty) ...[
              AppPadding.padding4.sizedHeight,
              Text(
                sliders.subtitle,
                style: AppStyles.title400.copyWith(
                  fontSize: AppFontSize.f14,
                  color: Colors.white,
                ),
              ),
            ],
            AppPadding.padding8.sizedHeight,
          ],
        ),
      ),
    );
  }
}
