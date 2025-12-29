import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/appbar/shared_home_app_bar.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/screen_status/loading_result_page_reuse.dart';
import 'package:nakha/core/components/utils/see_all_row.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/home/presentation/pages/fore_update_page.dart';
import 'package:nakha/features/home/presentation/widgets/slider/special_offers_slider.dart';
import 'package:nakha/features/home/presentation/widgets/vendor_home/new_orders_slider.dart';
import 'package:nakha/features/home/presentation/widgets/vendor_home/order_services.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';
import 'package:nakha/features/products/presentation/pages/my_products_page.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

class VendorHomePage extends StatelessWidget {
  const VendorHomePage({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedHomeAppBar(showBackButton: showBackButton),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.requestUtilsState == RequestState.loaded) {
            if (state.responseUtils.data!.androidVersionNumber >
                    AppConst.versionNumber &&
                Platform.isAndroid) {
              sl<MainSecureStorage>().putIsAppUpdated(false);
              context.navigateToPageWithClearStack(
                ForeUpdatePage(settingsModel: state.responseUtils.data),
              );
            } else if (state.responseUtils.data!.iosVersionNumber >
                    AppConst.versionNumber &&
                Platform.isIOS) {
              sl<MainSecureStorage>().putIsAppUpdated(false);
              context.navigateToPageWithClearStack(
                ForeUpdatePage(settingsModel: state.responseUtils.data),
              );
            }
          }
        },
        builder: (context, state) {
          final vendorData = state.responseUtils.data?.vendorData;
          return PullRefreshReuse(
            onRefresh: () async {
              HomeBloc.get(context).add(const GetHomeUtilsEvent());
              ProfileBloc.get(context).add(const GetProfileEvent());
            },
            child: LoadingResultPageReuse(
              model: state.responseUtils.data,
              isListLoading: state.requestUtilsState == RequestState.loading,
              child: state.responseUtils.data == null
                  ? const SizedBox.shrink()
                  : CustomScrollView(
                      cacheExtent: AppConst.cacheExtent,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              HomeSliders(
                                title: 'slider_title',
                                items: state.responseUtils.data!.sliders,
                              ),
                              AppPadding.largePadding.sizedHeight,
                              OrderServices(vendorDataModel: vendorData),
                              if (vendorData?.accountStatus == 'active') ...[
                                AppPadding.largePadding.sizedHeight,
                                ReusedRoundedButton(
                                  text: 'mange_products',
                                  width: 250,
                                  radius: 30,
                                  onPressed: () {
                                    context.navigateToPage(
                                      const MyProductsPage(),
                                    );
                                  },
                                ),
                              ],
                              AppPadding.largePadding.sizedHeight,
                              if (state
                                      .responseUtils
                                      .data!
                                      .vendors
                                      .isNotEmpty ||
                                  true) ...[
                                SeeAllRow(
                                  title: 'new_orders',
                                  onPressed: () {
                                    context.navigateToPageWithClearStack(
                                      const LandingPage(index: 1),
                                    );
                                  },
                                ).addPadding(
                                  start: AppPadding.mediumPadding,
                                  end: AppPadding.largePadding,
                                ),
                                NewOrderSlider(
                                  items: vendorData!.pendingOrdersList,
                                ),
                              ],

                              if (vendorData.accountStatus != 'active') ...[
                                AppPadding.largePadding.sizedHeight,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 70,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.cError,
                                    borderRadius: BorderRadius.circular(
                                      AppBorderRadius.mediumRadius,
                                    ),
                                  ),
                                  child: Text(
                                    'vendor_home_page_warning',
                                    textAlign: TextAlign.center,
                                    style: AppStyles.title700.copyWith(
                                      color: Colors.white,
                                      fontSize: AppFontSize.f16,
                                    ),
                                  ).tr(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
