import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_products/favourite_products_bloc.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/presentation/pages/product_details_page.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.productsModel,
    required this.onAddToFav,
  });

  final ProductsModel productsModel;
  final Function(ProductsModel) onAddToFav;

  @override
  Widget build(BuildContext context) {
    return MostUsedContainer(
      verticalPadding: 4,
      horizontalPadding: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CacheImageReuse(
            imageUrl: productsModel.image,
            loadingHeight: 120,
            loadingWidth: double.infinity,
            imageBuilder: (ctx, image) => ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.radius12),
              child: Image(
                image: image,
                height: 120,
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
                    productsModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.title500.copyWith(
                      fontSize: AppFontSize.f16,
                    ),
                  ),
                ),
                if (AppConst.user!.isVendor)
                  BlocConsumer<FavouriteProductsBloc, FavouriteProductsState>(
                    listener: (context, state) {
                      if (state.toggleFavouriteProductsState ==
                          RequestState.loaded) {
                        state
                            .toggleFavouriteProductsResponse
                            .msg!
                            .showTopSuccessToast;
                        onAddToFav(state.toggleFavouriteProductsResponse.data!);
                      } else if (state.toggleFavouriteProductsState ==
                          RequestState.error) {
                        state
                            .toggleFavouriteProductsResponse
                            .msg!
                            .showTopErrorToast;
                      }
                    },
                    builder: (context, state) {
                      return AssetSvgImage(
                        productsModel.isFavourite
                            ? AssetImagesPath.favoriteFilledSVG
                            : AssetImagesPath.favoriteSVG,
                        color: AppColors.cPrimary,
                        width: 24,
                        height: 24,
                      ).addAction(
                        onTap: () {
                          FavouriteProductsBloc.get(context).add(
                            FavouriteProductsToggleEvent(
                              ToggleFavouriteProductsParameters(
                                productId: productsModel.id,
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
                        productsModel.rate.toString(),
                        style: AppStyles.title500.copyWith(
                          fontSize: AppFontSize.f16,
                        ),
                      ).addPadding(top: AppPadding.padding4),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      productsModel.price,
                      style: AppStyles.title900.copyWith(
                        color: AppColors.grey54Color,
                        fontSize: AppFontSize.f16,
                      ),
                    ),
                    AppPadding.padding4.sizedWidth,
                    Text(
                      'r.s',
                      style: AppStyles.title400.copyWith(
                        color: AppColors.grey54Color,
                      ),
                    ).tr(),
                  ],
                ),
              ],
            ),
          ].paddingSymmetric(horizontal: AppPadding.smallPadding),
        ],
      ),
    ).addAction(
      borderRadius: 12,
      onTap: () {
        context.navigateToPage(
          ProductDetailsPage(
            onUpdateProduct: onAddToFav,
            productId: productsModel.id,
          ),
        );
      },
    );
  }
}
