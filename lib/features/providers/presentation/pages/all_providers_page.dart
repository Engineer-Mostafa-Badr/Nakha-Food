import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/appbar/shared_home_app_bar.dart';
import 'package:nakha/core/components/lists/grid_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/presentation/widgets/providers/all_providers_bottom_sheet.dart';
import 'package:nakha/features/home/presentation/widgets/providers/providers_item_widget.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';

class AllProvidersPage extends StatelessWidget {
  const AllProvidersPage({super.key, required this.onAddToFav});

  final Function(ProvidersModel) onAddToFav;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ProvidersBloc>()..add(const ProvidersFetchEvent()),
      child: Scaffold(
        appBar: SharedHomeAppBar(
          showBackButton: true,
          actions: [
            BlocBuilder<ProvidersBloc, ProvidersState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Text(
                      'provider',
                      style: AppStyles.subtitle400.copyWith(
                        fontSize: AppFontSize.f16,
                      ),
                    ).tr(),
                    AppPadding.padding4.sizedWidth,
                    const AssetSvgImage(AssetImagesPath.filterSVG),
                  ],
                ).addAction(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.mediumPadding,
                    vertical: AppPadding.padding4,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return AllProvidersBottomSheet(
                          parameters: state.getProvidersParameters,
                          providersCount:
                              state.getProvidersResponse.pagination?.total ?? 0,
                          onFilterApplied: (params) {
                            ProvidersBloc.get(
                              context,
                            ).add(ProvidersFetchEvent(params: params));
                          },
                        );
                      },
                    );
                  },
                  borderRadius: 10.0,
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'provider',
              style: AppStyles.title500.copyWith(fontSize: AppFontSize.f16),
            ).tr().addPadding(
              start: AppPadding.mediumPadding,
              top: AppPadding.mediumPadding,
              end: AppPadding.mediumPadding,
            ),
            Expanded(
              child: BlocBuilder<ProvidersBloc, ProvidersState>(
                buildWhen: (previous, current) {
                  return previous.getProvidersState !=
                      current.getProvidersState;
                },
                builder: (context, state) {
                  return PullRefreshReuse(
                    onRefresh: () async {
                      ProvidersBloc.get(context).add(
                        ProvidersFetchEvent(
                          params: state.getProvidersParameters.copyWith(),
                        ),
                      );
                    },
                    child: GridViewWithPagination(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .85,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      emptyMessage: 'no_providers_found',
                      isListLoading:
                          state.getProvidersState == RequestState.loading &&
                          state.getProvidersParameters.page == 1,
                      isLoadMoreLoading:
                          state.getProvidersState == RequestState.loading &&
                          state.getProvidersParameters.page > 1,
                      model: state.getProvidersResponse.data,
                      items: state.getProvidersResponse.data,
                      isLastPage:
                          state.getProvidersResponse.pagination?.currentPage ==
                          state.getProvidersResponse.pagination?.lastPage,
                      itemWidget: (provider) => ProvidersItemWidget(
                        userModel: provider,
                        onAddToFav: (provider) {
                          ProvidersBloc.get(
                            context,
                          ).add(ReplaceProviderEvent(provider));
                          onAddToFav(provider);
                        },
                      ),
                      onPressedLoadMore: () {
                        ProvidersBloc.get(context).add(
                          ProvidersFetchEvent(
                            params: state.getProvidersParameters.copyWith(
                              page: state.getProvidersParameters.page + 1,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
