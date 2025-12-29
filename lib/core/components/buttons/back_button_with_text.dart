import 'package:flutter/material.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/res/app_images.dart';

class BackButtonWithText extends StatelessWidget {
  const BackButtonWithText({
    super.key,
    this.isWhite = false,
    this.backText = 'back',
    this.showBackButton = true,
    this.color,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  final bool isWhite;
  final String backText;
  final bool showBackButton;
  final Color? color;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Navigator.canPop(context) && showBackButton
        ? IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            },
            icon: const AssetSvgImage(AssetImagesPath.backButtonSVG),
          )
        : const SizedBox.shrink();
  }
}

class BackButtonLeftIcon extends StatelessWidget {
  const BackButtonLeftIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const AssetSvgImage(AssetImagesPath.arrowLeftSVG),
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
