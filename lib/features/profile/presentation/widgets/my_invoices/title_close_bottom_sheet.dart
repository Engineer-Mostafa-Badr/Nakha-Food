import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class TitleCloseBottomSheet extends StatelessWidget {
  const TitleCloseBottomSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyles.title700.copyWith(
                  fontSize: AppFontSize.f16,
                  color: const Color(0xff5B5B5B),
                ),
              ).tr(),
            ),
          ],
        ),
        Icon(
          Icons.close,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ).addAction(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class DragBottomSheetContainer extends StatelessWidget {
  const DragBottomSheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.greyD2Color,
        borderRadius: BorderRadius.circular(2),
      ),
    ).addPadding(top: AppPadding.largePadding);
  }
}
