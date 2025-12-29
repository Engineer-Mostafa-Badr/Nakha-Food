import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/lists/list_view_reuse.dart';
import 'package:nakha/core/components/scaffold/profile_scaffold.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/services/pusher/pusher_service.dart';
import 'package:nakha/core/services/pusher/utils/pusher_constant.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/my_account_image_title.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';
import 'package:nakha/features/support/domain/use_cases/close_ticket_usecase.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';
import 'package:nakha/features/support/presentation/pages/support_chat_consumer.dart';
import 'package:nakha/features/support/presentation/widgets/chat/chat_controller_reuse.dart';
import 'package:nakha/features/support/presentation/widgets/chat/reply_close_buttons.dart';
import 'package:nakha/features/support/presentation/widgets/chat/text_message_item.dart';

class SupportChatPage extends StatefulWidget {
  const SupportChatPage({
    super.key,
    required this.ticketID,
    this.onChatTicketModel,
  });

  final int ticketID;
  final Function(ChatTicketModel?)? onChatTicketModel;

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  // get support message from pusher
  late final PusherServices pusherServices;

  Future<void> _onSupportChatFetchPusherEvent() async {
    pusherServices = PusherServices(
      chatChannelName: PusherConstant.ticketChatChannel(
        widget.ticketID.toString(),
      ),
      onEvent: (event) {
        try {
          MostUsedFunctions.printFullText(
            'onEvent: \n${event.channelName} \ndata: ${json.encode(event.data)} \neventName: ${event.eventName}',
          );
          if (event.eventName == 'pusher:subscription_succeeded' ||
              event.data == null) {
            return;
          }
          if (event.channelName.contains(
            PusherConstant.ticketChatChannel(widget.ticketID.toString()),
          )) {
            setState(() {
              final Map<String, dynamic> jsonData = json.decode(event.data!);
              final Map<String, dynamic> message = jsonData['message'];
              chatTicketModel!.comments.insert(
                0,
                CommentsModel.fromJson(message),
              );
              widget.onChatTicketModel!(chatTicketModel);
            });
          }
        } catch (e) {
          MostUsedFunctions.printFullText('error in onEvent: $e');
        }
      },
    );
  }

  ChatTicketModel? chatTicketModel;

  @override
  void initState() {
    super.initState();
    _onSupportChatFetchPusherEvent();
  }

  @override
  void dispose() {
    pusherServices.disconnectFromPusher();
    super.dispose();
  }

  bool showReply = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<SupportChatBloc>()..add(SupportChatFetchEvent(widget.ticketID)),
      child: SupportChatConsumer(
        buildWhen: (SupportChatState previous, SupportChatState current) =>
            previous.getSupportChatState != current.getSupportChatState ||
            previous.closeTicketState != current.closeTicketState,
        listener: (bloc, state) {
          if (state.getSupportChatState == RequestState.error) {
            state.getSupportChatResponse.msg!.showTopErrorToast;
          } else if (state.getSupportChatState == RequestState.loaded) {
            chatTicketModel = state.getSupportChatResponse.data;
          } else if (state.closeTicketState == RequestState.loaded) {
            if (state.closeTicketResponse.status == true) {
              widget.onChatTicketModel!(
                chatTicketModel?.copyWith(status: 'closed'),
              );
              Navigator.pop(context);
            } else {
              state.closeTicketResponse.msg!.showTopErrorToast;
            }
          } else if (state.closeTicketState == RequestState.error) {
            state.closeTicketResponse.msg!.showTopErrorToast;
          }
        },
        builder: (bloc, state) {
          return ProfileScaffold(
            topWidget: MyAccountImageTitle(
              text: chatTicketModel == null
                  ? ''
                  : '${'ticket_number'.tr()}: ${widget.ticketID}\n${'ticket_title'.tr()}: ${chatTicketModel?.title ?? ''}',
            ),
            body: SliverListViewReuse(
              emptyMessage: 'how_can_we_help_you_today',
              padding: EdgeInsetsDirectional.only(
                start: AppPadding.padding4,
                end: AppPadding.padding4,
                top: AppPadding.padding4,
                bottom: .14.sh,
              ),
              reverse: true,
              isSlivers: false,
              model: chatTicketModel,
              items: chatTicketModel?.comments,
              isListLoading: state.getSupportChatState == RequestState.loading,
              itemWidget: (item, index) => TextMessageItem(
                fromMe: AppConst.userId == item.user.id,
                time: item.humanDiff,
                messageText: item.comment,
                user: item.user,
                messageTextList: List.generate(
                  item.attachments.length,
                  (index) => item.attachments[index].path,
                ),
              ),
            ),
            isBottomNavVisible: false,
            bottomSheet:
                chatTicketModel == null || chatTicketModel!.status == 'closed'
                ? null
                : showReply
                ? ChatControllerReuse(packageId: widget.ticketID.toString())
                : ContainerForBottomNavButtons(
                    isBottomNavigatorSheet: true,
                    child: ReplyCloseButtons(
                      showReply: showReply,
                      onShowReply: (value) {
                        setState(() {
                          showReply = value;
                        });
                      },
                      closeTicketLoading:
                          state.closeTicketState == RequestState.loading,
                      closeTicket: () {
                        OtherHelper.showAlertDialogWithTwoMiddleButtons(
                          context: context,
                          content: Text(
                            'are_you_sure_you_want_to_close_this_ticket',
                            style: AppStyles.title500,
                          ).tr(),
                          title: chatTicketModel!.title,
                          okText: 'close',
                          noText: 'back',
                          okColor: AppColors.cSecondary,
                          onPressedNo: () {},
                          onPressedOk: () {
                            bloc.add(
                              CloseTicketEvent(
                                CloseTicketParams(id: widget.ticketID),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
