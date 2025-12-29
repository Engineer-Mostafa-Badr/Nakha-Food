import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/extensions/time_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/chat/presentation/widgets/chat_messages/audio_player_reuse.dart';
import 'package:nakha/features/chat/presentation/widgets/chat_messages/group_of_images_item.dart';

class TextMessageItem extends StatelessWidget {
  const TextMessageItem({
    super.key,
    required this.fromMe,
    required this.messageText,
    required this.images,
    required this.time,
    required this.senderName,
    this.soundPath,
    this.isRead = false,
  });

  final bool fromMe;
  final String? messageText;
  final List<String>? images;
  final String? time;
  final String? soundPath;
  final String senderName;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.smallPadding,
          horizontal: AppPadding.padding10,
        ),
        margin: EdgeInsetsDirectional.only(
          end: fromMe ? .1.sw : AppPadding.padding14,
          start: fromMe ? AppPadding.padding14 : .1.sw,
        ),
        constraints: BoxConstraints(minWidth: 170.w),
        decoration: BoxDecoration(
          color: fromMe ? AppColors.cPrimary : Colors.grey[200],
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(AppBorderRadius.mediumRadius),
            bottomEnd: Radius.circular(AppBorderRadius.mediumRadius),
            topEnd: fromMe
                ? Radius.circular(AppBorderRadius.mediumRadius)
                : Radius.zero,
            topStart: fromMe
                ? Radius.zero
                : Radius.circular(AppBorderRadius.mediumRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: fromMe
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            if (!fromMe) ...[
              Text(
                senderName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fromMe ? Colors.white : Colors.black,
                ),
              ),
              AppPadding.padding8.sizedHeight,
            ],
            if (messageText?.isNotEmpty == true)
              Text(
                messageText ?? '$notSpecified $notSpecified',
                style: TextStyle(color: fromMe ? Colors.white : Colors.black),
              ),
            if (images?.isNotEmpty ?? false) ...[
              AppPadding.padding12.sizedHeight,
              GroupOfImagesItem(messageTextList: images ?? []),
            ],
            if (soundPath != null) ...[
              AppPadding.padding12.sizedHeight,
              AudioPlayerReuse(soundPath: soundPath!),
            ],
            AppPadding.padding12.sizedHeight,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time?.convertToSinceTime ?? '',
                  textAlign: fromMe ? TextAlign.start : TextAlign.end,
                  style: TextStyle(
                    color: fromMe ? Colors.white : null,
                    fontSize: AppFontSize.f10,
                  ),
                ),
                AppPadding.smallPadding.sizedWidth,
                if (fromMe) ...[
                  Icon(
                    !isRead ? Icons.done : Icons.done_all,
                    color: !isRead ? Colors.white : AppColors.cSuccess,
                    size: 18.sp,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
