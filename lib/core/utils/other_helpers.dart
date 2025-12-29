import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class OtherHelper {
  /// show success message =======>>>>
  static void showTopSuccessToast(String message) {
    // showTopSnackBar(
    //   Overlay.of(context),
    //   CustomSnackBar.success(
    //     message: message.tr(),
    //   ),
    //   animationDuration: const Duration(milliseconds: 500),
    // );
    Fluttertoast.showToast(
      msg: message.tr(),
      backgroundColor: AppColors.toastColor,
      textColor: Colors.white,
      fontSize: AppFontSize.f12,
    );
  }

  /// show Fail message =======>>>>
  static void showTopFailToast(String? message) {
    // showTopSnackBar(
    //   Overlay.of(context),
    //   CustomSnackBar.error(
    //     message: (message ?? '').tr(),
    //   ),
    //   animationDuration: const Duration(milliseconds: 500),
    // );
    Fluttertoast.showToast(
      msg: (message ?? '').tr(),
      backgroundColor: AppColors.toastColor,
      textColor: Colors.white,
      fontSize: AppFontSize.f12,
    );
  }

  /// show Info message =======>>>>
  static void showTopInfoToast(String message) {
    // showTopSnackBar(
    //   Overlay.of(context),
    //   CustomSnackBar.info(
    //     message: message.tr(),
    //     backgroundColor: AppColors.cSecondary,
    //   ),
    //   animationDuration: const Duration(milliseconds: 500),
    // );
    Fluttertoast.showToast(
      msg: message.tr(),
      backgroundColor: AppColors.toastColor,
      textColor: Colors.white,
      fontSize: AppFontSize.f12,
    );
  }

  /// show AlertDialog with one button =======>>>>
  static void showAlertDialogWithTwoMiddleButtons({
    required BuildContext context,
    required Widget content,
    required Function()? onPressedOk,
    final VoidCallback? onPressedNo,
    String? title,
    String okText = 'yes',
    String noText = 'no',
    Color okColor = AppColors.cSuccess,
    Color noColor = AppColors.cError,
    bool isDismissible = true,
    bool backAfterOk = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => AlertDialog(
        scrollable: true,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.mostUsedRadius),
          ),
        ),
        title: title == null
            ? null
            : Column(
                children: [
                  Text(
                    title,
                    style: AppStyles.title600,
                    textAlign: TextAlign.center,
                  ).tr(),
                  const Divider(height: 26),
                ],
              ),
        content: content,
        actions: [
          if (onPressedNo != null || onPressedOk != null)
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  if (onPressedOk != null)
                    Expanded(
                      child: ReusedRoundedButton(
                        text: okText,
                        color: okColor,
                        fontSize: AppFontSize.f12,
                        onPressed: () {
                          onPressedOk();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  if (onPressedNo != null) ...[
                    const SizedBox(width: AppPadding.smallPadding),
                    Expanded(
                      child: ReusedRoundedButton(
                        text: noText,
                        color: noColor,
                        fontSize: AppFontSize.f12,
                        onPressed: () {
                          onPressedNo();
                          if (backAfterOk) Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
