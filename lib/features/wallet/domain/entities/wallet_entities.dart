import 'package:equatable/equatable.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';

class WalletEntities extends Equatable {
  const WalletEntities({
    required this.id,
    required this.balance,
    required this.transactions,
    required this.totalOrders,
    required this.totalPurchases,
  });

  final int id;
  final int totalOrders;
  final double totalPurchases;
  final String balance;
  final List<TransactionModel> transactions;

  @override
  List<Object> get props => [
    id,
    balance,
    transactions,
    totalOrders,
    totalPurchases,
  ];
}

class TransactionEntities extends Equatable {
  const TransactionEntities({
    required this.id,
    required this.amount,
    required this.transactionCode,
    required this.balanceAfter,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.title,
    required this.inOut,
    required this.description,
  });

  final int id;
  final String amount;
  final String transactionCode;
  final String balanceAfter;
  final String type;
  final String status;
  final String createdAt;
  final String title;
  final String description;
  final String inOut;

  @override
  List<Object?> get props => [
    id,
    amount,
    transactionCode,
    balanceAfter,
    type,
    status,
    title,
    description,
    createdAt,
    inOut,
  ];
}
