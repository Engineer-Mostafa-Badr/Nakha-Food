import 'package:nakha/features/support/domain/entities/ticket_entities.dart';

class TicketModel extends TicketEntities {
  const TicketModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    required super.humanDiff,
    required super.status,
    required super.commentsCount,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      humanDiff: json['human_diff'] ?? '',
      commentsCount: json['comments_count'] ?? 0,
    );
  }

  TicketModel copyWith({
    int? id,
    String? title,
    String? description,
    String? createdAt,
    String? humanDiff,
    String? status,
    int? commentsCount,
  }) {
    return TicketModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      humanDiff: humanDiff ?? this.humanDiff,
      status: status ?? this.status,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }
}
