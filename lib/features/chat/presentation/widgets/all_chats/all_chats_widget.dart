import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/time_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:nakha/features/chat/presentation/pages/chat_messages_page.dart';
import 'package:nakha/features/chat/presentation/widgets/all_chats/message_with_seen_icon.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';

class AllChatsWidget extends StatelessWidget {
  const AllChatsWidget({super.key, this.chatModel});

  final ChatsModel? chatModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CacheImageReuse(
          imageUrl: chatModel?.sender.profileImage,
          loadingHeight: 48,
          loadingWidth: 48,
          avatarError: true,
          imageBuilder: (context, image) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
              child: Image(image: image, width: 48.w, height: 48.h),
            );
          },
        ),
        AppPadding.mediumPadding.sizedWidth,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      chatModel?.sender.name ?? notSpecified,
                      style: AppStyles.title600,
                    ),
                  ),
                  AppPadding.smallPadding.sizedWidth,
                  Text(
                    chatModel?.lastMsgCreatedAt.convertToSinceTime ??
                        notSpecified,
                    style: AppStyles.subtitle400.copyWith(
                      fontSize: AppFontSize.f10,
                    ),
                  ),
                ],
              ),
              // AppPadding.padding2.sizedHeight,
              // Text(
              //   chatModel?.reservation.productName ?? notSpecified,
              //   style: AppStyles.subtitle500,
              // ),
              AppPadding.padding4.sizedHeight,
              Row(
                children: [
                  Expanded(
                    child:
                        (chatModel?.lastMsg.isEmpty ?? false) &&
                            (chatModel?.attachments.isEmpty ?? false)
                        ? const SizedBox.shrink()
                        : MessageWithSeenIcon(
                            text:
                                (chatModel?.lastMsg.isEmpty ?? false) &&
                                    (chatModel?.attachments.isNotEmpty ?? false)
                                ? '(${chatModel?.attachments.length} ${'file'.tr()})'
                                : chatModel?.lastMsg ?? '$notSpecified ' * 3,
                            isSeen: chatModel?.isLastMsgSeen == true,
                            showSeen: AppConst.userId == chatModel?.sender.id,
                          ),
                  ),
                  if (chatModel?.unreadMessages != null &&
                      chatModel!.unreadMessages > 0) ...[
                    AppPadding.smallPadding.sizedWidth,
                    CircleAvatar(
                      minRadius: 10.r,
                      backgroundColor: AppColors.cPrimary,
                      child: Text(
                        chatModel!.unreadMessages.toString(),
                        style: AppStyles.subtitle600.copyWith(
                          fontSize: AppFontSize.f10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    ).addAction(
      onTap: () {
        // Navigate to chat messages page
        if (chatModel?.id != null) {
          HomeBloc.get(
            context,
          ).add(const AddMinusUnreadConversationsEvent(false));
          ChatsBloc.get(
            context,
          ).add(MakeChatAsSeenEvent(chatId: chatModel!.sender.id));
          context
              .navigateToPage(
                ChatMessagesPage(receiverId: chatModel!.sender.id),
              )
              .then((onValue) {
                if (onValue == true) {
                  // Refresh chats if returned true
                  ChatsBloc.get(context).add(const GetChatsEvent());
                }
              });
        }
      },
    );
  }
}
