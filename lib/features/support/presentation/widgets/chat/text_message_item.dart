import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/presentation/widgets/group_of_images_item.dart';
import 'package:nakha/features/support/presentation/widgets/row_icon_text.dart';

class TextMessageItem extends StatelessWidget {
  const TextMessageItem({
    super.key,
    required this.fromMe,
    required this.messageText,
    required this.messageTextList,
    required this.time,
    required this.user,
  });

  final bool fromMe;
  final String? messageText;
  final List<String>? messageTextList;
  final String? time;
  final UserCommentModel? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: fromMe
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (fromMe) ...[
          CacheImageReuse(
            imageUrl: user?.image ?? '',
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: AppBorderRadius.radius20,
              backgroundImage: imageProvider,
            ),
          ),
        ],
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.smallPadding,
              horizontal: AppPadding.mediumPadding,
            ),
            margin: EdgeInsetsDirectional.only(
              end: fromMe ? .1.sw : 10,
              start: fromMe ? 10 : .1.sw,
            ),
            decoration: BoxDecoration(
              color: fromMe ? AppColors.cPrimary : Colors.grey[200],
              borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!fromMe) ...[
                  // name
                  Text(
                    user?.name ?? notSpecified,
                    style: AppStyles.title600.copyWith(
                      color: AppColors.cPrimary,
                    ),
                  ),
                  AppPadding.padding6.sizedHeight,
                ],
                Text(
                  messageText ?? '$notSpecified $notSpecified',
                  style: TextStyle(color: fromMe ? Colors.white : Colors.black),
                ),
                if (messageTextList?.isNotEmpty ?? false) ...[
                  AppPadding.padding12.sizedHeight,
                  GroupOfImagesItem(messageTextList: messageTextList ?? []),
                ],
                AppPadding.padding12.sizedHeight,
                RowIconText(
                  text: time ?? notSpecified,
                  iconPath: AssetImagesPath.time2SVG,
                  textColor: fromMe ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
        if (!fromMe) ...[
          CacheImageReuse(
            imageUrl: user?.image ?? '',
            loadingHeight: 40,
            loadingWidth: 40,
            avatarError: true,
            showLoading: user?.image != null,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: AppBorderRadius.radius20,
              backgroundImage: imageProvider,
            ),
          ),
        ],
      ],
    );
  }
}
