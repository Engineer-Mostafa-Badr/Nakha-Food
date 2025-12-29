import 'package:nakha/features/orders/domain/entities/pay_order_entities.dart';

class PayOrderModel extends PayOrderEntities {
  const PayOrderModel({
    required super.id,
    required super.orderId,
    required super.amount,
    required super.tax,
    required super.total,
    required super.date,
    required super.status,
    required super.userId,
  });

  factory PayOrderModel.fromJson(Map<String, dynamic> json) {
    return PayOrderModel(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      amount: json['amount']?.toString() ?? '0.00',
      tax: json['tax']?.toString() ?? '0.00',
      total: json['total']?.toString() ?? '0.00',
      date: json['date']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      userId: json['user_id'] ?? 0,
    );
  }
}
