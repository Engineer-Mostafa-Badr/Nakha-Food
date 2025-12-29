import 'package:equatable/equatable.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';

class DoctorEntity extends Equatable {
  const DoctorEntity({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    required this.image,
  });

  final int id;
  final String name;
  final String? phone;
  final String email;
  final String image;

  @override
  List<Object?> get props => [id, name, phone, email, image];
}

class InvoiceEntity extends Equatable {
  const InvoiceEntity({
    required this.id,
    required this.doctorName,
    required this.date,
    required this.amount,
    required this.tax,
    required this.discount,
    required this.total,
    required this.paid,
    required this.rest,
    required this.status,
    required this.doctor,
    required this.invoiceLink,
    required this.products,
  });

  final int id;
  final String doctorName;
  final String date;
  final double amount;
  final double tax;
  final double discount;
  final double total;
  final double paid;
  final double rest;
  final String status;
  final String invoiceLink;
  final DoctorModel doctor;
  final List<ProductInvoiceModel> products;

  @override
  List<Object?> get props => [
    id,
    doctorName,
    date,
    amount,
    tax,
    discount,
    total,
    paid,
    rest,
    status,
    doctor,
    invoiceLink,
    products,
  ];
}

class ProductInvoiceEntity extends Equatable {
  const ProductInvoiceEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.tax,
    required this.subTotal,
  });

  final int id;
  final String name;
  final int quantity;
  final double price;
  final double tax;
  final double subTotal;

  @override
  List<Object?> get props => [id, name, quantity, price, tax, subTotal];
}
