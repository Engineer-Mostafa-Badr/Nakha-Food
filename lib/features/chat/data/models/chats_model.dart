import 'package:nakha/features/chat/data/models/show_chat_model.dart';
import 'package:nakha/features/chat/domain/entities/chats_entities.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';

class ChatsModel extends ChatsEntities {
  const ChatsModel({
    required super.id,
    required super.order,
    // required super.otherUser,
    required super.sender,
    required super.lastMsg,
    required super.unreadMessages,
    required super.isLastMsgSeen,
    required super.attachments,
    required super.lastMsgCreatedAt,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) {
    return ChatsModel(
      id: json['id'] ?? 0,
      order: OrdersModel.fromJson(json['order'] ?? {}),
      // otherUser: OtherUserModel.fromJson(json['other_user'] ?? {}),
      sender: OtherUserModel.fromJson(json['sender'] ?? {}),
      unreadMessages: json['unread_count'],
      lastMsg: json['last_message']?['message'] ?? '',
      lastMsgCreatedAt: json['last_message']?['created_at'] ?? '',
      isLastMsgSeen: json['last_message_at'] != null,
      attachments: json['last_msg']?['attachments'] != null
          ? (json['last_msg']?['attachments'] as List<dynamic>)
                .map((e) => AttachmentModel.fromJson(e ?? {}))
                .toList()
          : [],
    );
  }

  ChatsModel copyWith({
    int? id,
    OrdersModel? order,
    // OtherUserModel? otherUser,
    OtherUserModel? sender,
    String? lastMsg,
    String? lastMsgCreatedAt,
    int? unreadMessages,
    bool? isLastMsgSeen,
    List<AttachmentModel>? attachments,
  }) {
    return ChatsModel(
      id: id ?? this.id,
      order: order ?? this.order,
      // otherUser: otherUser ?? this.otherUser,
      sender: sender ?? this.sender,
      lastMsg: lastMsg ?? this.lastMsg,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      isLastMsgSeen: isLastMsgSeen ?? this.isLastMsgSeen,
      attachments: attachments ?? this.attachments,
      lastMsgCreatedAt: lastMsgCreatedAt ?? this.lastMsgCreatedAt,
    );
  }
}

class OtherUserModel extends OtherUserEntities {
  const OtherUserModel({
    required super.id,
    required super.name,
    required super.profileImage,
  });

  factory OtherUserModel.fromJson(Map<String, dynamic> json) {
    return OtherUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profileImage: json['image'] ?? '',
    );
  }
}
