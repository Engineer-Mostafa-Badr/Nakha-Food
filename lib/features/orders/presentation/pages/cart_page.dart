import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/loading_result_page_reuse.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_list_view.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/cart_privacy_section.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrdersBloc>()..add(const GetCartEvent()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          buildWhen: (previous, current) =>
              previous.getCartState != current.getCartState ||
              current.getCartResponse.data!.items.isEmpty,
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                OrdersBloc.get(context).add(const GetCartEvent());
              },
              child: LoadingResultPageReuse(
                isListLoading: state.getCartState == RequestState.loading,
                model: state.getCartResponse.data,
                child: state.getCartResponse.data == null
                    ? const SizedBox.shrink()
                    : state.getCartResponse.data!.items.isEmpty
                    ? const EmptyBody(text: 'cart_empty')
                    : const Column(
                        children: [
                          Expanded(child: CartListView()),
                          CartPrivacySection(),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
