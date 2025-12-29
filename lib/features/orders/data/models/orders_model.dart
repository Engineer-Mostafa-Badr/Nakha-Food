import 'package:nakha/core/utils/cities_model.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/orders/domain/entities/orders_entities.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class OrdersDataModel extends OrdersDataEntities {
  const OrdersDataModel({
    required super.orders,
    required super.allOrdersCount,
    required super.pendingOrders,
    required super.approvedCompletedOrders,
    required super.cancelledOrders,
  });

  factory OrdersDataModel.fromJson(Map<String, dynamic> json) {
    return OrdersDataModel(
      orders:
          (json['orders'] as List<dynamic>?)
              ?.map((e) => OrdersModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      allOrdersCount: json['all_orders_count'] ?? 0,
      pendingOrders: json['pending_orders'] ?? 0,
      approvedCompletedOrders: json['approved_completed_orders'] ?? 0,
      cancelledOrders: json['cancelled_orders'] ?? 0,
    );
  }

  OrdersDataModel copyWith({
    List<OrdersModel>? orders,
    int? allOrdersCount,
    int? pendingOrders,
    int? approvedCompletedOrders,
    int? cancelledOrders,
  }) {
    return OrdersDataModel(
      orders: orders ?? this.orders,
      allOrdersCount: allOrdersCount ?? this.allOrdersCount,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      approvedCompletedOrders:
          approvedCompletedOrders ?? this.approvedCompletedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
    );
  }
}

class OrdersModel extends OrdersEntities {
  const OrdersModel({
    required super.id,
    required super.orderNumber,
    required super.tax,
    required super.subtotal,
    required super.totalPrice,
    required super.time,
    required super.cancelledReason,
    required super.status,
    required super.streetName,
    required super.step,
    required super.orderTimer,
    required super.locationDesc,
    required super.createdAt,
    required super.lat,
    required super.lng,
    required super.user,
    required super.vendor,
    required super.city,
    required super.region,
    required super.items,
    required super.isRated,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'] ?? 0,
      totalPrice: json['total'] ?? '',
      tax: json['tax']?.toString() ?? '0.00',
      subtotal: json['subtotal']?.toString() ?? '0.00',
      orderNumber: json['order_number'] ?? '',
      status: json['status'] ?? '',
      streetName: json['street_name'] ?? '',
      orderTimer: json['order_timer'] ?? '',
      locationDesc: json['location_desc'] ?? '',
      createdAt: json['created_at'] ?? '',
      lat: json['lat'] ?? '',
      time: json['time'] ?? '',
      step: json['step'] ?? 0,
      lng: json['lng'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      vendor: ProvidersModel.fromJson(json['vendor'] ?? {}),
      city: CitiesModel.fromJson(json['city'] ?? {}),
      region: CitiesModel.fromJson(json['region'] ?? {}),
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
                .map(
                  (e) => OrdersItemsModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : [],
      isRated: json['rating_status']?['all_rated'] ?? false,
      cancelledReason: json['cancelled_reason'] ?? '',
    );
  }
}

class OrdersItemsModel extends OrdersItemsEntities {
  const OrdersItemsModel({
    required super.id,
    required super.price,
    required super.product,
    required super.productId,
    required super.vendorId,
    required super.qty,
    required super.subtotal,
    required super.tax,
    required super.total,
  });

  factory OrdersItemsModel.fromJson(Map<String, dynamic> json) {
    return OrdersItemsModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      qty: json['qty'] ?? 0,
      price: json['price']?.toString() ?? '0.00',
      subtotal: json['subtotal']?.toString() ?? '0.00',
      tax: json['tax']?.toString() ?? '0.00',
      total: json['total']?.toString() ?? '0.00',
      product: ProductsModel.fromJson(json['product'] ?? {}),
    );
  }
}
