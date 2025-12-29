import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get heightWithoutStatusBar => height - MediaQuery.of(this).padding.top;

  double get heightWithoutStatusBarAndBottomBar =>
      heightWithoutStatusBar - MediaQuery.of(this).padding.bottom;

  double get heightWithoutStatusBarAndBottomBarAndAppBar =>
      heightWithoutStatusBarAndBottomBar - kToolbarHeight;

  double get heightWithoutStatusBarAndBottomBarAndAppBarAndTabBar =>
      heightWithoutStatusBarAndBottomBarAndAppBar - kToolbarHeight;
}

extension PaddingList on List<Widget> {
  List<Widget> paddingDirectional({
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) {
    return map(
      (e) => Padding(
        padding: EdgeInsetsDirectional.only(
          top: (top ?? 0).h,
          bottom: (bottom ?? 0).h,
          start: (start ?? 0).w,
          end: (end ?? 0).w,
        ),
        child: e,
      ),
    ).toList();
  }

  // padding symmetric
  List<Widget> paddingSymmetric({double? vertical, double? horizontal}) {
    return map(
      (e) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: (vertical ?? 0).h,
          horizontal: (horizontal ?? 0).w,
        ),
        child: e,
      ),
    ).toList();
  }

  // padding all
  List<Widget> paddingAll(double? padding) {
    return map(
      (e) => Padding(padding: EdgeInsets.all(padding ?? 0), child: e),
    ).toList();
  }
}

extension SetPadding on Widget {
  Widget addPadding({
    final double all = 0.0,
    final double horizontal = 0.0,
    final double vertical = 0.0,
    final double start = 0.0,
    final double bottom = 0.0,
    final double end = 0.0,
    final double left = 0.0,
    final double right = 0.0,
    final double top = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(all),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: left, right: right),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: start,
              bottom: bottom,
              end: end,
              top: top,
            ),
            child: this,
          ),
        ),
      ),
    );
  }
}
