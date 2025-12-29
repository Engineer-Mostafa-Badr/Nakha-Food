import 'package:nakha/features/wallet/domain/entities/wallet_entities.dart';

class WalletModel extends WalletEntities {
  const WalletModel({
    required super.id,
    required super.balance,
    required super.transactions,
    required super.totalOrders,
    required super.totalPurchases,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['wallet']?['id'] as int? ?? 0,
      balance: json['wallet']?['balance'] as String? ?? '0.00',
      totalOrders: json['wallet']?['total_orders'] as int? ?? 0,
      totalPurchases:
          double.tryParse(
            json['wallet']?['total_purchases']?.toString() ?? '0.0',
          ) ??
          0.0,
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map(
                (transaction) => TransactionModel.fromJson(
                  transaction as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  WalletModel copyWith({
    int? id,
    String? balance,
    List<TransactionModel>? transactions,
    int? totalOrders,
    double? totalPurchases,
  }) {
    return WalletModel(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      totalOrders: totalOrders ?? this.totalOrders,
      totalPurchases: totalPurchases ?? this.totalPurchases,
    );
  }
}

class TransactionModel extends TransactionEntities {
  const TransactionModel({
    required super.id,
    required super.amount,
    required super.transactionCode,
    required super.balanceAfter,
    required super.type,
    required super.status,
    required super.createdAt,
    required super.title,
    required super.inOut,
    required super.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      amount: json['amount'] as String? ?? '0.00',
      transactionCode: json['transaction_code'] as String? ?? '',
      balanceAfter: json['balance_after'] as String? ?? '0.00',
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      title: json['title'] as String? ?? '',
      inOut: json['in_out'] as String? ?? 'in',
      description: json['description'] as String? ?? '',
    );
  }
}
