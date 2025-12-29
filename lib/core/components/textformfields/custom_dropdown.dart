import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> items;
  final String? value;
  final String? title;
  final String? hintText;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? titleColor;
  final bool isExpanded;

  // final bool isRequired;
  final String? prefixIcon;
  final double titleFontSize;
  final String? Function(String?)? validator;

  const CustomDropdownMenu({
    super.key,
    required this.items,
    this.value,
    this.title,
    this.hintText,
    this.titleColor,
    this.onChanged,
    this.controller,
    this.fillColor,
    this.isExpanded = false,
    // this.isRequired = true,
    this.prefixIcon,
    this.titleFontSize = 14,
    this.validator,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? _value;

  @override
  void initState() {
    _value = widget.value;
    if (widget.controller != null) {
      widget.controller!.text = widget.value ?? '';
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
      if (widget.controller != null) {
        widget.controller!.text = widget.value ?? '';
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        DropdownButtonHideUnderline(
          child: Row(
            children: [
              if (widget.prefixIcon != null)
                Container(
                  margin: const EdgeInsetsDirectional.only(
                    top: AppPadding.smallPadding,
                    bottom: AppPadding.smallPadding,
                    start: AppPadding.smallPadding,
                    end: AppPadding.smallPadding,
                  ),
                  padding: const EdgeInsetsDirectional.only(
                    end: AppPadding.padding6,
                  ),
                  child: AssetSvgImage(
                    widget.prefixIcon!,
                    width: 20,
                    height: 20,
                  ),
                ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _value,
                  validator: widget.validator,
                  hint: widget.hintText != null
                      ? Text(
                          widget.hintText!,
                          style: Theme.of(
                            context,
                          ).inputDecorationTheme.hintStyle,
                        ).tr()
                      : null,
                  items: widget.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.tr().toTitleCase,
                        style: TextStyle(fontSize: AppFontSize.f14),
                      ),
                    );
                  }).toList(),
                  onChanged: widget.onChanged == null
                      ? null
                      : (value) {
                          setState(() {
                            _value = value;
                            widget.controller?.text = value ?? '';
                            widget.onChanged?.call(value);
                          });
                        },
                  decoration: InputDecoration(
                    filled: widget.fillColor != null,
                    fillColor: widget.fillColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius10,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.cFillBorderLight,
                        width: .5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius10,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.cFillBorderLight,
                        width: .5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius10,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.cFillBorderLight,
                        width: .5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius10,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.cError,
                        width: .5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius10,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.cError,
                        width: .5,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.cTextSubtitleLight,
                      fontSize: AppFontSize.f14,
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cTextSubtitleLight,
                      fontSize: AppFontSize.f14,
                    ),
                    errorStyle: TextStyle(
                      color: AppColors.cError,
                      fontSize: AppFontSize.f10,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.mediumPadding,
                      vertical: AppPadding.padding12,
                    ),
                    suffixIconColor: AppColors.cTextSubtitleLight,
                    prefixIconColor: AppColors.cTextSubtitleLight,
                  ),
                  icon: const Icon(
                    Icons.expand_more_outlined,
                    color: Colors.black,
                    size: 18,
                  ),
                  isExpanded: widget.isExpanded,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
