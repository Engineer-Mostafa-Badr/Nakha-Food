import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class MostUsedContainer extends StatelessWidget {
  const MostUsedContainer({
    super.key,
    required this.child,
    this.horizontalPadding = AppPadding.smallPadding,
    this.verticalPadding = AppPadding.padding12,
    this.radius = 12,
    this.color,
    this.margin = EdgeInsets.zero,
    this.showShadow = true,
    this.withBorder = false,
    this.borderColor,
    this.constraints,
    this.boxShadow,
    this.borderWidth = 1,
  });

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;
  final double radius;
  final double borderWidth;
  final Color? color;
  final bool showShadow;
  final bool withBorder;
  final EdgeInsetsGeometry margin;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      constraints: constraints,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
        boxShadow: showShadow
            ? boxShadow ?? AppStyles.secondUsedBoxShadow()
            : null,
        border: withBorder
            ? Border.all(
                color:
                    borderColor ??
                    const Color(0xFF464646).withValues(alpha: .2),
                width: borderWidth,
              )
            : null,
      ),
      child: child,
    );
  }
}
