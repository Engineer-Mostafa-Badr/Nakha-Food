import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class ReplyCloseButtons extends StatelessWidget {
  const ReplyCloseButtons({
    super.key,
    this.showReply = false,
    required this.onShowReply,
    required this.closeTicket,
    this.closeTicketLoading = false,
  });

  final bool showReply;
  final bool closeTicketLoading;
  final Function(bool) onShowReply;
  final Function() closeTicket;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ReusedRoundedButton(
            text: 'add_reply',
            color: AppColors.cAlert,
            onPressed: () {
              onShowReply(!showReply);
            },
          ),
        ),
        AppPadding.padding14.sizedWidth,
        Expanded(
          child: ReusedRoundedButton(
            text: 'close_ticket',
            isLoading: closeTicketLoading,
            color: AppColors.cError,
            onPressed: closeTicket,
          ),
        ),
      ],
    );
  }
}
