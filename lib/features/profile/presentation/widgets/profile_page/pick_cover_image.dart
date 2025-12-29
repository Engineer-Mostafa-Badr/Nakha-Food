import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/features/injection_container.dart';

class PickCoverImage extends StatefulWidget {
  const PickCoverImage({
    super.key,
    required this.imageUrl,
    this.onImageChanged,
    this.pickedImage = '',
  });

  final String pickedImage;
  final String imageUrl;
  final Function(String)? onImageChanged;

  @override
  State<PickCoverImage> createState() => _PickCoverImageState();
}

class _PickCoverImageState extends State<PickCoverImage> {
  String? _pickedImage;

  @override
  void initState() {
    super.initState();
    _pickedImage = widget.pickedImage;
  }

  @override
  void didUpdateWidget(covariant PickCoverImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pickedImage != widget.pickedImage) {
      _pickedImage = widget.pickedImage;
    }
  }

  void _pickImage() async {
    await sl<ImageUtils>().pickImagesFromGallery().then((images) {
      if (images.isNotEmpty) {
        setState(() {
          _pickedImage = images.first.path;
          widget.onImageChanged?.call(_pickedImage!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cover_image',
          style: AppStyles.title700.copyWith(fontSize: AppFontSize.f16),
        ).tr(),
        AppPadding.mediumPadding.sizedHeight,
        if (_pickedImage != null && _pickedImage!.isNotEmpty)
          Container(
            height: 172.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorderRadius.smallRadius),
              image: DecorationImage(
                image: FileImage(
                  // we are sure that _pickedImage is not null here
                  // ignore: unnecessary_null_comparison
                  File(_pickedImage!),
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          CacheImageReuse(
            imageUrl: widget.imageUrl,
            errorWidget: Placeholder(
              fallbackHeight: 172.h,
              fallbackWidth: double.infinity,
            ),
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 172.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppBorderRadius.smallRadius,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
      ],
    ).addAction(borderRadius: 8, onTap: _pickImage);
  }
}
