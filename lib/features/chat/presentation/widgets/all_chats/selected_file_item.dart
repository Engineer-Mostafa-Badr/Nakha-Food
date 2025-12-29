import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SelectedFileChatItem extends StatelessWidget {
  const SelectedFileChatItem({super.key, required this.path, this.onTap});

  final String path;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
            ),
            child: const Icon(Icons.close_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
