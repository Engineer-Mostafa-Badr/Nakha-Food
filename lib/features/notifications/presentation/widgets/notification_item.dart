import 'package:flutter/material.dart';
import 'package:nakha/config/navigator_key/navigator_key.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/most_used_container.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/delay_login.dart';
import 'package:nakha/features/chat/presentation/pages/chat_messages_page.dart';
import 'package:nakha/features/notifications/data/models/notifications_model.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key, required this.notificationsEntities});

  final NotificationsModel? notificationsEntities;

  @override
  Widget build(BuildContext context) {
    return MostUsedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              AssetSvgImage(
                AssetImagesPath.notificationPageSVG,
                color: notificationsEntities == null ? Colors.grey[300] : null,
              ),
              AppPadding.largePadding.sizedWidth,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationsEntities?.title ?? notSpecified,
                      style: AppStyles.title600,
                    ),
                    AppPadding.padding4.sizedHeight,
                    Text(
                      notificationsEntities?.description ??
                          '$notSpecified $notSpecified',
                      style: AppStyles.subtitle400,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppPadding.padding8.sizedHeight,
          Text(
            notificationsEntities?.humanDiff ?? notSpecified,
            textAlign: TextAlign.end,
            style: AppStyles.subtitle400,
          ),
        ],
      ),
    ).addAction(
      borderRadius: 12,
      onTap: () {
        if (notificationsEntities == null) return;
        CheckLoginDelay.checkIfNeedLogin(
          onExecute: () {
            final String type = notificationsEntities!.type;
            final int? itemId = int.tryParse(notificationsEntities!.itemId);
            if (type == NotificationsEnum.message.name && itemId != null) {
              NavigatorKey.context.navigateToPage(
                ChatMessagesPage(receiverId: itemId),
              );
              return;
            }
          },
        );
      },
    );
  }
}
