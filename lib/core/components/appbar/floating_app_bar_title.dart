import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class FloatingAppBarTitle extends StatelessWidget {
  const FloatingAppBarTitle({
    super.key,
    this.title = '',
    this.color = AppColors.cPrimary,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: AppStyles.title800.copyWith(
        fontSize: AppFontSize.f18,
        color: color,
      ),
    ).tr().addPadding(top: 32, bottom: 30);
  }
}
