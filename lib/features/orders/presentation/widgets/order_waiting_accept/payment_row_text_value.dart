import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';

class PaymentRowTextValue extends StatelessWidget {
  const PaymentRowTextValue({super.key, this.text = '', this.value = ''});

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: AppStyles.title400.copyWith(
              color: AppColors.grey67Color.withValues(alpha: 0.5),
            ),
          ).tr(),
        ),
        Text(
          value,
          style: AppStyles.title400.copyWith(color: AppColors.grey67Color),
        ),
      ],
    );
  }
}
