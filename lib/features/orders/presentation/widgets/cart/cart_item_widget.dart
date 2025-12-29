import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/utils/rating_bar_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_counter_widget.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    this.onQuantityChanged,
    this.productName = 'كيكة الشوكولاتة الفاخرة',
    this.price = '39.49',
    this.quantity = 0,
    this.image = '',
    this.rating = 0.0,
    this.onRatingChanged,
    this.imageSize = const Size(86, 86),
    this.productFontSize = 16,
    this.priceFontSize = 20,
  });

  final Function(int)? onQuantityChanged;
  final String productName;
  final String image;
  final String price;
  final int quantity;
  final double rating;
  final Function(double)? onRatingChanged;
  final Size imageSize;
  final double productFontSize;
  final double priceFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CacheImageReuse(
          imageUrl: image,
          loadingHeight: imageSize.height.h,
          loadingWidth: imageSize.width.w,
          imageBuilder: (context, image) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
              child: Image(
                image: image,
                height: imageSize.height,
                width: imageSize.width,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        AppPadding.mediumPadding.sizedWidth,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productName,
                style: AppStyles.title500.copyWith(
                  fontSize: productFontSize,
                  color: AppColors.grey54Color,
                ),
              ),
              AppPadding.padding4.sizedHeight,
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          price,
                          style: AppStyles.title900.copyWith(
                            color: AppColors.grey54Color,
                            fontSize: priceFontSize,
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
                  ),
                  CartCounterWidget(
                    initialQuantity: quantity,
                    onQuantityChanged: onQuantityChanged,
                  ),
                ],
              ),
              if (onRatingChanged != null) ...[
                AppPadding.padding4.sizedHeight,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: RatingBarReuse(
                    rating: rating,
                    itemPadding: 6,
                    onRatingUpdate: onRatingChanged,
                    size: 28,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
