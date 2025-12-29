import 'package:equatable/equatable.dart';

class CategoriesEntities extends Equatable {
  final int id;
  final String name;
  final String cover;

  const CategoriesEntities({
    required this.id,
    required this.name,
    required this.cover,
  });

  @override
  List<Object?> get props => [id, name, cover];
}
