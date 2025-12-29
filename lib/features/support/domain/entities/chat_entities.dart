import 'package:equatable/equatable.dart';
import 'package:nakha/features/support/data/models/chat_model.dart';

class ChatTicketEntities extends Equatable {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String status;
  final String humanDiff;
  final List<CommentsModel> comments;

  const ChatTicketEntities({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.humanDiff,
    required this.comments,
  });

  @override
  List<Object> get props => [
    id,
    title,
    description,
    status,
    createdAt,
    humanDiff,
    comments,
  ];
}

class CommentEntities extends Equatable {
  final int id;
  final UserCommentModel user;
  final String comment;
  final String humanDiff;
  final List<AttachmentsModel> attachments;

  const CommentEntities({
    required this.id,
    required this.user,
    required this.comment,
    required this.humanDiff,
    required this.attachments,
  });

  @override
  List<Object> get props => [id, user, comment, humanDiff, attachments];
}

class UserCommentEntities extends Equatable {
  final int id;
  final String name;
  final String image;

  const UserCommentEntities({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, image];
}

class AttachmentsEntities extends Equatable {
  final int id;
  final String path;
  final String mime;

  const AttachmentsEntities({
    required this.id,
    required this.path,
    required this.mime,
  });

  @override
  List<Object> get props => [id, path, mime];
}
