import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ReusedTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String hintText;
  final String? helperText;
  final String? title;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final String? suffixText;
  final String? pickFileText;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final int minLines;
  final int maxLines;
  final bool isPassword;
  final bool withBorder;
  final Widget? suffixWidget;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;

  // final bool isRequired;
  final bool dispose;
  final TextAlign textAlign;
  final Color? fillColor;
  final Color? titleColor;
  final InputBorder? border;
  final double titleFontSize;

  const ReusedTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.validator,
    this.hintText = '',
    this.textColor,
    // this.isRequired = true,
    this.helperText,
    this.contentPadding,
    this.suffixText,
    this.titleColor,
    this.pickFileText,
    this.title,
    this.suffixIcon,
    this.prefixIcon,
    this.withBorder = true,
    this.readOnly = false,
    this.dispose = false,
    this.onTap,
    this.minLines = 1,
    this.maxLines = 1,
    this.isPassword = false,
    this.suffixWidget,
    this.onChanged,
    this.prefix,
    this.inputFormatters,
    this.fillColor,
    this.border,
    this.titleFontSize = 14,
  });

  @override
  State<ReusedTextFormField> createState() => _ReusedTextFormFieldState();
}

class _ReusedTextFormFieldState extends State<ReusedTextFormField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    if (widget.dispose && widget.controller != null) {
      widget.controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final border =
        widget.border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
          borderSide: const BorderSide(color: AppColors.cFillBorderLight),
        );
    final withNoBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: AppStyles.title600.copyWith(
              color: widget.titleColor,
              fontSize: widget.titleFontSize.sp,
            ),
          ).tr(),
          AppPadding.padding12.sizedHeight,
        ],
        TextFormField(
          onTapOutside: (pointer) {
            FocusScope.of(context).unfocus();
          },
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          validator: widget.validator,
          onChanged: (value) {
            EasyDebounce.debounce(
              'search_debounce',
              const Duration(milliseconds: 500),
              () {
                widget.onChanged?.call(value);
              },
            );
          },
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          cursorColor: AppColors.cSecondary,
          inputFormatters:
              widget.inputFormatters ??
              [
                if (widget.keyboardType == TextInputType.number)
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                else if (widget.keyboardType == TextInputType.emailAddress)
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9@._\-+]'),
                  )
                else if (widget.keyboardType == TextInputType.url)
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                else if (widget.keyboardType == TextInputType.name)
                  FilteringTextInputFormatter.deny(
                    RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]'),
                  )
                else if (widget.keyboardType == TextInputType.phone) ...[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],

                /// allow arabic letters only
                // else if (widget.keyboardType == TextInputType.name)
                //   FilteringTextInputFormatter.deny(RegExp(r'[^\u0621-\u064A ]')),
              ],
          style: widget.textColor != null
              ? AppStyles.title600.copyWith(color: widget.textColor)
              : null,
          textAlign: widget.textAlign,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText.tr(),
            filled: widget.fillColor != null,
            // label: Text(
            //   widget.hintText,
            //   style: AppStyles.subtitle500.copyWith(
            //     fontSize: AppFontSize.f14,
            //   ),
            // ).tr(),
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: AppPadding.mediumPadding,
                  vertical: AppPadding.padding12,
                ),
            fillColor: widget.fillColor,
            suffixText: widget.suffixText,
            suffixStyle: AppStyles.title600,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: Theme.of(
              context,
            ).inputDecorationTheme.hintStyle!.copyWith(color: widget.textColor),
            border: widget.withBorder == false ? withNoBorder : border,
            disabledBorder: widget.withBorder == false ? withNoBorder : border,
            enabledBorder: widget.withBorder == false ? withNoBorder : border,
            focusedBorder: widget.withBorder == false ? withNoBorder : border,
            errorBorder: widget.withBorder == false
                ? withNoBorder
                : border.copyWith(
                    borderSide: border.borderSide.copyWith(
                      color: AppColors.cError,
                      width: .5,
                    ),
                  ),
            focusedErrorBorder: widget.withBorder == false
                ? withNoBorder
                : border,
            prefixIcon:
                widget.prefix ??
                (widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(
                          AppPadding.smallPadding,
                        ).h,
                        child: AssetSvgImage(
                          widget.prefixIcon!,
                          width: 22,
                          height: 22,
                        ),
                      )
                    : null),
            suffixIcon: widget.isPassword
                ?
                  // const SizedBox.shrink()
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.cTextSubtitleLight,
                    ),
                  )
                : widget.suffixWidget ??
                      (widget.suffixIcon != null
                          ? Icon(
                              widget.suffixIcon,
                              color: AppColors.cTextSubtitleLight,
                            )
                          : null),
          ),
        ),
        if (widget.helperText != null) ...[
          AppPadding.padding6.sizedHeight,
          Text(
            widget.helperText!,
            style: AppStyles.subtitle600.copyWith(fontSize: AppFontSize.f10),
          ).tr(),
        ],
      ],
    );
  }
}
