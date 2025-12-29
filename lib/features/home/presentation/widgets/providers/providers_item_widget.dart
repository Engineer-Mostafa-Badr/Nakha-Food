import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/utils/most_used_container.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_providers_usecase.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_providers/favourite_providers_bloc.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/presentation/pages/providers_details_page.dart';

class ProvidersItemWidget extends StatelessWidget {
  const ProvidersItemWidget({
    super.key,
    this.userModel,
    required this.onAddToFav,
  });

  final ProvidersModel? userModel;
  final Function(ProvidersModel) onAddToFav;

  @override
  Widget build(BuildContext context) {
    return MostUsedContainer(
      verticalPadding: 4,
      horizontalPadding: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CacheImageReuse(
            imageUrl: userModel!.image,
            loadingHeight: 120,
            loadingWidth: double.infinity,
            imageBuilder: (ctx, image) => ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.radius12),
              child: Image(
                image: image,
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppPadding.smallPadding.sizedHeight,
          ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    userModel!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.title500.copyWith(
                      fontSize: AppFontSize.f16,
                    ),
                  ),
                ),
                if (AppConst.user?.isVendor == true)
                  BlocConsumer<FavouriteProvidersBloc, FavouriteProvidersState>(
                    listener: (context, state) {
                      if (state.toggleFavouriteProvidersState ==
                          RequestState.loaded) {
                        state
                            .toggleFavouriteProvidersResponse
                            .msg!
                            .showTopSuccessToast;
                        onAddToFav(
                          state.toggleFavouriteProvidersResponse.data!,
                        );
                      } else if (state.toggleFavouriteProvidersState ==
                          RequestState.error) {
                        state
                            .toggleFavouriteProvidersResponse
                            .msg!
                            .showTopErrorToast;
                      }
                    },
                    builder: (context, state) {
                      return AssetSvgImage(
                        userModel!.isFavorite
                            ? AssetImagesPath.favoriteFilledSVG
                            : AssetImagesPath.favoriteSVG,
                        color: AppColors.cPrimary,
                        width: 24,
                        height: 24,
                      ).addAction(
                        onTap: () {
                          FavouriteProvidersBloc.get(context).add(
                            FavouriteProvidersToggleEvent(
                              ToggleFavouriteProvidersParameters(
                                providerId: userModel!.id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
            AppPadding.smallPadding.sizedHeight,
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const AssetSvgImage(AssetImagesPath.fullStarSVG),
                      AppPadding.smallPadding.sizedWidth,
                      Text(
                        userModel!.rate.toString(),
                        style: AppStyles.title500.copyWith(
                          fontSize: AppFontSize.f16,
                        ),
                      ).addPadding(top: AppPadding.padding4),
                    ],
                  ),
                ),
                Text(
                  '(${userModel?.rateCounts ?? 0} ${'rating'.tr()})',
                  style: AppStyles.subtitle500.copyWith(
                    fontSize: AppFontSize.f14,
                  ),
                ).addPadding(top: AppPadding.padding4),
              ],
            ),
          ].paddingSymmetric(horizontal: AppPadding.smallPadding),
        ],
      ),
    ).addAction(
      borderRadius: 12,
      onTap: () {
        context.navigateToPage(ProvidersDetailsPage(providerId: userModel!.id));
      },
    );
  }
}
