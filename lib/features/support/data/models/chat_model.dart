import 'package:nakha/features/support/domain/entities/chat_entities.dart';

class ChatTicketModel extends ChatTicketEntities {
  const ChatTicketModel({
    required super.id,
    required super.title,
    required super.status,
    required super.description,
    required super.createdAt,
    required super.humanDiff,
    required super.comments,
  });

  factory ChatTicketModel.fromJson(Map<String, dynamic> json) {
    return ChatTicketModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      humanDiff: json['human_diff'] ?? '',
      comments: json['messages'] == null
          ? []
          : json['messages']
                .map<CommentsModel>((e) => CommentsModel.fromJson(e))
                .toList(),
    );
  }

  ChatTicketModel copyWith({
    int? id,
    String? title,
    String? status,
    String? description,
    String? createdAt,
    String? humanDiff,
    List<CommentsModel>? comments,
  }) {
    return ChatTicketModel(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      humanDiff: humanDiff ?? this.humanDiff,
      comments: comments ?? this.comments,
    );
  }
}

class CommentsModel extends CommentEntities {
  const CommentsModel({
    required super.id,
    required super.user,
    required super.comment,
    required super.humanDiff,
    required super.attachments,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      id: json['id'] ?? 0,
      user: UserCommentModel.fromJson(json['user'] ?? {}),
      comment: json['message'] ?? '',
      humanDiff: json['human_diff'] ?? '',
      attachments: json['attachments'] == null
          ? []
          : json['attachments']
                .map<AttachmentsModel>((e) => AttachmentsModel.fromJson(e))
                .toList(),
    );
  }
}

class UserCommentModel extends UserCommentEntities {
  const UserCommentModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory UserCommentModel.fromJson(Map<String, dynamic> json) {
    return UserCommentModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class AttachmentsModel extends AttachmentsEntities {
  const AttachmentsModel({
    required super.id,
    required super.path,
    required super.mime,
  });

  factory AttachmentsModel.fromJson(Map<String, dynamic> json) {
    return AttachmentsModel(
      id: json['id'] ?? 0,
      path: json['path'] ?? '',
      mime: json['mime'] ?? '',
    );
  }
}
