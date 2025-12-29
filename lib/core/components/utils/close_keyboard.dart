import 'package:flutter/material.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class CloseKeyBoardWidget extends StatelessWidget {
  const CloseKeyBoardWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MostUsedFunctions.closeKeyBoard(context),
      child: child,
    );
  }
}
