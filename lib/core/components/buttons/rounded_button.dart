import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ReusedRoundedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color textColor;
  final Widget? rowWidget;
  final double fontSize;
  final bool isLoading;
  final double height;
  final double radius;
  final double? width;
  final bool showShadow;
  final double widthWidget;
  final BorderRadiusGeometry? borderRadius;

  const ReusedRoundedButton({
    required this.text,
    required this.onPressed,
    this.color = AppColors.cPrimary,
    this.textColor = Colors.white,
    this.rowWidget,
    this.fontSize = 14,
    this.height = 48,
    this.width,
    this.radius = 14,
    this.widthWidget = AppPadding.smallPadding,
    this.isLoading = false,
    this.showShadow = false,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(radius.r),
        boxShadow: showShadow ? AppStyles.mostUsedBoxShadow : [],
      ),
      child: SizedBox(
        width: width != null ? width!.w : double.infinity,
        height: height.h,
        child: isLoading
            ? const LoadingWidget()
            : ElevatedButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(
                    Colors.grey.withValues(alpha: .5),
                  ),
                  alignment: Alignment.center,
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(color),
                  surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
                  foregroundColor: WidgetStateProperty.all(Colors.transparent),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius:
                          borderRadius ?? BorderRadius.circular(radius.r),
                    ),
                  ),
                ),
                onPressed: isLoading ? () {} : onPressed,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (rowWidget != null) ...[
                        rowWidget!,
                        widthWidget.sizedWidth,
                      ],
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: fontSize.sp,
                        ),
                      ).tr(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
