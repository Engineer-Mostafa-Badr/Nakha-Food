import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/lists/grid_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/use_cases/get_products_usecase.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/product_item_widget.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key, this.onAddToFav, this.params});

  final ProductsParameters? params;
  final Function(ProductsModel productsModel)? onAddToFav;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProvidersBloc>()
        ..add(ProductsFetchEvent(params: params ?? const ProductsParameters())),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(params?.categoryName ?? 'all_products'.tr()),
          actions: const [BackButtonLeftIcon()],
        ),
        body: BlocBuilder<ProvidersBloc, ProvidersState>(
          buildWhen: (previous, current) {
            return previous.getProductsState != current.getProductsState;
          },
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                ProvidersBloc.get(context).add(
                  ProductsFetchEvent(
                    params: state.getProductsParameters.copyWith(),
                  ),
                );
              },
              child: GridViewWithPagination(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                emptyMessage: 'no_products_found',
                isListLoading:
                    state.getProductsState == RequestState.loading &&
                    state.getProductsParameters.page == 1,
                isLoadMoreLoading:
                    state.getProductsState == RequestState.loading &&
                    state.getProductsParameters.page > 1,
                model: state.getProductsResponse.data,
                items: state.getProductsResponse.data,
                isLastPage:
                    state.getProductsResponse.pagination?.currentPage ==
                    state.getProductsResponse.pagination?.lastPage,
                itemWidget: (provider) => ProductItemWidget(
                  onAddToFav: (product) {
                    onAddToFav?.call(product);
                    ProvidersBloc.get(
                      context,
                    ).add(ReplaceProductEvent(product));
                  },
                  productsModel: provider,
                ),
                onPressedLoadMore: () {
                  ProvidersBloc.get(context).add(
                    ProductsFetchEvent(
                      params: state.getProductsParameters.copyWith(
                        page: state.getProductsParameters.page + 1,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
