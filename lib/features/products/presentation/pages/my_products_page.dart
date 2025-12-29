import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/lists/list_view_with_pagination.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/products/presentation/pages/add_product_page.dart';
import 'package:nakha/features/products/presentation/widgets/my_products/my_products_header.dart';
import 'package:nakha/features/products/presentation/widgets/my_products/my_products_item.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ProvidersBloc>()..add(const VendorProductsFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('my_products').tr(),
          automaticallyImplyLeading: false,
          actions: const [BackButtonLeftIcon()],
        ),
        body: const ProductTable(),
        bottomNavigationBar: BlocBuilder<ProvidersBloc, ProvidersState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return ContainerForBottomNavButtons(
              child: ReusedRoundedButton(
                text: 'add_product',
                onPressed: () async {
                  final value = await context.navigateToPage(
                    const AddProductPage(),
                  );
                  if (value == true) {
                    ProvidersBloc.get(
                      context,
                    ).add(const VendorProductsFetchEvent());
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Product Table
class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProvidersBloc, ProvidersState>(
      buildWhen: (previous, current) {
        return previous.getVendorProductsState !=
            current.getVendorProductsState;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (state.getVendorProductsResponse.pagination?.total != null)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.cFillBorderLight),
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.smallRadius,
                    ),
                  ),
                  child: Text(
                    'all_products_count'.tr(
                      namedArgs: {
                        'count': state
                            .getVendorProductsResponse
                            .pagination!
                            .total
                            .toString(),
                      },
                    ),
                    style: AppStyles.subtitle500.copyWith(
                      fontSize: AppFontSize.f10,
                    ),
                  ),
                ),
              ),
            // Header Row
            const MyProductsHeader(),
            // Product Rows
            Expanded(
              // child: ListView.builder(
              //   itemCount: products.length,
              //   itemBuilder: (context, index) {
              //     return MyProductsItem(productsModel: products[index]);
              //   },
              // ),
              child: PullRefreshReuse(
                onRefresh: () async {
                  ProvidersBloc.get(context).add(
                    VendorProductsFetchEvent(
                      params: state.getVendorProductsParameters.copyWith(),
                    ),
                  );
                },
                child: ListViewWithPagination(
                  emptyMessage: 'no_products_found',
                  isListLoading:
                      state.getVendorProductsState == RequestState.loading &&
                      state.getVendorProductsParameters.page == 1,
                  isLoadMoreLoading:
                      state.getVendorProductsState == RequestState.loading &&
                      state.getVendorProductsParameters.page > 1,
                  model: state.getVendorProductsResponse.data,
                  items: state.getVendorProductsResponse.data,
                  isLastPage:
                      state.getVendorProductsResponse.pagination?.currentPage ==
                      state.getVendorProductsResponse.pagination?.lastPage,
                  itemWidget: (item, index) =>
                      MyProductsItem(productsModel: item!),
                  onPressedLoadMore: () {
                    ProvidersBloc.get(context).add(
                      VendorProductsFetchEvent(
                        params: state.getVendorProductsParameters.copyWith(
                          page: state.getVendorProductsParameters.page + 1,
                        ),
                      ),
                    );
                  },
                  totalItems:
                      state.getVendorProductsResponse.pagination?.total ?? 0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
