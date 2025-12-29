import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class WaitingAcceptanceCountDown extends StatefulWidget {
  final String endTimeString;

  const WaitingAcceptanceCountDown({
    super.key,
    this.endTimeString = '2024-10-31T12:00:00Z',
  });

  @override
  State<WaitingAcceptanceCountDown> createState() =>
      _WaitingAcceptanceCountDownState();
}

class _WaitingAcceptanceCountDownState
    extends State<WaitingAcceptanceCountDown> {
  Timer? _timer;
  Duration _remaining = Duration.zero;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.parse(widget.endTimeString).toLocal();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (_endTime != null) {
        final diff = _endTime!.difference(now);
        if (diff.isNegative) {
          setState(() => _remaining = Duration.zero);
          timer.cancel();
        } else {
          setState(() => _remaining = diff);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remaining.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = _remaining.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return Center(
      child: Text(
        '$minutes'
        'm : '
        '$seconds'
        's',
        style: AppStyles.title900.copyWith(
          fontSize: AppFontSize.f32,
          color: AppColors.cPrimary,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
