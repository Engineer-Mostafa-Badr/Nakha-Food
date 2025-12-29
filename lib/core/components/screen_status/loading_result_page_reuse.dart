import 'package:flutter/material.dart';
import 'package:nakha/core/components/screen_status/error_widget.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';

class LoadingResultPageReuse extends StatelessWidget {
  const LoadingResultPageReuse({
    super.key,
    this.isListLoading = true,
    this.model,
    this.loadingWidget,
    required this.child,
  });

  final bool isListLoading;
  final dynamic model;
  final Widget? loadingWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isListLoading
        ? loadingWidget ?? const LoadingWidget()
        : model == null
        ? const ErrorBody()
        : child;
  }
}
