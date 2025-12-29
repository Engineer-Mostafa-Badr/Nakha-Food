import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class MessageWithSeenIcon extends StatelessWidget {
  const MessageWithSeenIcon({
    super.key,
    required this.text,
    this.showSeen = true,
    this.isSeen = false,
  });

  final String text;
  final bool showSeen;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showSeen) ...[
          Icon(
            !isSeen ? Icons.done : Icons.done_all,
            color: !isSeen ? AppColors.grey67Color : AppColors.cSuccess,
            size: 18.sp,
          ),
          AppPadding.padding4.sizedWidth,
        ],
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.subtitle400.copyWith(fontSize: AppFontSize.f12),
          ),
        ),
      ],
    );
  }
}
