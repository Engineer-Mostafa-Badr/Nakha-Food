import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/features/products/presentation/pages/add_product_page.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';
import 'package:nakha/features/providers/presentation/pages/product_details_page.dart';

class MyProductsItem extends StatelessWidget {
  const MyProductsItem({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.smallPadding,
        vertical: AppPadding.smallPadding,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: .8, color: Color(0xffDADADA))),
      ),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CacheImageReuse(
                imageUrl: productsModel.image,
                loadingHeight: 42,
                loadingWidth: 42,
                imageBuilder: (context, imageProvider) => Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.smallRadius,
                    ),
                    border: Border.all(color: AppColors.cFillBorderLight),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 2,
            child: Text(
              productsModel.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.subtitle400,
            ),
          ),
          Expanded(
            // flex: 2,
            child: Text(
              productsModel.price,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.subtitle400,
            ),
          ),
          Expanded(
            // flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AssetSvgImage(AssetImagesPath.viewSVG).addAction(
                  padding: const EdgeInsets.all(6),
                  borderRadius: 16,
                  onTap: () {
                    // Handle view action
                    context.navigateToPage(
                      ProductDetailsPage(
                        productId: productsModel.id,
                        onUpdateProduct: (product) {},
                      ),
                    );
                  },
                ),
                const AssetSvgImage(AssetImagesPath.editSVG).addAction(
                  padding: const EdgeInsets.all(6),
                  borderRadius: 16,
                  onTap: () async {
                    // Handle view action
                    final value = await context.navigateToPage(
                      AddProductPage(productModel: productsModel),
                    );
                    if (value == true) {
                      ProvidersBloc.get(
                        context,
                      ).add(const VendorProductsFetchEvent());
                    }
                  },
                ),
                const AssetSvgImage(AssetImagesPath.delete2SVG).addAction(
                  padding: const EdgeInsets.all(6),
                  borderRadius: 16,
                  onTap: () {
                    // Handle view action
                    OtherHelper.showAlertDialogWithTwoMiddleButtons(
                      context: context,
                      title: productsModel.name,
                      content: Text(
                        'are_you_sure_delete_product',
                        style: AppStyles.title500,
                      ).tr(),
                      onPressedNo: () {},
                      onPressedOk: () {
                        ProvidersBloc.get(
                          context,
                        ).add(DeleteProductEvent(productsModel.id));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
