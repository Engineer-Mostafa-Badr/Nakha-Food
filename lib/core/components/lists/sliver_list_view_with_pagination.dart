import 'package:flutter/material.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/components/lists/load_more_button.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SliverListViewWithPagination<T> extends StatefulWidget {
  const SliverListViewWithPagination({
    super.key,
    this.isListLoading = false,
    this.model,
    this.items,
    required this.emptyMessage,
    required this.itemWidget,
    this.isLoadMoreLoading = false,
    this.isLastPage = false,
    this.onPressedLoadMore,
    this.isScrollable = true,
    this.padding = EdgeInsets.zero,
    required this.totalItems,
    required this.scrollController,
    // required this.onRefresh,
    required this.errorMessage,
  });

  final bool isListLoading;
  final bool isLoadMoreLoading;
  final bool isLastPage;
  final dynamic model;
  final List<dynamic>? items;
  final Widget Function(T item) itemWidget;
  final VoidCallback? onPressedLoadMore;
  final bool isScrollable;
  final EdgeInsetsGeometry padding;
  final ScrollController scrollController;
  final String emptyMessage;
  final int totalItems;
  final String? errorMessage;

  // final Function() onRefresh;

  @override
  State<SliverListViewWithPagination<T>> createState() =>
      _SliverListViewWithPaginationState<T>();
}

class _SliverListViewWithPaginationState<T>
    extends State<SliverListViewWithPagination<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _listenToScrollController();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  /// listen to scroll controller to load more data
  void _listenToScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (!widget.isLoadMoreLoading && !widget.isLastPage) {
          widget.onPressedLoadMore!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMoreThanMaxPerPage =
        widget.items != null && widget.totalItems > PaginationModel.maxPerPage;
    return widget.isListLoading
        ? const SliverFillRemaining(child: LoadingWidget())
        : widget.model == null
        ? SliverFillRemaining(
            child: ErrorBody(
              // onRefresh: widget.onRefresh,
              errorMessage: widget.errorMessage,
            ),
          )
        : widget.items == null || widget.items!.isEmpty
        ? SliverFillRemaining(child: EmptyBody(text: widget.emptyMessage))
        : SliverPadding(
            padding: widget.padding,
            sliver: SliverList.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppPadding.largePadding),
              itemCount: isMoreThanMaxPerPage
                  ? widget.items!.length + 1
                  : widget.items!.length,
              itemBuilder: (context, index) {
                if (isMoreThanMaxPerPage && index == widget.items!.length) {
                  return LoadMoreButton(
                    isLoading: widget.isLoadMoreLoading,
                    isLastPage: widget.isLastPage,
                    onPressed: widget.onPressedLoadMore,
                  );
                }
                return widget.itemWidget(widget.items![index]);
              },
            ),
          );
  }
}
