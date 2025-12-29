import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/column_text_value_svg.dart';

class TopSectionProvidersDetails extends StatelessWidget {
  const TopSectionProvidersDetails({
    super.key,
    required this.providerProfileModel,
  });

  final ProviderProfileModel providerProfileModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: AlignmentDirectional.centerEnd,
          child: BackButtonLeftIcon(),
        ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.smallRadius),
              child: CacheImageReuse(
                imageUrl: providerProfileModel.vendor.coverImage,
                loadingHeight: 172,
                loadingWidth: double.infinity,
                viewImage: true,
                imageBuilder: (context, image) {
                  return Image(
                    image: image,
                    height: 172.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CacheImageReuse(
                imageUrl: providerProfileModel.vendor.image,
                loadingHeight: 80,
                imageBuilder: (context, image) {
                  // return Image(image: image, width: 165.w, height: 120.h);
                  return CircleAvatar(radius: 50.r, backgroundImage: image);
                },
              ).addPadding(top: 120.h),
            ),
          ],
        ),

        AppPadding.largePadding.sizedHeight,
        Text(
          providerProfileModel.vendor.name,
          style: AppStyles.title900.copyWith(
            color: AppColors.grey54Color,
            fontSize: AppFontSize.f20,
          ),
        ),
        AppPadding.padding4.sizedHeight,
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding6,
            vertical: AppPadding.padding2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.radius4),
            color: AppColors.cPrimary,
          ),
          child: Text(
            providerProfileModel.vendor.storeDescription,
            style: AppStyles.title400.copyWith(color: Colors.white),
          ),
        ),
        AppPadding.largePadding.sizedHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColumnTextValueSvg(
              title: 'rating',
              value: providerProfileModel.vendor.rate.toString(),
              svgPath: AssetImagesPath.fullStarSVG,
            ),
            40.sizedWidth,
            ColumnTextValueSvg(
              title: 'orders_number',
              value: providerProfileModel.ordersCount.toString(),
            ),
          ],
        ),
      ],
    ).addPadding(all: AppPadding.largePadding);
  }
}
