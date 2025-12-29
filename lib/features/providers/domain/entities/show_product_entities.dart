import 'package:equatable/equatable.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

class ShowProductEntities extends Equatable {
  const ShowProductEntities({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.preparationMsg,
    required this.createdAt,
    required this.deliveryAvailable,
    required this.rate,
    required this.rateCounts,
    required this.category,
    required this.provider,
    required this.image,
    required this.images,
    required this.isFavorite,
    required this.qtyInCart,
  });

  final int id;
  final int qtyInCart;
  final String name;
  final bool isFavorite;
  final String price;
  final String description;
  final String preparationMsg;
  final String createdAt;
  final int deliveryAvailable;
  final double rate;
  final int rateCounts;
  final CategoriesModel category;
  final ProvidersModel provider;
  final String image;
  final List<String> images;

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    isFavorite,
    description,
    preparationMsg,
    createdAt,
    deliveryAvailable,
    rate,
    rateCounts,
    category,
    provider,
    qtyInCart,
    image,
    images,
  ];
}
