import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/components/lists/sliver_list_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:nakha/features/chat/presentation/widgets/all_chats/all_chats_widget.dart';
import 'package:nakha/features/injection_container.dart';

class AllChatsPage extends StatelessWidget {
  const AllChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatsBloc>()..add(const GetChatsEvent()),
      child: BlocBuilder<ChatsBloc, ChatsState>(
        buildWhen: (prev, current) =>
            prev.getChatsState != current.getChatsState,
        builder: (context, state) {
          return Scaffold(
            appBar: const SharedAppBar(title: 'all_chats'),
            body: PullRefreshReuse(
              onRefresh: () async {
                ChatsBloc.get(context).add(const GetChatsEvent());
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: ChatsBloc.get(context).chatsScrollController,
                slivers: [
                  SliverListViewWithPagination<ChatsModel>(
                    emptyMessage: 'no_chats_yet',
                    errorMessage: state.getChatsResponse.msg,
                    padding: const EdgeInsets.all(AppPadding.mediumPadding),
                    isListLoading:
                        state.getChatsState.isLoading &&
                        state.parameters.page == 1,
                    isLoadMoreLoading:
                        state.getChatsState.isLoading &&
                        state.parameters.page > 1,
                    // separatorBuilder: AppPadding.padding12.sizedHeight,
                    totalItems: state.getChatsResponse.pagination?.total ?? 0,
                    isLastPage:
                        state.getChatsResponse.pagination?.currentPage ==
                        state.getChatsResponse.pagination?.lastPage,
                    model: state.getChatsResponse.data,
                    items: state.getChatsResponse.data,
                    itemWidget: (item) => AllChatsWidget(chatModel: item),
                    onPressedLoadMore: () {
                      ChatsBloc.get(context).add(
                        GetChatsEvent(
                          parameters: state.parameters.copyWith(
                            page:
                                state.getChatsResponse.pagination!.currentPage +
                                1,
                          ),
                        ),
                      );
                    },
                    scrollController: ChatsBloc.get(
                      context,
                    ).chatsScrollController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
