import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/lists/grid_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_providers/favourite_providers_bloc.dart';
import 'package:nakha/features/home/presentation/widgets/providers/providers_item_widget.dart';

class FavouriteProvidersBody extends StatelessWidget {
  const FavouriteProvidersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteProvidersBloc, FavouriteProvidersState>(
      builder: (context, state) {
        return PullRefreshReuse(
          onRefresh: () async {
            FavouriteProvidersBloc.get(context).add(
              FavouriteProvidersFetchEvent(
                params: state.getFavouriteProvidersParameters.copyWith(),
              ),
            );
          },
          child: GridViewWithPagination(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            emptyMessage: 'no_favourite_providers',
            isListLoading:
                state.getFavouriteProvidersState == RequestState.loading &&
                state.getFavouriteProvidersParameters.page == 1,
            isLoadMoreLoading:
                state.getFavouriteProvidersState == RequestState.loading &&
                state.getFavouriteProvidersParameters.page > 1,
            model: state.getFavouriteProvidersResponse.data,
            items: state.getFavouriteProvidersResponse.data,
            isLastPage:
                state.getFavouriteProvidersResponse.pagination?.currentPage ==
                state.getFavouriteProvidersResponse.pagination?.lastPage,
            itemWidget: (provider) => ProvidersItemWidget(
              userModel: provider,
              onAddToFav: (provider) {},
            ),
            onPressedLoadMore: () {
              FavouriteProvidersBloc.get(context).add(
                FavouriteProvidersFetchEvent(
                  params: state.getFavouriteProvidersParameters.copyWith(
                    page: state.getFavouriteProvidersParameters.page + 1,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
