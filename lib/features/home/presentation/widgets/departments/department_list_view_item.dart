import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/delay_login.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/products/presentation/pages/all_products_page.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';

class DepartmentListViewItem extends StatelessWidget {
  const DepartmentListViewItem({
    super.key,
    this.height = 65,
    this.width = 65,
    required this.category,
  });

  final double? height;
  final double? width;
  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CacheImageReuse(
          imageUrl: category.cover,
          loadingHeight: height,
          loadingWidth: width,
          imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        AppPadding.padding12.sizedHeight,
        Text(
          category.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.title500,
        ),
      ],
    ).addAction(
      borderRadius: 10,
      onTap: () {
        CheckLoginDelay.checkIfNeedLogin(
          onExecute: () {
            context.navigateToPage(
              AllProductsPage(
                params: ProductsParameters(
                  categoryId: category.id,
                  categoryName: category.name,
                ),
                onAddToFav: (product) {
                  // HomeBloc.get(context).add(const GetHomeUtilsEvent());
                },
              ),
            );
          },
        );
      },
    );
  }
}
