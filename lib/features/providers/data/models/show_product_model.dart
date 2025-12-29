import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/domain/entities/show_product_entities.dart';

class ShowProductModel extends ShowProductEntities {
  const ShowProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.preparationMsg,
    required super.createdAt,
    required super.deliveryAvailable,
    required super.rate,
    required super.rateCounts,
    required super.category,
    required super.provider,
    required super.image,
    required super.images,
    required super.isFavorite,
    required super.qtyInCart,
  });

  factory ShowProductModel.fromJson(Map<String, dynamic> json) {
    return ShowProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      description: json['description'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      preparationMsg: json['preparation_msg'] ?? '',
      createdAt: json['created_at'] ?? '',
      deliveryAvailable: json['delivery_available'] ?? 0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      rateCounts: json['rate_counts'] ?? 0,
      category: CategoriesModel.fromJson(json['category'] ?? {}),
      provider: ProvidersModel.fromJson(json['provider'] ?? {}),
      image: json['image'] ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      qtyInCart: json['qty_in_cart'] ?? 0,
    );
  }

  ShowProductModel copyWith({
    int? id,
    String? name,
    String? price,
    String? description,
    String? preparationMsg,
    String? createdAt,
    int? deliveryAvailable,
    double? rate,
    int? rateCounts,
    bool? isFavorite,
    CategoriesModel? category,
    ProvidersModel? provider,
    String? image,
    List<String>? images,
    int? qtyInCart,
  }) {
    return ShowProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      preparationMsg: preparationMsg ?? this.preparationMsg,
      createdAt: createdAt ?? this.createdAt,
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
      rate: rate ?? this.rate,
      rateCounts: rateCounts ?? this.rateCounts,
      category: category ?? this.category,
      provider: provider ?? this.provider,
      image: image ?? this.image,
      images: images ?? this.images,
      qtyInCart: qtyInCart ?? this.qtyInCart,
    );
  }
}
