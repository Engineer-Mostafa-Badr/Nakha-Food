import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/screen_status/loading_result_page_reuse.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/use_cases/show_product_usecase.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';
import 'package:nakha/features/providers/presentation/widgets/product_details/add_to_cart_button_product_details.dart';
import 'package:nakha/features/providers/presentation/widgets/product_details/product_details_section.dart';
import 'package:nakha/features/providers/presentation/widgets/product_details/product_details_slider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.onUpdateProduct,
  });

  final int productId;
  final Function(ProductsModel) onUpdateProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProvidersBloc>()
        ..add(
          ShowProductFetchEvent(
            params: ShowProductParameters(productId: productId),
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [BackButtonLeftIcon()],
        ),
        body: BlocBuilder<ProvidersBloc, ProvidersState>(
          buildWhen: (previous, current) =>
              previous.showProductState != current.showProductState ||
              previous.showProductResponse != current.showProductResponse,
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                ProvidersBloc.get(context).add(
                  ShowProductFetchEvent(
                    params: ShowProductParameters(productId: productId),
                  ),
                );
              },
              child: LoadingResultPageReuse(
                model: state.showProductResponse.data,
                isListLoading: state.showProductState == RequestState.loading,
                child: state.showProductResponse.data == null
                    ? const SizedBox.shrink()
                    : ListView(
                        children: [
                          ProductDetailsSlider(
                            items: List.generate(
                              state.showProductResponse.data!.images.length,
                              (index) => SlidersModel(
                                id: index,
                                cover: state
                                    .showProductResponse
                                    .data!
                                    .images[index],
                                subtitle: 'Subtitle $index',
                                title: 'Product Title $index',
                                specialText: 'Special Text $index',
                              ),
                            ),
                            // isLoading: false,
                          ),
                          32.sizedHeight,
                          ProductDetailsSection(
                            onAddToFav: (product) {
                              ProvidersBloc.get(
                                context,
                              ).add(ReplaceProductEvent(product));
                              onUpdateProduct(product);
                            },
                            productDetails: state.showProductResponse.data,
                          ).addPadding(
                            horizontal: AppPadding.mediumPadding,
                            bottom: AppPadding.padding12,
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<ProvidersBloc, ProvidersState>(
          builder: (context, state) {
            return state.showProductResponse.data == null ||
                    AppConst.user?.isVendor == true
                ? const SizedBox.shrink()
                : AddToCartButtonProductDetails(
                    product: state.showProductResponse.data!,
                    onAddToCart: (product) {
                      ProvidersBloc.get(
                        context,
                      ).add(ReplaceProductEvent(product));
                      onUpdateProduct(product);
                    },
                  );
          },
        ),
      ),
    );
  }
}
