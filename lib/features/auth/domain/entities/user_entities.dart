import 'package:equatable/equatable.dart';
import 'package:nakha/features/profile/data/models/cars_model.dart';

class UserEntities extends Equatable {
  const UserEntities({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.status,
    required this.workingTime,
    required this.deliveryAvailable,
    required this.preparationTime,
    required this.city,
    required this.region,
    required this.accessToken,
    required this.userType,
    required this.deliveryPrice,
    required this.coverImage,
  });

  final int id;
  final String name;
  final String phone;
  final String image;
  final String status;
  final String workingTime;
  final String accessToken;
  final String userType;
  final bool deliveryAvailable;

  /// [preparationTime] in minutes
  final int preparationTime;
  final NameIdModel city;
  final NameIdModel? region;
  final int deliveryPrice;
  final String coverImage;

  @override
  List<Object?> get props => [
    id,
    name,
    accessToken,
    phone,
    image,
    status,
    workingTime,
    userType,
    deliveryAvailable,
    preparationTime,
    city,
    region,
    deliveryPrice,
    coverImage,
  ];
}
