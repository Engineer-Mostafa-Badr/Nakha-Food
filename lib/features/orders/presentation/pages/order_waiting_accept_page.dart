import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/screen_status/loading_result_page_reuse.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/use_cases/show_order_usecase.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_item_widget.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/order_pay_button.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/top_section_order_waiting_accept.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/vendor_order_buttons.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/orders_status_container.dart';

class OrderWaitingAcceptPage extends StatelessWidget {
  const OrderWaitingAcceptPage({super.key, required this.ordersModel});

  final OrdersModel ordersModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrdersBloc>()
            ..add(ShowOrderEvent(ShowOrderParams(orderId: ordersModel.id))),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: const SizedBox.shrink(),
          leadingWidth: 14,
          title: BlocBuilder<OrdersBloc, OrdersState>(
            buildWhen: (previous, current) =>
                previous.showOrderState != current.showOrderState ||
                previous.showOrderResponse != current.showOrderResponse,
            builder: (context, state) {
              return OrdersStatusContainer(
                status:
                    state.showOrderResponse.data?.status ?? ordersModel.status,
              );
            },
          ),
          actions: const [BackButtonLeftIcon()],
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          buildWhen: (previous, current) =>
              previous.showOrderState != current.showOrderState ||
              previous.showOrderResponse != current.showOrderResponse,
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                OrdersBloc.get(
                  context,
                ).add(ShowOrderEvent(ShowOrderParams(orderId: ordersModel.id)));
              },
              child: LoadingResultPageReuse(
                model: state.showOrderResponse.data,
                isListLoading: state.showOrderState == RequestState.loading,
                child: state.showOrderResponse.data == null
                    ? const SizedBox.shrink()
                    : CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: TopSectionOrderWaitingAccept(),
                          ),
                          SliverPadding(
                            padding: const EdgeInsetsDirectional.only(
                              start: AppPadding.padding30,
                              end: AppPadding.padding30,
                              bottom: AppPadding.padding30,
                            ),
                            sliver: SliverList.separated(
                              separatorBuilder: (context, index) =>
                                  AppPadding.largePadding.sizedHeight,
                              itemCount:
                                  state.showOrderResponse.data!.items.length,
                              itemBuilder: (context, index) {
                                return CartItemWidget(
                                  price: state
                                      .showOrderResponse
                                      .data!
                                      .items[index]
                                      .price,
                                  image: state
                                      .showOrderResponse
                                      .data!
                                      .items[index]
                                      .product
                                      .image,
                                  productName: state
                                      .showOrderResponse
                                      .data!
                                      .items[index]
                                      .product
                                      .name,
                                  quantity: state
                                      .showOrderResponse
                                      .data!
                                      .items[index]
                                      .qty,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
        bottomNavigationBar: AppConst.user!.userType == 'vendor'
            ? const VendorOrderButtons()
            : const OrderPayButton(),
      ),
    );
  }
}
