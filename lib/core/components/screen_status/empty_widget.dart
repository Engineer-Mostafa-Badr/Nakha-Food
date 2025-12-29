import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/core/components/utils/widgets.dart';

class EmptyBody extends StatelessWidget {
  const EmptyBody({super.key, this.text, this.fillRemaining});

  final String? text;
  final bool? fillRemaining;

  @override
  Widget build(BuildContext context) {
    if (fillRemaining != null) {
      return SliverFillRemaining(
        // hasScrollBody: false,
        child: _BaseEmptyWidget(text: text),
      );
    }

    return _BaseEmptyWidget(text: text);
  }
}

class _BaseEmptyWidget extends StatelessWidget {
  const _BaseEmptyWidget({this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MyAppLogo(),
        const SizedBox(height: 20),
        Text(
          (text ?? 'no_data_found').tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ).tr(),
      ],
    );
  }
}
