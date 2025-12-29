import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_providers/favourite_providers_bloc.dart';
import 'package:nakha/features/favourite/presentation/widgets/favourite_products/favourite_products_body.dart';
import 'package:nakha/features/favourite/presentation/widgets/favourite_providers/favourite_providers_body.dart';
import 'package:nakha/features/injection_container.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<FavouriteProvidersBloc>()
                  ..add(const FavouriteProvidersFetchEvent()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: const [BackButtonLeftIcon()],
            bottom: TabBar(
              labelColor: AppColors.cPrimary,
              unselectedLabelColor: AppColors.grey54Color,
              labelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppConst.fontName(context),
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppConst.fontName(context),
              ),
              dividerColor: const Color(0xFFEFEEEA),
              tabs: [
                Tab(text: 'providers'.tr()),
                Tab(text: 'products'.tr()),
              ],
              onTap: (int index) {},
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.mediumPadding,
              ),
            ),
          ),
          body: const TabBarView(
            children: [FavouriteProvidersBody(), FavouriteProductsBody()],
          ),
        ),
      ),
    );
  }
}
