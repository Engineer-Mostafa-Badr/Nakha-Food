import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/components/lists/list_view_reuse.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/chat/domain/use_cases/show_chat_usecase.dart';
import 'package:nakha/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:nakha/features/chat/presentation/widgets/chat_messages/chat_controller_form.dart';
import 'package:nakha/features/chat/presentation/widgets/chat_messages/text_message_item.dart';
import 'package:nakha/features/injection_container.dart';

class ChatMessagesPage extends StatelessWidget {
  const ChatMessagesPage({super.key, required this.receiverId});

  final int receiverId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatsBloc>()
        ..add(
          ShowChatEvent(parameters: ShowChatParameters(receiverId: receiverId)),
        ),
      child: BlocBuilder<ChatsBloc, ChatsState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (value, _) {
              if (value) return;
              if (Navigator.canPop(context)) {
                Navigator.pop(
                  context,
                  ChatsBloc.get(context).thereIsNewMessage,
                );
              }
            },
            child: Scaffold(
              appBar: SharedAppBar(
                title: 'chat',
                onBackPressed: () {
                  Navigator.pop(
                    context,
                    ChatsBloc.get(context).thereIsNewMessage,
                  );
                },
              ),
              body: BlocBuilder<ChatsBloc, ChatsState>(
                buildWhen: (previous, current) =>
                    previous.showChatState != current.showChatState,
                builder: (context, state) {
                  return SliverListViewReuse(
                    emptyMessage: 'no_messages_yet',
                    errorMessage: state.showChatResponse.msg,
                    isListLoading: state.showChatState.isLoading,
                    model: state.showChatResponse.data,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.largePadding,
                    ),
                    // separator: AppPadding.padding12.sizedHeight,
                    isSlivers: false,
                    reverse: true,
                    items: state.showChatResponse.data?.messages.reversed
                        .toList(),
                    itemWidget: (item, index) {
                      return TextMessageItem(
                        isRead: item.isRead,
                        senderName: item.sender.name,
                        fromMe: item.sender.id == AppConst.userId,
                        soundPath:
                            item.attachments.isNotEmpty == true &&
                                item.attachments[0].type ==
                                    AttachmentType.audio.name
                            ? item.attachments[0].path
                            : null,
                        time: item.createdAt,
                        messageText: item.msg,
                        images: item.attachments.isNotEmpty == true
                            ? item.attachments
                                  .where(
                                    (attachment) =>
                                        attachment.type ==
                                        AttachmentType.image.name,
                                  )
                                  .map((e) => e.path)
                                  .toList()
                            : null,
                      );
                    },
                  );
                },
              ),
              bottomNavigationBar: const ChatControllerForm(),
            ),
          );
        },
      ),
    );
  }
}
