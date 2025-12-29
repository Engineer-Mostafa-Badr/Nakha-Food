import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class UpgraderReuse extends StatelessWidget {
  const UpgraderReuse({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      shouldPopScope: () => true,
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      // barrierDismissible: true,
      showIgnore: false,
      upgrader: Upgrader(
        // showReleaseNotes: true,
        durationUntilAlertAgain: Duration.zero,
        countryCode: context.locale.countryCode,
        languageCode: context.locale.languageCode,
        // debugLogging: true,
        // debugDisplayAlways: true,
      ),
      child: child,
    );
  }
}
