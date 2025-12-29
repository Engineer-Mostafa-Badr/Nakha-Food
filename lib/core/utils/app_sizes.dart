import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';

class PaddingEdgeInset {
  // main
  static const mainPadding = EdgeInsetsDirectional.only(
    start: AppPadding.largePadding,
    end: AppPadding.largePadding,
    top: AppPadding.largePadding,
    bottom: AppPadding.largePadding * 6,
  );
}

class AppPadding {
  static const double padding2 = 2.0;
  static const double padding4 = 4.0;
  static const double padding6 = 6.0;
  static const double padding8 = 8.0;
  static const double padding10 = 10.0;
  static const double padding12 = 12.0;
  static const double padding14 = 14.0;
  static const double padding16 = 16.0;
  static const double padding18 = 18.0;
  static const double padding20 = 20.0;
  static const double padding24 = 24.0;

  static const double padding26 = 28.0;
  static const double padding30 = 30.0;
  static const double padding32 = 32.0;
  static const double padding36 = 36.0;
  static const double padding40 = 40.0;
  static const double padding48 = 48.0;
  static const double padding56 = 56.0;
  static const double padding64 = 64.0;
  static const double padding72 = 72.0;

  // large padding & large is default padding
  static const double largePadding = padding20;

  // medium padding
  static const double mediumPadding = padding16;

  // small padding
  static const double smallPadding = padding8;

  // BOTTOM SHEET PADDING
  static double bottomSheetPadding(BuildContext context) {
    // keyboard inset
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    // navigation system padding
    final double systemInset = MediaQuery.of(context).viewPadding.bottom;

    return keyboardInset + systemInset + AppPadding.padding16;
  }
}

class AppFontSize {
  static double f2 = 2.0.sp;
  static double f4 = 4.0.sp;
  static double f6 = 6.0.sp;
  static double f8 = 8.0.sp;
  static double f9 = 9.0.sp;
  static double f10 = 10.0.sp;
  static double f11 = 11.0.sp;
  static double f12 = 12.0.sp;
  static double f13 = 13.0.sp;
  static double f14 = 14.0.sp;
  static double f16 = 16.0.sp;
  static double f18 = 18.0.sp;
  static double f20 = 20.0.sp;
  static double f22 = 22.0.sp;
  static double f24 = 24.0.sp;
  static double f26 = 26.0.sp;
  static double f28 = 28.0.sp;
  static double f30 = 30.0.sp;
  static double f32 = 32.0.sp;
  static double f34 = 34.0.sp;

  // title font
  static double titleFont = f16;

  // subtitle font
  static double subtitleFont = f12;
}

class AppBorderRadius {
  static double radius2 = 2.0.r;
  static double radius4 = 4.0.r;
  static double radius6 = 6.0.r;
  static double radius8 = 8.0.r;
  static double radius10 = 10.0.r;
  static double radius12 = 12.0.r;
  static double radius14 = 14.0.r;
  static double radius16 = 16.0.r;
  static double radius18 = 18.0.r;
  static double radius20 = 20.0.r;
  static double radius22 = 22.0.r;
  static double radius24 = 24.0.r;
  static double radius26 = 26.0.r;
  static double radius28 = 28.0.r;
  static double radius30 = 30.0.r;
  static double radius32 = 32.0.r;
  static double radius34 = 34.0.r;
  static double radius36 = 36.0.r;

  // large radius
  static double largeRadius = radius20;

  // medium radius
  static double mediumRadius = radius12;

  // small radius
  static double smallRadius = radius8;

  // text field radius
  static double mostUsedRadius = radius14;
}
