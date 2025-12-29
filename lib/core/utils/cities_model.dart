import 'package:equatable/equatable.dart';

class CitiesModel extends Equatable {
  final int id;
  final String name;

  const CitiesModel({required this.id, required this.name});

  factory CitiesModel.fromJson(Map<String, dynamic> json) {
    return CitiesModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  @override
  List<Object?> get props => [id, name];
}
