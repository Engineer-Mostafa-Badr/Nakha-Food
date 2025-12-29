import 'package:nakha/features/chat/data/models/chats_model.dart';
import 'package:nakha/features/chat/domain/entities/show_chat_entities.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';

class ShowChatModel extends ShowChatEntities {
  const ShowChatModel({
    required super.id,
    required super.allowChat,
    required super.order,
    // required super.otherUser,
    // required super.unreadMessages,
    required super.messages,
  });

  factory ShowChatModel.fromJson(Map<String, dynamic> json) {
    return ShowChatModel(
      id: json['id'] ?? 0,
      allowChat: json['allow_chat'] ?? true,
      order: OrdersModel.fromJson(json['order'] ?? {}),
      // otherUser: OtherUserModel.fromJson(json['other_user'] ?? {}),
      // unreadMessages: json['unread_messages'] ?? 0,
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((e) => MessagesModel.fromJson(e ?? {}))
          .toList(),
    );
  }

  ShowChatModel copyWith({
    int? id,
    bool? allowChat,
    OrdersModel? order,
    // OtherUserModel? otherUser,
    // int? unreadMessages,
    List<MessagesModel>? messages,
  }) {
    return ShowChatModel(
      id: id ?? this.id,
      allowChat: allowChat ?? this.allowChat,
      order: order ?? this.order,
      // otherUser: otherUser ?? this.otherUser,
      // unreadMessages: unreadMessages ?? this.unreadMessages,
      messages: messages ?? this.messages,
    );
  }
}

class MessagesModel extends MessagesEntities {
  const MessagesModel({
    required super.id,
    required super.attachments,
    required super.msg,
    required super.isRead,
    required super.createdAt,
    required super.sender,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: json['id'] ?? 0,
      msg: json['message'] ?? '',
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] ?? '',
      sender: OtherUserModel.fromJson(json['sender'] ?? {}),
      attachments: (json['attachments'] as List<dynamic>? ?? [])
          .map((e) => AttachmentModel.fromJson(e ?? {}))
          .toList(),
    );
  }

  MessagesModel copyWith({
    int? id,
    String? msg,
    bool? isRead,
    String? createdAt,
    OtherUserModel? sender,
    List<AttachmentModel>? attachments,
  }) {
    return MessagesModel(
      id: id ?? this.id,
      msg: msg ?? this.msg,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      sender: sender ?? this.sender,
      attachments: attachments ?? this.attachments,
    );
  }
}

class AttachmentModel extends AttachmentsEntities {
  const AttachmentModel({
    required super.id,
    required super.fileType,
    required super.fileId,
    required super.path,
    required super.mime,
    required super.size,
    required super.type,
    required super.createdAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] ?? 0,
      fileType: json['file_type'] ?? '',
      fileId: json['file_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      mime: json['mime'] ?? '',
      path: json['path'] ?? '',
      size: '${json['size'] ?? 0}',
      type: json['type'] ?? '',
    );
  }
}
