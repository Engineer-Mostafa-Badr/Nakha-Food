import 'package:flutter/material.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SliverListViewReuse<T> extends StatelessWidget {
  const SliverListViewReuse({
    super.key,
    this.isListLoading = true,
    this.model,
    this.items,
    required this.itemWidget,
    required this.emptyMessage,
    this.errorMessage,
    this.isSlivers = true,
    this.reverse = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.padding = EdgeInsets.zero,
    this.separator,
  });

  final Widget? separator;
  final bool isListLoading;
  final dynamic model;
  final List<T?>? items;
  final Widget Function(T item, int index) itemWidget;
  final EdgeInsetsGeometry padding;
  final String emptyMessage;
  final String? errorMessage;
  final ScrollPhysics physics;
  final bool isSlivers;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    if (isSlivers) {
      return isListLoading
          ? const SliverFillRemaining(child: LoadingWidget())
          // SliverPadding(
          //         padding: padding,
          //         sliver: SliverList.separated(
          //           separatorBuilder: (context, index) =>
          //               separator ??
          //               const SizedBox(height: AppPadding.largePadding),
          //           itemCount: items!.length,
          //           itemBuilder: (context, index) {
          //             return itemWidget(items?[index] as T, index);
          //           },
          //         ),
          //       )
          : model == null
          ? SliverFillRemaining(child: ErrorBody(errorMessage: errorMessage))
          : items == null || items!.isEmpty
          ? SliverFillRemaining(child: EmptyBody(text: emptyMessage))
          : SliverPadding(
              padding: padding,
              sliver: SliverList.separated(
                separatorBuilder: (context, index) =>
                    separator ??
                    const SizedBox(height: AppPadding.largePadding),
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  return itemWidget(items?[index] as T, index);
                },
              ),
            );
    } else {
      return isListLoading
          ? const LoadingWidget()
          : model == null
          ? ErrorBody(errorMessage: errorMessage)
          : items == null || items?.isEmpty == true
          ? EmptyBody(text: emptyMessage)
          : ListView.separated(
              physics: physics,
              padding: padding,
              reverse: reverse,
              separatorBuilder: (context, index) =>
                  separator ?? const SizedBox(height: AppPadding.largePadding),
              itemCount: items?.length ?? 0,
              itemBuilder: (context, index) {
                return itemWidget(items?[index] as T, index);
              },
            );
    }
  }
}
