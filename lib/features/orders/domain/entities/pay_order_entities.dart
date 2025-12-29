import 'package:equatable/equatable.dart';

class PayOrderEntities extends Equatable {
  const PayOrderEntities({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.tax,
    required this.total,
    required this.date,
    required this.status,
    required this.userId,
  });

  final int id;
  final int orderId;
  final String amount;
  final String tax;
  final String total;
  final String date;
  final String status;
  final int userId;

  @override
  List<Object?> get props => [
    id,
    orderId,
    amount,
    tax,
    total,
    date,
    status,
    userId,
  ];
}
