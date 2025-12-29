import 'package:equatable/equatable.dart';

class TicketEntities extends Equatable {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String humanDiff;
  final String status;
  final int commentsCount;

  const TicketEntities({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.humanDiff,
    required this.status,
    required this.commentsCount,
  });

  @override
  List<Object> get props => [
    id,
    title,
    description,
    createdAt,
    status,
    humanDiff,
    commentsCount,
  ];
}
