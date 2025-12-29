import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/utils/rating_bar_reuse.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/use_cases/add_products_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_item_widget.dart';

class AddRatingPage extends StatefulWidget {
  const AddRatingPage({super.key, this.ordersModel});

  final OrdersModel? ordersModel;

  @override
  State<AddRatingPage> createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  late List<RateProductsParameters> rateProducts;
  late RateProductsParameters _vendorRating;

  @override
  void initState() {
    super.initState();
    rateProducts =
        widget.ordersModel?.items
            .map(
              (item) =>
                  RateProductsParameters(productId: item.product.id, rate: 0),
            )
            .toList() ??
        [];
    _vendorRating = const RateProductsParameters(productId: 0, rate: 0.0);
  }

  // validate that all products have a rating
  bool validateRatings() {
    if (_vendorRating.rate == 0.0) {
      'please_add_rating_to'
          .tr(namedArgs: {'productName': widget.ordersModel?.vendor.name ?? ''})
          .showTopInfoToast;
      return false; // Vendor rating is required
    }
    for (int i = 0; i < rateProducts.length; i++) {
      if (rateProducts[i].rate == 0.0) {
        'please_add_rating_to'
            .tr(
              namedArgs: {
                'productName': widget.ordersModel!.items[i].product.name,
              },
            )
            .showTopInfoToast;
        return false; // At least one product does not have a rating
      }
    }
    return true; // All products have ratings
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrdersBloc>(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [BackButtonLeftIcon()],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    'add_rating',
                    style: AppStyles.title900.copyWith(
                      color: AppColors.grey54Color,
                      fontSize: AppFontSize.f20,
                    ),
                  ).tr(),
                  AppPadding.padding4.sizedHeight,
                  Text(
                    'add_rating_desc',
                    style: AppStyles.title400.copyWith(
                      color: AppColors.grey54Color,
                    ),
                  ).tr(),
                  AppPadding.largePadding.sizedHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'vendor_rating',
                      style: AppStyles.title500.copyWith(
                        color: AppColors.grey54Color,
                        fontSize: AppFontSize.f16,
                      ),
                    ).tr(),
                  ),
                  AppPadding.largePadding.sizedHeight,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CacheImageReuse(
                        imageUrl: widget.ordersModel?.vendor.image ?? '',
                        loadingHeight: 86.h,
                        loadingWidth: 86.w,
                        imageBuilder: (context, image) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppBorderRadius.mediumRadius,
                            ),
                            child: Image(
                              image: image,
                              height: 86,
                              width: 86,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      AppPadding.mediumPadding.sizedWidth,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.ordersModel?.vendor.name ?? '',
                              style: AppStyles.title500.copyWith(
                                fontSize: AppFontSize.f16,
                                color: AppColors.grey54Color,
                              ),
                            ),
                            AppPadding.padding4.sizedHeight,
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: RatingBarReuse(
                                rating: _vendorRating.rate,
                                itemPadding: 6,
                                onRatingUpdate: (rating) {
                                  _vendorRating = _vendorRating.copyWith(
                                    rate: rating,
                                  );
                                },
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppPadding.largePadding.sizedHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'products_rating',
                      style: AppStyles.title500.copyWith(
                        color: AppColors.grey54Color,
                        fontSize: AppFontSize.f16,
                      ),
                    ).tr(),
                  ),
                ],
              ).addPadding(all: AppPadding.padding16),
            ),

            if (widget.ordersModel != null) ...[
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppPadding.padding16,
                  end: AppPadding.padding16,
                  bottom: AppPadding.padding16,
                ),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) =>
                      AppPadding.largePadding.sizedHeight,
                  itemCount: widget.ordersModel!.items.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      price: widget.ordersModel!.items[index].price,
                      image: widget.ordersModel!.items[index].product.image,
                      productName:
                          widget.ordersModel!.items[index].product.name,
                      quantity: widget.ordersModel!.items[index].qty,
                      onRatingChanged: (rating) {
                        rateProducts = rateProducts.map((product) {
                          if (product.productId ==
                              widget.ordersModel!.items[index].product.id) {
                            return rateProducts[index].copyWith(rate: rating);
                          }
                          return product;
                        }).toList();
                      },
                      rating: rateProducts[index].rate,
                    );
                  },
                ),
              ),
            ],
          ],
        ),
        bottomNavigationBar: ContainerForBottomNavButtons(
          child: BlocConsumer<OrdersBloc, OrdersState>(
            buildWhen: (prevState, currentState) =>
                prevState.rateProductsState != currentState.rateProductsState,
            listener: (context, state) {
              if (state.rateProductsState == RequestState.loaded) {
                state.rateProductsResponse.msg!.showTopSuccessToast;
                // context.navigateToPageWithClearStack(const LandingPage());
                Navigator.pop(context, true);
              } else if (state.rateProductsState == RequestState.error) {
                state.rateProductsResponse.msg!.showTopErrorToast;
              }
            },
            builder: (context, state) {
              return ReusedRoundedButton(
                text: 'send_rating',
                isLoading: state.rateProductsState == RequestState.loading,
                onPressed: () {
                  if (validateRatings()) {
                    OrdersBloc.get(context).add(
                      RateProductsEvent(
                        AllRatesParams(
                          orderId: widget.ordersModel!.id,
                          vendorRate: _vendorRating,
                          rates: rateProducts,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
