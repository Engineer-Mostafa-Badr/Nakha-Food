import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/images/photo_image_viewer.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';

class CacheImageReuse extends StatelessWidget {
  const CacheImageReuse({
    super.key,
    required this.imageUrl,
    this.groupOfImages = const [],
    this.firstImageIndex,
    required this.imageBuilder,
    this.loadingHeight,
    this.loadingWidth,
    this.viewImage = false,
    this.showLoading = true,
    this.errorWidget,
    this.avatarError = false,
  });

  final String? imageUrl;

  /// The group of images that the image belongs to it to show it in the image viewer
  final List<String> groupOfImages;

  /// The index of the first image in the group of images
  final int? firstImageIndex;
  final Widget Function(BuildContext context, ImageProvider imageProvider)
  imageBuilder;
  final double? loadingHeight;
  final double? loadingWidth;
  final bool viewImage;
  final bool showLoading;
  final Widget? errorWidget;
  final bool avatarError;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: imageBuilder,
      placeholder: (context, url) => showLoading
          ? SizedBox(
              height: loadingHeight?.h,
              width: loadingWidth?.w,
              child: const LoadingWidget(),
            )
          : const SizedBox.shrink(),
      errorWidget: (context, url, error) => SizedBox(
        height: loadingHeight?.h,
        width: loadingWidth?.w,
        child: errorWidget == null
            ? avatarError
                  ? AssetSvgImage(
                      AssetImagesPath.avatarSVG,
                      height: loadingHeight?.h,
                      width: loadingWidth?.w,
                    )
                  : const Icon(Icons.error)
            : errorWidget!,
      ),
    ).addAction(
      onTap: viewImage
          ? () {
              context.navigateToPage(
                groupOfImages.isNotEmpty
                    ? PhotoImageViewerForGroup(
                        groupOfImages: groupOfImages,
                        firstImageIndex: firstImageIndex,
                      )
                    : PhotoImageViewer(assetName: imageUrl ?? ''),
              );
            }
          : null,
    );
  }
}
