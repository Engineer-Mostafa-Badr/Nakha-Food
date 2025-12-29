import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class CheckBoxListTileReuse extends StatefulWidget {
  const CheckBoxListTileReuse({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  final bool value;
  final String title;
  final Function(bool?) onChanged;

  @override
  State<CheckBoxListTileReuse> createState() => _CheckBoxListTileReuseState();
}

class _CheckBoxListTileReuseState extends State<CheckBoxListTileReuse> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  void _onChanged(bool? value) {
    setState(() {
      isChecked = value!;
      widget.onChanged.call(isChecked);
    });
  }

  @override
  void didUpdateWidget(covariant CheckBoxListTileReuse oldWidget) {
    super.didUpdateWidget(oldWidget);
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: const BorderSide(color: AppColors.cPrimary),
          onChanged: _onChanged,
        ),
        AppPadding.smallPadding.sizedWidth,
        Text(widget.title, style: AppStyles.title400).tr(),
      ],
    ).addAction(
      onTap: () {
        _onChanged(!isChecked);
      },
      borderRadius: 10,
    );
  }
}
