import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AcceptPolicyRow extends StatefulWidget {
  const AcceptPolicyRow({
    super.key,
    this.onChanged,
    this.text1 = 'i_agree_to_the',
    this.text2 = 'service_terms',
  });

  final Function(bool)? onChanged;
  final String text1;
  final String text2;

  @override
  State<AcceptPolicyRow> createState() => _AcceptPolicyRowState();
}

class _AcceptPolicyRowState extends State<AcceptPolicyRow>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: const BorderSide(color: AppColors.cPrimary),
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              widget.onChanged?.call(isChecked);
            });
          },
        ),
        Text.rich(
          TextSpan(
            text: widget.text1.tr(),
            style: AppStyles.title500.copyWith(fontSize: AppFontSize.f13),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: widget.text2.tr(),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    MostUsedFunctions.urlLauncherFun(
                      EndPoints.servicePolicy,
                      launchMode: LaunchMode.inAppBrowserView,
                    );
                  },
                style: AppStyles.title500.copyWith(
                  fontSize: AppFontSize.f13,
                  color: AppColors.cPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
