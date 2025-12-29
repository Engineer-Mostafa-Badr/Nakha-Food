import 'package:flutter/material.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/res/app_images.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      },
      icon: const AssetSvgImage(AssetImagesPath.backButtonSVG),
    );
  }
}
