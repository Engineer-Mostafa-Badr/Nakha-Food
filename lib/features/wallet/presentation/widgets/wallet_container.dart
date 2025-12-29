import 'package:flutter/material.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class WalletContainer extends StatelessWidget {
  const WalletContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.padding24,
        horizontal: AppPadding.mediumPadding,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF7F5ED),
        borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
      ),
      child: child,
    );
  }
}
