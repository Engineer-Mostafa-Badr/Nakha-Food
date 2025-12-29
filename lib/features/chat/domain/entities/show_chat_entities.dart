import 'package:equatable/equatable.dart';
import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';

class ShowChatEntities extends Equatable {
  const ShowChatEntities({
    required this.id,
    required this.allowChat,
    required this.order,
    // required this.otherUser,
    // required this.unreadMessages,
    required this.messages,
  });

  final int id;
  final bool allowChat;
  final OrdersModel order;

  // final OtherUserModel otherUser;

  // final int unreadMessages;
  final List<MessagesModel> messages;

  @override
  List<Object?> get props => [
    id,
    allowChat,
    order,
    // otherUser,
    // unreadMessages,
    messages,
  ];
}

class MessagesEntities extends Equatable {
  const MessagesEntities({
    required this.id,
    required this.msg,
    required this.createdAt,
    required this.isRead,
    required this.sender,
    required this.attachments,
  });

  final int id;
  final String msg;
  final bool isRead;
  final String createdAt;
  final OtherUserModel sender;
  final List<AttachmentModel> attachments;

  @override
  List<Object?> get props => [id, msg, isRead, createdAt, sender, attachments];
}

class AttachmentsEntities extends Equatable {
  const AttachmentsEntities({
    required this.id,
    required this.fileType,
    required this.fileId,
    required this.path,
    required this.mime,
    required this.size,
    required this.type,
    required this.createdAt,
  });

  final int id;
  final String fileType;
  final int fileId;
  final String path;
  final String mime;
  final String size;
  final String type;
  final String createdAt;

  @override
  List<Object?> get props => [
    id,
    fileType,
    fileId,
    path,
    mime,
    size,
    type,
    createdAt,
  ];
}
