import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/favourite/domain/use_cases/toggle_favourite_products_usecase.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_products/favourite_products_bloc.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({
    super.key,
    required this.productDetails,
    required this.onAddToFav,
  });

  final ShowProductModel? productDetails;
  final Function(ProductsModel) onAddToFav;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                productDetails!.name,
                style: AppStyles.title900.copyWith(
                  fontSize: AppFontSize.f20,
                  color: AppColors.grey54Color,
                ),
              ),
            ),
            if (AppConst.user!.isVendor) ...[
              AppPadding.smallPadding.sizedWidth,
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
                    productDetails!.isFavorite
                        ? AssetImagesPath.favoriteFilledSVG
                        : AssetImagesPath.favoriteSVG,
                    color: AppColors.cPrimary,
                    width: 24,
                    height: 24,
                  ).addAction(
                    padding: const EdgeInsets.all(AppPadding.smallPadding),
                    borderRadius: 40,
                    onTap: () {
                      FavouriteProductsBloc.get(context).add(
                        FavouriteProductsToggleEvent(
                          ToggleFavouriteProductsParameters(
                            productId: productDetails!.id,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ],
        ),
        AppPadding.padding12.sizedHeight,
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const AssetSvgImage(AssetImagesPath.fullStarSVG),
                  AppPadding.smallPadding.sizedWidth,
                  Text(
                    productDetails!.rate.toString(),
                    style: AppStyles.title500.copyWith(
                      fontSize: AppFontSize.f16,
                    ),
                  ).addPadding(
                    top: AppPadding.padding4,
                    end: AppPadding.padding4,
                  ),
                  Text(
                    '(${productDetails!.rateCounts} ${'rating'.tr()})',
                    style: AppStyles.subtitle400.copyWith(
                      fontSize: AppFontSize.f14,
                    ),
                  ).addPadding(top: AppPadding.padding4),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  productDetails!.price,
                  style: AppStyles.title900.copyWith(
                    color: AppColors.grey54Color,
                    fontSize: AppFontSize.f32,
                  ),
                ),
                AppPadding.padding4.sizedWidth,
                Text(
                  'r.s',
                  style: AppStyles.title400.copyWith(
                    color: AppColors.grey54Color,
                    fontSize: AppFontSize.f16,
                  ),
                ).tr(),
              ],
            ),
          ],
        ),
        AppPadding.largePadding.sizedHeight,
        Text(
          'description',
          style: AppStyles.title500.copyWith(
            fontSize: AppFontSize.f16,
            color: AppColors.grey54Color,
          ),
        ).tr(),
        AppPadding.smallPadding.sizedHeight,
        Text(
          productDetails!.description,
          style: AppStyles.title400.copyWith(color: AppColors.grey54Color),
        ).tr(),
        28.sizedHeight,
        ReusedTextFormField(
          title: 'order_prepare_duration',
          fillColor: const Color(0xFFF7F5ED),
          readOnly: true,
          hintText: 'average_time',
          suffixText: productDetails!.preparationMsg,
          titleColor: AppColors.grey54Color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
            borderSide: BorderSide.none,
          ),
        ),
        32.sizedHeight,
        Row(
          children: [
            AssetSvgImage(
              productDetails!.deliveryAvailable == 1
                  ? AssetImagesPath.tickCircleSVG
                  : AssetImagesPath.closeCircleTickSVG,
            ),
            AppPadding.padding4.sizedWidth,
            Text(
              productDetails!.deliveryAvailable == 1
                  ? 'avaliable_delivery'
                  : 'not_avaliable_delivery',
              style: AppStyles.title400,
            ).tr(),
          ],
        ),
      ],
    );
  }
}
