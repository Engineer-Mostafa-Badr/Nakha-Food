import 'package:equatable/equatable.dart';
import 'package:nakha/features/orders/data/models/add_to_cart_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class AddToCartEntities extends Equatable {
  const AddToCartEntities({required this.cart, required this.item});

  final CartModel cart;
  final CartItemModel item;

  @override
  List<Object?> get props => [cart, item];
}

class CartEntities extends Equatable {
  const CartEntities({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.deliveryPrice,
    required this.adminCommission,
    required this.createdAt,
    required this.updatedAt,
    required this.itemsCount,
    required this.items,
  });

  final int id;
  final int userId;
  final String deviceId;
  final String subtotal;
  final String tax;
  final String total;
  final String deliveryPrice;
  final String adminCommission;
  final String createdAt;
  final String updatedAt;
  final int itemsCount;
  final List<CartItemModel> items;

  @override
  List<Object?> get props => [
    id,
    userId,
    deviceId,
    subtotal,
    adminCommission,
    tax,
    total,
    createdAt,
    updatedAt,
    itemsCount,
    items,
    deliveryPrice,
  ];
}

class CartItemEntities extends Equatable {
  const CartItemEntities({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.vendorId,
    required this.qty,
    required this.amount,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final int id;
  final int cartId;
  final int productId;
  final int vendorId;
  final int qty;
  final String amount;
  final String subtotal;
  final String tax;
  final String total;
  final String createdAt;
  final String updatedAt;
  final ProductsModel product;

  @override
  List<Object?> get props => [
    id,
    cartId,
    productId,
    vendorId,
    qty,
    amount,
    subtotal,
    tax,
    total,
    createdAt,
    updatedAt,
    product,
  ];
}
