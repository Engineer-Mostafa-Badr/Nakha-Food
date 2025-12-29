import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    super.key,
    this.hintText = 'search',
    this.onChanged,
    required this.controller,
  });

  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
      borderSide: const BorderSide(color: Color(0xffD9D9D9)),
    );
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText.tr(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding,
        ),
        filled: false,
        suffixIcon: const AssetSvgImage(
          AssetImagesPath.searchSVG,
        ).addPadding(all: AppPadding.padding12),
        hintStyle: AppStyles.subtitle500.copyWith(fontSize: AppFontSize.f14),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        disabledBorder: border,
      ),
      onChanged: (value) {
        EasyDebounce.debounce('search', const Duration(milliseconds: 500), () {
          onChanged?.call(value);
        });
      },
    );
  }
}
