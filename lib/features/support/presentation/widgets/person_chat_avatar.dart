import 'package:flutter/material.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class PersonChatAvatar extends StatelessWidget {
  const PersonChatAvatar({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CacheImageReuse(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: AppBorderRadius.radius20,
        backgroundImage: imageProvider,
      ),
    );
  }
}
