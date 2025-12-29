import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/features/injection_container.dart';

class AvatarWithEditIcon extends StatefulWidget {
  const AvatarWithEditIcon({
    super.key,
    required this.imageUrl,
    this.onImageChanged,
    this.containerSize = 75,
    this.imageSize = 56,
    this.padding = 8,
    this.borderColor = Colors.black,
    this.containerColor = Colors.transparent,
  });

  final String? imageUrl;
  final Function(String)? onImageChanged;
  final double containerSize;
  final double imageSize;
  final double padding;
  final Color borderColor;
  final Color containerColor;

  @override
  State<AvatarWithEditIcon> createState() => _AvatarWithEditIconState();
}

class _AvatarWithEditIconState extends State<AvatarWithEditIcon> {
  late String _imagePath;

  void _pickImage() async {
    // CheckAppPermissions.
    // await sl<CheckAppPermissions>().checkPhotosPermission();
    // await sl<CheckAppPermissions>().checkStoragePermission();
    // final pickedImage = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    // );
    // if (pickedImage != null) {
    //   // setState(() {
    //   _imagePath = pickedImage.path;
    //   widget.onImageChanged?.call(_imagePath);
    //   // });
    // }
    await sl<ImageUtils>().pickImagesFromGallery().then((images) {
      if (images.isNotEmpty) {
        _imagePath = images.first.path;
        widget.onImageChanged?.call(_imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CacheImageReuse(
      // width: widget.containerSize.h,
      // height: widget.containerSize.w,
      // alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   color: widget.containerColor,
      //   borderRadius: BorderRadius.circular(100.r),
      //   border: Border.all(width: .8, color: widget.borderColor),
      // ),
      // padding: EdgeInsets.all(widget.padding),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(100.r),
      //   child: CacheImageReuse(
      //     imageUrl: widget.imageUrl ?? '',
      //     loadingWidth: widget.imageSize,
      //     loadingHeight: widget.imageSize,
      //     avatarError: true,
      //     imageBuilder: (context, imageProvider) {
      //       return Image(
      //         image: imageProvider,
      //         width: widget.imageSize.h,
      //         height: widget.imageSize.w,
      //         fit: BoxFit.cover,
      //       );
      //     },
      //   ),
      // ),
      imageUrl: widget.imageUrl ?? '',
      loadingWidth: widget.imageSize,
      loadingHeight: widget.imageSize,
      avatarError: true,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: widget.containerSize.h,
          height: widget.containerSize.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.containerColor,
            shape: BoxShape.circle,
            border: Border.all(width: .8, color: widget.borderColor),
          ),
          padding: EdgeInsets.all(widget.padding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image(
              image: imageProvider,
              width: widget.imageSize.h,
              height: widget.imageSize.w,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ).addAction(onTap: widget.onImageChanged != null ? _pickImage : null);
  }
}
