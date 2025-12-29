import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/lists/grid_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/favourite/presentation/bloc/favourite_products/favourite_products_bloc.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/product_item_widget.dart';

class FavouriteProductsBody extends StatelessWidget {
  const FavouriteProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteProductsBloc, FavouriteProductsState>(
      builder: (context, state) {
        return PullRefreshReuse(
          onRefresh: () async {
            FavouriteProductsBloc.get(context).add(
              FavouriteProductsFetchEvent(
                params: state.getFavouriteProductsParameters.copyWith(),
              ),
            );
          },
          child: GridViewWithPagination(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            emptyMessage: 'no_favourite_products',
            isListLoading:
                state.getFavouriteProductsState == RequestState.loading &&
                state.getFavouriteProductsParameters.page == 1,
            isLoadMoreLoading:
                state.getFavouriteProductsState == RequestState.loading &&
                state.getFavouriteProductsParameters.page > 1,
            model: state.getFavouriteProductsResponse.data,
            items: state.getFavouriteProductsResponse.data,
            isLastPage:
                state.getFavouriteProductsResponse.pagination?.currentPage ==
                state.getFavouriteProductsResponse.pagination?.lastPage,
            itemWidget: (provider) => ProductItemWidget(
              onAddToFav: (product) {},
              productsModel: provider,
            ),
            onPressedLoadMore: () {
              FavouriteProductsBloc.get(context).add(
                FavouriteProductsFetchEvent(
                  params: state.getFavouriteProductsParameters.copyWith(
                    page: state.getFavouriteProductsParameters.page + 1,
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
