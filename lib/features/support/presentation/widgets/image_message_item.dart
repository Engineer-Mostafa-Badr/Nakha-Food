import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/support/presentation/widgets/person_chat_avatar.dart';

class ImageMessageItem extends StatelessWidget {
  const ImageMessageItem({
    super.key,
    required this.fromMe,
    required this.imageUrl,
  });

  final bool fromMe;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: fromMe
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsetsDirectional.only(
              end: fromMe ? .4.sw : 10,
              start: fromMe ? 10 : .3.sw,
            ),
            child: CacheImageReuse(
              imageUrl: imageUrl,
              loadingHeight: 100,
              loadingWidth: 100,
              viewImage: true,
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
                child: Image(
                  image: imageProvider,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        if (!fromMe) ...[
          AppPadding.padding4.sizedWidth,
          PersonChatAvatar(imageUrl: AssetImagesPath.networkImage()),
        ],
      ],
    );
  }
}
