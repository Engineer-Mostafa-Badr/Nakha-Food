import 'package:equatable/equatable.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class ProviderProfileEntities extends Equatable {
  const ProviderProfileEntities({
    required this.ordersCount,
    required this.vendor,
    required this.products,
  });

  final int ordersCount;
  final ProvidersModel vendor;
  final List<ProductsModel> products;

  @override
  List<Object?> get props => [ordersCount, vendor, products];
}

class ProductsEntities extends Equatable {
  const ProductsEntities({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.preparationMsg,
    required this.createdAt,
    required this.images,
    required this.rate,
    required this.rateCounts,
    required this.isFavourite,
    required this.qtyInCart,
    required this.deliveryAvailable,
  });

  final int id;
  final String name;
  final String price;
  final String preparationMsg;
  final String description;
  final String image;
  final List<String> images;
  final CategoriesModel category;
  final String createdAt;
  final double rate;
  final int rateCounts;
  final int qtyInCart;
  final bool isFavourite;
  final int deliveryAvailable;

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    description,
    image,
    images,
    preparationMsg,
    category,
    createdAt,
    rate,
    rateCounts,
    isFavourite,
    qtyInCart,
    deliveryAvailable,
  ];
}
