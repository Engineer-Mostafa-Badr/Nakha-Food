import 'package:nakha/features/orders/domain/entities/add_to_cart_entities.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class AddToCartModel extends AddToCartEntities {
  const AddToCartModel({required super.cart, required super.item});

  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    return AddToCartModel(
      cart: CartModel.fromJson(json['cart'] ?? {}),
      item: CartItemModel.fromJson(json['item'] ?? {}),
    );
  }

  AddToCartModel copyWith({CartModel? cart, CartItemModel? item}) {
    return AddToCartModel(cart: cart ?? this.cart, item: item ?? this.item);
  }
}

class CartModel extends CartEntities {
  const CartModel({
    required super.id,
    required super.userId,
    required super.deviceId,
    required super.subtotal,
    required super.tax,
    required super.adminCommission,
    required super.total,
    required super.deliveryPrice,
    required super.createdAt,
    required super.updatedAt,
    required super.itemsCount,
    required super.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      deviceId: json['device_id'] ?? '',
      subtotal: json['subtotal'] ?? '',
      tax: json['tax'] ?? '',
      total: json['total'] ?? '',
      adminCommission: '${json['admin_commission'] ?? ''}',
      deliveryPrice: '${json['delivery_price'] ?? ''}',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      itemsCount: json['items_count'] ?? 0,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // total quantity of items in the cart
  int get totalItemsInCart {
    return items.fold<int>(
      0,
      (previousValue, element) => previousValue + element.qty,
    );
  }
}

class CartItemModel extends CartItemEntities {
  const CartItemModel({
    required super.id,
    required super.cartId,
    required super.productId,
    required super.vendorId,
    required super.qty,
    required super.amount,
    required super.subtotal,
    required super.tax,
    required super.total,
    required super.createdAt,
    required super.updatedAt,
    required super.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? 0,
      cartId: json['cart_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      qty: json['qty'] ?? 0,
      amount: json['amount'] ?? '',
      subtotal: json['subtotal'] ?? '',
      tax: json['tax'] ?? '',
      total: json['total'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      product: ProductsModel.fromJson(json['product'] ?? {}),
    );
  }
}
