import 'package:equatable/equatable.dart';
import 'package:nakha/core/utils/cities_model.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class OrdersDataEntities extends Equatable {
  const OrdersDataEntities({
    required this.orders,
    required this.allOrdersCount,
    required this.pendingOrders,
    required this.approvedCompletedOrders,
    required this.cancelledOrders,
  });

  final List<OrdersModel> orders;
  final int allOrdersCount;
  final int pendingOrders;
  final int approvedCompletedOrders;
  final int cancelledOrders;

  @override
  List<Object?> get props => [
    orders,
    allOrdersCount,
    pendingOrders,
    approvedCompletedOrders,
    cancelledOrders,
  ];
}

class OrdersEntities extends Equatable {
  const OrdersEntities({
    required this.id,
    required this.totalPrice,
    required this.orderNumber,
    required this.status,
    required this.streetName,
    required this.tax,
    required this.subtotal,
    required this.orderTimer,
    required this.locationDesc,
    required this.createdAt,
    required this.lat,
    required this.time,
    required this.cancelledReason,
    required this.lng,
    required this.user,
    required this.vendor,
    required this.city,
    required this.region,
    required this.items,
    required this.step,
    required this.isRated,
  });

  final int id;
  final int step;
  final String totalPrice;
  final String tax;
  final String subtotal;
  final String status;
  final String cancelledReason;
  final String streetName;
  final String orderNumber;
  final String time;
  final String locationDesc;
  final String createdAt;
  final String orderTimer;
  final String lat;
  final String lng;
  final UserModel user;
  final ProvidersModel vendor;
  final CitiesModel city;
  final CitiesModel region;
  final List<OrdersItemsModel> items;
  final bool isRated;

  @override
  List<Object?> get props {
    return [
      id,
      cancelledReason,
      totalPrice,
      isRated,
      time,
      status,
      streetName,
      locationDesc,
      createdAt,
      orderTimer,
      tax,
      subtotal,
      lat,
      orderNumber,
      lng,
      step,
      user,
      vendor,
      city,
      region,
      items,
    ];
  }
}

class OrdersItemsEntities extends Equatable {
  const OrdersItemsEntities({
    required this.id,
    required this.productId,
    required this.vendorId,
    required this.qty,
    required this.price,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.product,
  });

  final int id;
  final int productId;
  final int vendorId;
  final int qty;
  final String price;
  final String subtotal;
  final String tax;
  final String total;
  final ProductsModel product;

  @override
  List<Object?> get props => [
    id,
    productId,
    vendorId,
    qty,
    price,
    subtotal,
    tax,
    total,
    product,
  ];
}
