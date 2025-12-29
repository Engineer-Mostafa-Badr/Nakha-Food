import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/lists/sliver_list_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';
import 'package:nakha/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nakha/features/wallet/presentation/widgets/previous_transactions_widget.dart';
import 'package:nakha/features/wallet/presentation/widgets/wallet_data_section.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WalletBloc>()..add(const WalletFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('wallet').tr(),
          automaticallyImplyLeading: false,
          actions: !showBackButton ? null : const [BackButtonLeftIcon()],
        ),
        body: BlocBuilder<WalletBloc, WalletState>(
          buildWhen: (previous, current) =>
              previous.getWalletState != current.getWalletState,
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                WalletBloc.get(context).add(const WalletFetchEvent());
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: WalletBloc.get(context).scrollController,
                slivers: [
                  if (state.getWalletResponse.data != null)
                    const SliverToBoxAdapter(child: WalletDataSection()),
                  SliverListViewWithPagination<TransactionModel>(
                    emptyMessage: 'no_transactions',
                    scrollController: WalletBloc.get(context).scrollController,
                    errorMessage: state.getWalletResponse.msg,
                    isListLoading:
                        state.getWalletState == RequestState.loading &&
                        state.getWalletParameters.page == 1,
                    isLoadMoreLoading:
                        state.getWalletState == RequestState.loading &&
                        state.getWalletParameters.page > 1,
                    padding: const EdgeInsetsDirectional.only(
                      start: AppPadding.largePadding,
                      end: AppPadding.largePadding,
                      bottom: AppPadding.largePadding,
                    ),
                    model: state.getWalletResponse.data,
                    items: state.getWalletResponse.data?.transactions,
                    onPressedLoadMore: () {
                      WalletBloc.get(context).add(
                        WalletFetchEvent(
                          params: state.getWalletParameters.copyWith(
                            page:
                                (state
                                        .getWalletResponse
                                        .pagination
                                        ?.currentPage ??
                                    0) +
                                1,
                          ),
                        ),
                      );
                    },
                    itemWidget: (item) =>
                        PreviousTransactionsWidget(transaction: item),
                    totalItems: state.getWalletResponse.pagination?.total ?? 0,
                    isLastPage:
                        state.getWalletResponse.pagination?.currentPage ==
                        state.getWalletResponse.pagination?.lastPage,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
