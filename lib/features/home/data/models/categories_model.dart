import 'package:nakha/features/home/domain/entities/categories_entities.dart';

class CategoriesModel extends CategoriesEntities {
  const CategoriesModel({
    required super.id,
    required super.name,
    required super.cover,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      cover: json['image'] ?? '',
    );
  }
}
