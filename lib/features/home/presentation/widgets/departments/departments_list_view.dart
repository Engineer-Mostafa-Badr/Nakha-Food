import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/utils/see_all_row.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/presentation/widgets/departments/all_departments_page.dart';
import 'package:nakha/features/home/presentation/widgets/departments/department_list_view_item.dart';

class DepartmentsListView extends StatelessWidget {
  const DepartmentsListView({
    super.key,
    this.items = const [],
    this.isLoading = false,
  });

  final bool isLoading;
  final List<CategoriesModel> items;

  @override
  Widget build(BuildContext context) {
    final categories = isLoading
        ? List.generate(
            8,
            (index) => CategoriesModel(
              id: index,
              name: '$notSpecified ' * 3,
              cover: AssetImagesPath.networkImage(),
            ),
          )
        : items;
    return Column(
      children: [
        AppPadding.padding12.sizedHeight,
        SeeAllRow(
          title: 'main_departments',
          onPressed: () {
            context.navigateToPage(const AllDepartmentsPage());
          },
        ).addPadding(
          start: AppPadding.mediumPadding,
          end: AppPadding.largePadding,
        ),
        AppPadding.smallPadding.sizedHeight,
        SizedBox(
          height: 136.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.mediumPadding,
            ),
            separatorBuilder: (context, index) =>
                AppPadding.padding30.sizedWidth,
            itemBuilder: (context, index) {
              return DepartmentListViewItem(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
