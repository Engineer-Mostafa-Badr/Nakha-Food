import 'package:flutter/material.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/products/presentation/widgets/my_products/my_products_header_item.dart';

class MyProductsHeader extends StatelessWidget {
  const MyProductsHeader({super.key});

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
      child: const Row(
        children: [
          Expanded(child: MyProductsHeaderItem(text: 'product_image')),
          Expanded(
            // flex: 2,
            child: MyProductsHeaderItem(
              text: 'product_name',
              assSvg: AssetImagesPath.transferSVG,
            ),
          ),
          Expanded(
            child: MyProductsHeaderItem(
              text: 'product_price',
              assSvg: AssetImagesPath.transferSVG,
            ),
          ),
          Expanded(child: MyProductsHeaderItem(text: 'control')),
        ],
      ),
    );
  }
}
