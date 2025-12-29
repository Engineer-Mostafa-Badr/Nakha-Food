import 'package:flutter/material.dart';
import 'package:nakha/core/components/lists/sliver_list_view_with_pagination.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';
import 'package:nakha/features/support/presentation/pages/support_chat_consumer.dart';
import 'package:nakha/features/support/presentation/pages/support_chat_page.dart';
import 'package:nakha/features/support/presentation/widgets/tickets/ticket_item_widget.dart';

class TicketsSliverList extends StatelessWidget {
  const TicketsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SupportChatConsumer(
      builder: (bloc, state) {
        return SliverListViewWithPagination<TicketModel>(
          emptyMessage: 'no_tickets_found',
          errorMessage: state.getAllTicketsResponse.msg,
          itemWidget: (item) => TicketItemWidget(ticket: item).addAction(
            onTap: () {
              context.navigateToPage(
                SupportChatPage(
                  ticketID: item.id,
                  onChatTicketModel: (chatTicketModel) {
                    bloc.add(
                      UpdateTicketsLocalEvent(
                        // replace the ticket with the new one
                        state.getAllTicketsResponse.data!..replaceWhere(
                          (element) => element.id == item.id,
                          item.copyWith(
                            commentsCount: chatTicketModel?.comments.length,
                            status: chatTicketModel?.status,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          totalItems: state.getAllTicketsResponse.pagination?.total ?? 0,
          items: state.getAllTicketsResponse.data,
          model: state.getAllTicketsResponse.data,
          isListLoading:
              state.getAllTicketsState == RequestState.loading &&
              state.getAllTicketsResponse.data == null,
          isLoadMoreLoading: state.getAllTicketsState == RequestState.loading,
          padding: const EdgeInsets.all(AppPadding.largePadding),
          isLastPage:
              state.getAllTicketsResponse.pagination?.currentPage ==
              state.getAllTicketsResponse.pagination?.lastPage,
          onPressedLoadMore: () {
            bloc.add(
              GetAllTicketsEvent(
                parameters: PaginationParameters(
                  page: state.getAllTicketsResponse.pagination!.currentPage + 1,
                ),
              ),
            );
          },
          scrollController: bloc.scrollController,
        );
      },
    );
  }
}
