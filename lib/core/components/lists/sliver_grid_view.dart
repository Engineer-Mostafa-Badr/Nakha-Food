import 'package:flutter/material.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';

class SliverGridViewReuse<T> extends StatelessWidget {
  const SliverGridViewReuse({
    super.key,
    this.isListLoading = true,
    this.model,
    this.items,
    this.scrollController,
    required this.itemWidget,
    required this.gridDelegate,
    required this.emptyMessage,
  });

  final bool isListLoading;
  final dynamic model;
  final List<T?>? items;
  final ScrollController? scrollController;
  final Widget Function(T? item) itemWidget;
  final SliverGridDelegate gridDelegate;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return isListLoading
        ? const SliverFillRemaining(child: LoadingWidget())
        : model == null
        ? const SliverFillRemaining(child: ErrorBody())
        : items == null || items!.isEmpty
        ? SliverFillRemaining(child: EmptyBody(text: emptyMessage))
        : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return itemWidget(items![index]);
            }, childCount: items!.length),
            gridDelegate: gridDelegate,
          );
  }
}
