import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SeeAllRow extends StatelessWidget {
  const SeeAllRow({super.key, required this.title, this.onPressed});

  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyles.title500.copyWith(
              fontSize: AppFontSize.f16,
              color: AppColors.grey54Color,
            ),
          ).tr(),
        ),
        if (onPressed != null)
          Text(
            'see_all',
            style: AppStyles.title400.copyWith(color: AppColors.cError),
          ).tr().addAction(onTap: onPressed),
      ],
    );
  }
}
