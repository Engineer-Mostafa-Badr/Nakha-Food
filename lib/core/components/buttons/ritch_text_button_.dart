import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class RichTextButton extends StatelessWidget {
  final String? text1;
  final String? text2;
  final Color? color1;
  final Color color2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  const RichTextButton({
    super.key,
    this.text1,
    this.color1,
    this.color2 = AppColors.cError,
    this.text2,
    this.onPressed1,
    this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: text1!.tr(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: color1,
          fontSize: AppFontSize.f14,
        ),
        recognizer: TapGestureRecognizer()..onTap = onPressed1,
        children: [
          const TextSpan(text: ' '),
          TextSpan(
            text: text2!.tr(),
            style: TextStyle(
              color: color2,
              fontWeight: FontWeight.w500,
              fontSize: AppFontSize.f14,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed2,
          ),
        ],
      ),
    );
  }
}
