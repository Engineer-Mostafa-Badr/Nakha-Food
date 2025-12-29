import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class AppStyles {
  // title =====>>>
  static TextStyle title900 = TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.w900,
  );
  static TextStyle title800 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title300 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title200 = TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: AppFontSize.f14,
  );
  static TextStyle title100 = TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: AppFontSize.f14,
  );

  // subTitle ====================>>>
  static TextStyle subtitle100 = TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: AppFontSize.f12,
    color: AppColors.cTextSubtitleLight,
  );
  static TextStyle subtitle200 = TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: AppFontSize.f12,
    color: AppColors.cTextSubtitleLight,
  );
  static TextStyle subtitle300 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: AppFontSize.f12,
    color: AppColors.cTextSubtitleLight,
  );
  static TextStyle subtitle400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.f12,
    color: AppColors.cTextSubtitleLight,
  );
  static TextStyle subtitle500 = TextStyle(
    color: AppColors.cTextSubtitleLight,
    fontWeight: FontWeight.w500,
    fontSize: AppFontSize.f12,
  );
  static TextStyle subtitle600 = TextStyle(
    color: AppColors.cTextSubtitleLight,
    fontWeight: FontWeight.w600,
    fontSize: AppFontSize.f12,
  );
  static TextStyle subtitle700 = TextStyle(
    color: AppColors.cTextSubtitleLight,
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.f12,
  );
  static TextStyle subtitle800 = TextStyle(
    color: AppColors.cTextSubtitleLight,
    fontWeight: FontWeight.w800,
    fontSize: AppFontSize.f12,
  );
  static TextStyle subtitle900 = TextStyle(
    color: AppColors.cTextSubtitleLight,
    fontWeight: FontWeight.w900,
    fontSize: AppFontSize.f12,
  );

  // box shadow =====>>>
  static List<BoxShadow> mostUsedBoxShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      spreadRadius: 2,
      blurRadius: 2,
      offset: const Offset(0, 1), // changes position of shadow
    ),
  ];

  static List<BoxShadow> secondUsedBoxShadow({double opacity = 0.1}) => [
    BoxShadow(
      color: Colors.black.withValues(alpha: opacity),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];
}
