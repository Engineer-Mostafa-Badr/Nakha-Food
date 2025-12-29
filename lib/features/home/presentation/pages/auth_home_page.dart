import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/appbar/shared_home_app_bar.dart';
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
import 'package:nakha/features/home/presentation/widgets/departments/departments_list_view.dart';
import 'package:nakha/features/home/presentation/widgets/providers/providers_item_widget.dart';
import 'package:nakha/features/home/presentation/widgets/slider/special_offers_slider.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nakha/features/providers/presentation/pages/all_providers_page.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({super.key, this.showBackButton = false});

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
                              if (state
                                  .responseUtils
                                  .data!
                                  .categories
                                  .isNotEmpty)
                                DepartmentsListView(
                                  items: state.responseUtils.data!.categories,
                                ),
                              if (state.responseUtils.data!.vendors.isNotEmpty)
                                SeeAllRow(
                                  title: 'provider',
                                  onPressed: () {
                                    context.navigateToPage(
                                      AllProvidersPage(
                                        onAddToFav: (provider) {
                                          HomeBloc.get(
                                            context,
                                          ).add(ReplaceProviderEvent(provider));
                                        },
                                      ),
                                    );
                                  },
                                ).addPadding(
                                  start: AppPadding.mediumPadding,
                                  end: AppPadding.largePadding,
                                ),
                            ],
                          ),
                        ),
                        if (state.responseUtils.data!.vendors.isNotEmpty)
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.mediumPadding,
                              vertical: AppPadding.mediumPadding,
                            ),
                            sliver: SliverGrid.builder(
                              itemCount:
                                  state.responseUtils.data!.vendors.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: AppPadding.mediumPadding,
                                    crossAxisSpacing: AppPadding.mediumPadding,
                                    childAspectRatio: 0.82,
                                  ),
                              itemBuilder: (context, index) =>
                                  ProvidersItemWidget(
                                    userModel: state
                                        .responseUtils
                                        .data!
                                        .vendors[index],
                                    onAddToFav: (provider) {
                                      HomeBloc.get(
                                        context,
                                      ).add(ReplaceProviderEvent(provider));
                                    },
                                  ),
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
