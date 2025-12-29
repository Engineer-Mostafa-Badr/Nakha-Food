import 'package:nakha/features/profile/domain/entities/cars_entities.dart';

class CarsModel extends CarsEntities {
  const CarsModel({
    required super.id,
    required super.name,
    required super.agency,
    required super.carModel,
    required super.firstChar,
    required super.secondChar,
    required super.lastChar,
    required super.firstCharEn,
    required super.secondCharEn,
    required super.lastCharEn,
    required super.number,
    required super.year,
  });

  factory CarsModel.fromJson(Map<String, dynamic> json) {
    return CarsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      agency: NameIdModel.fromJson(json['agency'] ?? {}),
      carModel: NameIdModel.fromJson(json['carModel'] ?? {}),
      firstChar: json['first_char'] ?? '',
      secondChar: json['second_char'] ?? '',
      lastChar: json['last_char'] ?? '',
      firstCharEn: json['first_char_en'] ?? '',
      secondCharEn: json['second_char_en'] ?? '',
      lastCharEn: json['last_char_en'] ?? '',
      number: '${json['number'] ?? '000'}',
      year: '${json['year'] ?? '0000'}',
    );
  }
}

class NameIdModel extends NameIdEntities {
  const NameIdModel({required super.id, required super.name});

  factory NameIdModel.fromJson(Map<String, dynamic> json) {
    return NameIdModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
