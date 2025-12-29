import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/core/components/utils/widgets.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key, this.errorMessage, this.fillRemaining});

  final String? errorMessage;

  final bool? fillRemaining;

  @override
  Widget build(BuildContext context) {
    if (fillRemaining != null) {
      return SliverFillRemaining(
        // hasScrollBody: false,
        child: _BaseErrorBody(errorMessage: errorMessage),
      );
    }

    return _BaseErrorBody(errorMessage: errorMessage);
  }
}

class _BaseErrorBody extends StatelessWidget {
  const _BaseErrorBody({this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MyAppLogo(),
        const SizedBox(height: 20),
        Text(
          (errorMessage ?? 'something_went_wrong').tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ).tr(),
      ],
    );
  }
}
