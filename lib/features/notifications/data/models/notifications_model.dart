import 'package:nakha/features/notifications/domain/entities/notifications_entities.dart';

class NotificationsModel extends NotificationsEntities {
  const NotificationsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.humanDiff,
    required super.itemId,
    required super.type,
    required super.vendorOfferId,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      humanDiff: json['time'] ?? '',
      itemId: json['item_id'] ?? '',
      type: json['type'] ?? '',
      vendorOfferId: json['vendor_offer_id'] ?? '',
    );
  }
}
