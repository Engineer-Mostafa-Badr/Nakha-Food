import 'package:flutter/material.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/components/lists/load_more_button.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class ListViewWithPagination<T> extends StatefulWidget {
  const ListViewWithPagination({
    super.key,
    this.isListLoading = true,
    this.model,
    this.items,
    required this.itemWidget,
    this.isLoadMoreLoading = false,
    this.isLastPage = false,
    this.onPressedLoadMore,
    required this.emptyMessage,
    this.errorMessage,
    this.separatorBuilder = const SizedBox(height: AppPadding.largePadding),
    this.padding,
    required this.totalItems,
  });

  final bool isListLoading;
  final bool isLoadMoreLoading;
  final bool isLastPage;
  final dynamic model;
  final List<T>? items;
  final Widget Function(T? item, int) itemWidget;
  final Widget separatorBuilder;
  final VoidCallback? onPressedLoadMore;
  final String emptyMessage;
  final String? errorMessage;
  final EdgeInsetsGeometry? padding;
  final int totalItems;

  @override
  State<ListViewWithPagination<T>> createState() =>
      _ListViewWithPaginationState<T>();
}

class _ListViewWithPaginationState<T> extends State<ListViewWithPagination<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
        MostUsedFunctions.printFullText('Load more');
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
        ? const LoadingWidget()
        : widget.model == null
        ? ErrorBody(errorMessage: widget.errorMessage)
        : widget.items == null || widget.items!.isEmpty
        ? EmptyBody(text: widget.emptyMessage)
        : ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(
                  vertical: AppPadding.largePadding,
                  horizontal: AppPadding.largePadding,
                ),
            controller: _scrollController,
            separatorBuilder: (context, index) => widget.separatorBuilder,
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
              return widget.itemWidget(widget.items![index], index);
            },
          );
  }
}
