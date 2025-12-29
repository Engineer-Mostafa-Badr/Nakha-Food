import 'package:equatable/equatable.dart';
import 'package:nakha/features/profile/data/models/cars_model.dart';

class CarsEntities extends Equatable {
  final int id;
  final String name;
  final NameIdModel agency;
  final NameIdModel carModel;
  final String firstChar;
  final String secondChar;
  final String lastChar;
  final String firstCharEn;
  final String secondCharEn;
  final String lastCharEn;
  final String number;
  final String year;

  const CarsEntities({
    required this.id,
    required this.name,
    required this.agency,
    required this.carModel,
    required this.firstChar,
    required this.secondChar,
    required this.lastChar,
    required this.firstCharEn,
    required this.secondCharEn,
    required this.lastCharEn,
    required this.number,
    required this.year,
  });

  @override
  List<Object> get props => [
    id,
    name,
    agency,
    carModel,
    firstChar,
    secondChar,
    lastChar,
    firstCharEn,
    secondCharEn,
    lastCharEn,
    number,
    year,
  ];
}

class NameIdEntities extends Equatable {
  final int id;
  final String name;

  const NameIdEntities({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
