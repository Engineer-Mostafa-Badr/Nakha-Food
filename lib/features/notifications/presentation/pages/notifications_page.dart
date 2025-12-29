import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/lists/list_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';
import 'package:nakha/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:nakha/features/notifications/presentation/widgets/notification_item.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<NotificationsBloc>()
            ..add(const NotificationsFetchEvent(PaginationParameters())),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [BackButtonLeftIcon()],
          title: const Text('notifications').tr(),
        ),
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                NotificationsBloc.get(
                  context,
                ).add(const NotificationsFetchEvent(PaginationParameters()));
              },
              child: ListViewWithPagination<NotificationsModel>(
                padding: const EdgeInsets.all(AppPadding.largePadding),
                emptyMessage: 'no_notifications',
                isListLoading:
                    state.getNotificationsState == RequestState.loading &&
                    state.getNotificationsResponse.data == null,
                model: state.getNotificationsResponse.data,
                items: state.getNotificationsResponse.data,
                itemWidget: (item, index) =>
                    NotificationListTile(notificationsEntities: item),
                totalItems:
                    state.getNotificationsResponse.pagination?.total ?? 0,
                isLoadMoreLoading:
                    state.getNotificationsState == RequestState.loading,
                isLastPage:
                    state.getNotificationsResponse.pagination?.currentPage ==
                    state.getNotificationsResponse.pagination?.lastPage,
                onPressedLoadMore: () {
                  NotificationsBloc.get(context).add(
                    NotificationsFetchEvent(
                      PaginationParameters(
                        page:
                            state
                                .getNotificationsResponse
                                .pagination!
                                .currentPage +
                            1,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),

        ///
        // body: ListView.separated(
        //   itemCount: 20,
        //   separatorBuilder: (context, index) =>
        //       AppPadding.largePadding.sizedHeight,
        //   padding: const EdgeInsets.all(
        //     AppPadding.largePadding,
        //   ),
        //   itemBuilder: (context, index) => NotificationItem(
        //     notification: NotificationsEntities(
        //       dayName: 'اليوم',
        //       dayNotifications: List.generate(
        //         3,
        //         (index) => DayNotificationsEntities(
        //           title: 'تم الحجز بنجاح',
        //           content: 'تم الحجز بنجاح',
        //           id: index,
        //           type: 'type',
        //           createdAt: DateTime.now().toString(),
        //           isSeen: false,
        //           itemId: index,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
