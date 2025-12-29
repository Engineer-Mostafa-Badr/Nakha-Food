import 'package:flutter/material.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/product_item_widget.dart';

class ProvidersDetailsProductsSection extends StatelessWidget {
  const ProvidersDetailsProductsSection({
    super.key,
    required this.products,
    required this.onAddToFav,
  });

  final List<ProductsModel> products;
  final Function(ProductsModel) onAddToFav;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.mediumPadding,
        vertical: AppPadding.mediumPadding,
      ),
      sliver: SliverGrid.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          return ProductItemWidget(
            onAddToFav: onAddToFav,
            productsModel: products[index],
          );
        },
      ),
    );
  }
}
