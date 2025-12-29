import 'package:flutter/material.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/components/lists/load_more_button.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class GridViewWithPagination extends StatefulWidget {
  const GridViewWithPagination({
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
  });

  final bool isListLoading;
  final bool isLoadMoreLoading;
  final bool isLastPage;
  final dynamic model;
  final List<dynamic>? items;
  final Widget Function(dynamic item) itemWidget;
  final VoidCallback? onPressedLoadMore;
  final SliverGridDelegate gridDelegate;

  final String emptyMessage;

  @override
  State<GridViewWithPagination> createState() => _GridViewWithPaginationState();
}

class _GridViewWithPaginationState extends State<GridViewWithPagination> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _listenToScrollController();
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
        widget.items != null &&
        widget.items!.length > PaginationModel.maxPerPage;
    return widget.isListLoading
        ? const LoadingWidget()
        : widget.model == null
        ? const ErrorBody()
        : widget.items == null || widget.items!.isEmpty
        ? EmptyBody(text: widget.emptyMessage)
        : GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.largePadding,
              horizontal: AppPadding.largePadding,
            ),
            gridDelegate: widget.gridDelegate,
            physics: const AlwaysScrollableScrollPhysics(),
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
          );
  }
}
