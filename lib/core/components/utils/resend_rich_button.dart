import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/ritch_text_button_.dart';

class ResendRichButton extends StatefulWidget {
  const ResendRichButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ResendRichButton> createState() => _ResendRichButtonState();
}

class _ResendRichButtonState extends State<ResendRichButton> {
  String currentSecond = kDebugMode ? '5' : '60';
  bool isCountDown = false;

  // init timer for resend code
  void initTimer() {
    setState(() {
      isCountDown = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (!isClosed) {
        setState(() {
          currentSecond = '${int.parse(currentSecond) - 1}';
        });
        if (int.parse(currentSecond) > 0) {
          initTimer();
        } else {
          setState(() {
            isCountDown = false;
            currentSecond = kDebugMode ? '5' : '60';
          });
        }
      }
    });
  }

  @override
  void initState() {
    initTimer();
    super.initState();
  }

  bool isClosed = false;

  @override
  void dispose() {
    isClosed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichTextButton(
      text1: 'dont_receive_code',
      color1: AppColors.cPrimary,
      // alignment: AlignmentDirectional.centerStart,
      text2: isCountDown == false ? 'resend' : '$currentSecond ${'sec'.tr()}',
      onPressed2: () {
        if (isCountDown == false) {
          widget.onPressed();
          initTimer();
        }
      },
    );
  }
}
