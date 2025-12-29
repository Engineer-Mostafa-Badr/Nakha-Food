import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/lists/list_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/orders_item_widget.dart';
import 'package:nakha/features/orders/presentation/widgets/orders/vendor/order_vendor_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrdersBloc>()..add(const OrdersFetchEvent()),
      child: DefaultTabController(
        length: OrderStatusFilterEnum.values.length,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(58.h),
              child: BlocBuilder<OrdersBloc, OrdersState>(
                buildWhen: (prevState, currentState) =>
                    prevState.getOrdersState != currentState.getOrdersState,
                builder: (context, state) {
                  return TabBar(
                    labelColor: AppColors.cPrimary,
                    indicatorColor: Colors.blue,
                    unselectedLabelColor: AppColors.grey54Color,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConst.fontName(context),
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConst.fontName(context),
                    ),
                    dividerColor: const Color(0xFFEFEEEA),
                    tabs: List.generate(OrderStatusFilterEnum.values.length, (
                      index,
                    ) {
                      return Tab(
                        text: OrderStatusFilterEnum.values[index].name.tr(
                          namedArgs: {
                            'count': [
                              state.getOrdersResponse.data?.allOrdersCount ?? 0,
                              state.getOrdersResponse.data?.pendingOrders ?? 0,
                              state
                                      .getOrdersResponse
                                      .data
                                      ?.approvedCompletedOrders ??
                                  0,
                              state.getOrdersResponse.data?.cancelledOrders ??
                                  0,
                            ][index].toString(),
                          },
                        ),
                      );
                    }),
                    onTap: (int index) {
                      // Handle tab selection
                      OrdersBloc.get(context).add(
                        OrdersFetchEvent(
                          params: state.getOrdersParameters.copyWith(
                            status: OrdersStatusEnum.values[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          body: BlocBuilder<OrdersBloc, OrdersState>(
            buildWhen: (prevState, currentState) =>
                prevState.getOrdersState != currentState.getOrdersState ||
                prevState.getOrdersResponse != currentState.getOrdersResponse,
            builder: (context, state) {
              return PullRefreshReuse(
                onRefresh: () async {
                  OrdersBloc.get(context).add(
                    OrdersFetchEvent(
                      params: state.getOrdersParameters.copyWith(),
                    ),
                  );
                },
                child: ListViewWithPagination(
                  padding: const EdgeInsets.all(AppPadding.mediumPadding),
                  separatorBuilder: AppPadding.padding12.sizedHeight,
                  emptyMessage: 'no_orders',
                  isListLoading:
                      state.getOrdersState == RequestState.loading &&
                      state.getOrdersParameters.page == 1,
                  isLoadMoreLoading:
                      state.getOrdersState == RequestState.loading &&
                      state.getOrdersParameters.page > 1,
                  model: state.getOrdersResponse.data,
                  items: state.getOrdersResponse.data?.orders,
                  isLastPage:
                      state.getOrdersResponse.pagination?.currentPage ==
                      state.getOrdersResponse.pagination?.lastPage,
                  itemWidget: (item, index) => AppConst.user?.isVendor == true
                      ? OrderVendorItem(
                          key: ValueKey(
                            item?.id ?? DateTime.now().microsecondsSinceEpoch,
                          ),
                          ordersModel: item!,
                        )
                      : OrdersItemWidget(
                          key: ValueKey(
                            item?.id ?? DateTime.now().microsecondsSinceEpoch,
                          ),
                          ordersModel: item!,
                        ),
                  onPressedLoadMore: () {
                    OrdersBloc.get(context).add(
                      OrdersFetchEvent(
                        params: state.getOrdersParameters.copyWith(
                          page: state.getOrdersParameters.page + 1,
                        ),
                      ),
                    );
                  },
                  totalItems: state.getOrdersResponse.pagination?.total ?? 0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
