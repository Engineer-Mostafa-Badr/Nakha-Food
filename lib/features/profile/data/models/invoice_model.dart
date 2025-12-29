import 'package:nakha/features/profile/domain/entities/invoice_entities.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel({
    required super.id,
    required super.name,
    super.phone,
    required super.email,
    required super.image,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'],
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.id,
    required super.doctorName,
    required super.date,
    required super.amount,
    required super.tax,
    required super.discount,
    required super.total,
    required super.paid,
    required super.rest,
    required super.status,
    required super.doctor,
    required super.invoiceLink,
    required super.products,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] ?? 0,
      doctorName: json['doctor_name'] ?? '',
      date: json['date'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      paid: (json['paid'] ?? 0).toDouble(),
      rest: (json['rest'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      doctor: DoctorModel.fromJson(json['doctor'] ?? {}),
      invoiceLink: json['link'] ?? '',
      products:
          (json['products'] as List<dynamic>?)
              ?.map(
                (item) =>
                    ProductInvoiceModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          <ProductInvoiceModel>[],
    );
  }
}

class ProductInvoiceModel extends ProductInvoiceEntity {
  const ProductInvoiceModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.price,
    required super.tax,
    required super.subTotal,
  });

  factory ProductInvoiceModel.fromJson(Map<String, dynamic> json) {
    return ProductInvoiceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      quantity: (json['quantity'] ?? 0).toInt(),
      price: (json['price'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      subTotal: (json['sub_total'] ?? 0).toDouble(),
    );
  }
}
