import 'package:flutter/material.dart';
import 'package:nakha/core/components/appbar/shared_home_app_bar.dart';
import 'package:nakha/core/components/buttons/outlined_button.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/presentation/widgets/departments/departments_list_view.dart';
import 'package:nakha/features/home/presentation/widgets/our_services/our_services_list_view.dart';
import 'package:nakha/features/home/presentation/widgets/slider/special_offers_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedHomeAppBar(showBackButton: showBackButton),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                HomeSliders(
                  title: '',
                  items: List.generate(
                    3,
                    (index) => SlidersModel(
                      id: index,
                      cover: AssetImagesPath.networkImage(),
                      subtitle: 'Subtitle $index',
                      title: 'Title $index',
                      specialText: 'Special $index',
                    ),
                  ),
                ),
                DepartmentsListView(
                  items: List.generate(
                    5,
                    (index) => CategoriesModel(
                      id: index,
                      name: 'القسم ${index + 1}',
                      cover: AssetImagesPath.networkImage(),
                    ),
                  ),
                ),
                AppPadding.padding12.sizedHeight,
                Row(
                  children: [
                    Expanded(
                      child: ReusedRoundedButton(
                        text: 'request_consultation',
                        onPressed: () {},
                      ),
                    ),
                    AppPadding.padding8.sizedWidth,
                    Expanded(
                      child: ReusedOutlinedButton(
                        text: 'know_about_us',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ).addPadding(horizontal: AppPadding.mediumPadding),
                const OurServicesListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
