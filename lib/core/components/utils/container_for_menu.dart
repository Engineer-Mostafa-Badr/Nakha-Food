import 'package:flutter/material.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ContainerForMenu extends StatelessWidget {
  const ContainerForMenu({
    super.key,
    required this.child,
    this.constraints = const BoxConstraints(minHeight: 50.0, maxHeight: 50.0),
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppPadding.mediumPadding,
    ),
    this.borderRadius,
  });

  final Widget child;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;

  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppBorderRadius.smallRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
