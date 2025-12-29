import 'package:equatable/equatable.dart';

class NotificationsEntities extends Equatable {
  final int id;
  final String title;
  final String description;
  final String itemId;
  final String vendorOfferId;
  final String type;
  final String humanDiff;

  const NotificationsEntities({
    required this.id,
    required this.title,
    required this.description,
    required this.humanDiff,
    required this.type,
    required this.itemId,
    required this.vendorOfferId,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    humanDiff,
    type,
    itemId,
    vendorOfferId,
  ];
}
