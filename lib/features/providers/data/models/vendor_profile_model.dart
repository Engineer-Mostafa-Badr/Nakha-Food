import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/domain/entities/vendor_profile_entities.dart';

class ProviderProfileModel extends ProviderProfileEntities {
  const ProviderProfileModel({
    required super.ordersCount,
    required super.vendor,
    required super.products,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ProviderProfileModel(
      ordersCount: json['orders_count'] ?? 0,
      vendor: ProvidersModel.fromJson(json['vendor'] ?? {}),
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  ProviderProfileModel copyWith({
    int? ordersCount,
    ProvidersModel? vendor,
    List<ProductsModel>? products,
  }) {
    return ProviderProfileModel(
      ordersCount: ordersCount ?? this.ordersCount,
      vendor: vendor ?? this.vendor,
      products: products ?? this.products,
    );
  }

  // get quantity of products in cart
  int get totalProductsInCart {
    // if not empty
    if (products.isNotEmpty) {
      return products.fold<int>(
        0,
        (previousValue, element) => previousValue + element.qtyInCart,
      );
    }
    return 0;
  }
}

class ProductsModel extends ProductsEntities {
  const ProductsModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.image,
    required super.images,
    required super.preparationMsg,
    required super.category,
    required super.createdAt,
    required super.rate,
    required super.rateCounts,
    required super.isFavourite,
    required super.qtyInCart,
    required super.deliveryAvailable,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      preparationMsg: json['preparation_msg'] ?? '',
      description: json['description'] ?? '',
      isFavourite: json['is_favorite'] ?? false,
      image: json['image'] ?? '',
      category: CategoriesModel.fromJson(json['category'] ?? {}),
      createdAt: json['created_at'] ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      rateCounts: json['rate_counts'] ?? 0,
      qtyInCart: json['qty_in_cart'] ?? 0,
      deliveryAvailable: json['delivery_available'] ?? 0,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
