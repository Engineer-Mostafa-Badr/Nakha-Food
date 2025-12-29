import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class GroupOfImagesItem extends StatelessWidget {
  const GroupOfImagesItem({
    super.key,
    required this.messageTextList,
    this.height = 40,
    this.width = 40,
    this.maxItems = 4,
  });

  final List<String> messageTextList;
  final double height;
  final double width;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    // return Wrap(
    //   spacing: AppPadding.padding4,
    //   runSpacing: AppPadding.padding4,
    //   children: messageTextList
    //       .map(
    //         (e) => CacheImageReuse(
    //           imageUrl: e,
    //           loadingHeight: 40,
    //           loadingWidth: 40,
    //           viewImage: true,
    //           imageBuilder: (context, imageProvider) => ClipRRect(
    //             borderRadius: BorderRadius.circular(
    //               AppBorderRadius.radius10,
    //             ),
    //             child: Image(
    //               image: imageProvider,
    //               height: 40,
    //               width: 40,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       )
    //       .toList(),
    // );
    // if the items is more than 8, show the first 8 items and on last item show stack + more items count
    return Wrap(
      spacing: AppPadding.padding4,
      runSpacing: AppPadding.padding4,
      children: List.generate(
        messageTextList.length > maxItems ? maxItems : messageTextList.length,
        (index) => CacheImageReuse(
          imageUrl: messageTextList[index],
          groupOfImages: messageTextList,
          firstImageIndex: index,
          loadingHeight: height.h,
          loadingWidth: width.w,
          viewImage: true,
          imageBuilder: (context, imageProvider) => Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
                child: Image(
                  image: imageProvider,
                  height: height.h,
                  width: width.w,
                  fit: BoxFit.cover,
                ),
              ),
              if (index == maxItems - 1 &&
                  messageTextList.length > maxItems) ...[
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    height: height.h,
                    width: width.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .5),
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius10,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '+${messageTextList.length - maxItems}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
