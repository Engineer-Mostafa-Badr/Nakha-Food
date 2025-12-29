import 'package:flutter/material.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/components/lists/load_more_button.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';

class SliverGridViewWithPagination<T> extends StatefulWidget {
  const SliverGridViewWithPagination({
    super.key,
    this.isListLoading = true,
    this.model,
    this.items,
    required this.itemWidget,
    this.isLoadMoreLoading = false,
    this.isLastPage = false,
    this.onPressedLoadMore,
    required this.gridDelegate,
    required this.emptyMessage,
    required this.loadingWidget,
  });

  final bool isListLoading;
  final bool isLoadMoreLoading;
  final bool isLastPage;
  final dynamic model;
  final List<T>? items;
  final Widget Function(int) itemWidget;
  final VoidCallback? onPressedLoadMore;
  final SliverGridDelegate gridDelegate;
  final String emptyMessage;
  final Widget loadingWidget;

  @override
  State<SliverGridViewWithPagination> createState() =>
      _SliverGridViewWithPaginationState();
}

class _SliverGridViewWithPaginationState
    extends State<SliverGridViewWithPagination> {
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

  /// Listen to the scroll controller to load more data
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
        widget.items != null &&
        widget.items!.length > PaginationModel.maxPerPage;
    return widget.isListLoading
        ? const SliverFillRemaining(child: LoadingWidget())
        // SliverGrid(
        //         delegate: SliverChildBuilderDelegate((context, index) {
        //           return Skeletonizer(child: widget.loadingWidget);
        //         }, childCount: 20),
        //         gridDelegate: widget.gridDelegate,
        //       )
        : widget.model == null
        ? const SliverFillRemaining(child: ErrorBody())
        : widget.items == null || widget.items!.isEmpty
        ? SliverFillRemaining(child: EmptyBody(text: widget.emptyMessage))
        : SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isMoreThanMaxPerPage && index == widget.items!.length) {
                  return LoadMoreButton(
                    isLoading: widget.isLoadMoreLoading,
                    isLastPage: widget.isLastPage,
                    onPressed: widget.onPressedLoadMore,
                  );
                }
                return widget.itemWidget(index);
              },
              childCount: isMoreThanMaxPerPage
                  ? widget.items!.length + 1
                  : widget.items!.length,
            ),
            gridDelegate: widget.gridDelegate,
          );
  }
}
