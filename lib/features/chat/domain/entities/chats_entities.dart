import 'package:equatable/equatable.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';

class ChatsEntities extends Equatable {
  const ChatsEntities({
    required this.id,
    required this.order,
    // required this.otherUser,
    required this.sender,
    required this.lastMsg,
    required this.unreadMessages,
    required this.isLastMsgSeen,
    required this.attachments,
    required this.lastMsgCreatedAt,
  });

  final int id;
  final OrdersModel order;

  // final OtherUserModel otherUser;
  final OtherUserModel sender;
  final String lastMsg;
  final String lastMsgCreatedAt;
  final bool isLastMsgSeen;
  final int unreadMessages;
  final List<AttachmentModel> attachments;

  @override
  List<Object?> get props => [
    id,
    order,
    // otherUser,
    sender,
    lastMsg,
    lastMsgCreatedAt,
    unreadMessages,
    isLastMsgSeen,
    attachments,
  ];
}

class OtherUserEntities extends Equatable {
  const OtherUserEntities({
    required this.id,
    required this.name,
    required this.profileImage,
  });

  final int id;
  final String name;
  final String profileImage;

  @override
  List<Object?> get props => [id, name, profileImage];
}
