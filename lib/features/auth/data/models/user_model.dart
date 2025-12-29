import 'package:nakha/features/auth/domain/entities/user_entities.dart';
import 'package:nakha/features/profile/data/models/cars_model.dart';

class UserModel extends UserEntities {
  const UserModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.image,
    required super.status,
    required super.workingTime,
    required super.deliveryAvailable,
    required super.preparationTime,
    required super.city,
    required super.region,
    required super.accessToken,
    required super.userType,
    required super.deliveryPrice,
    required super.coverImage,
  });

  /// {
  //       "id": 2,
  //       "name": "Eos obcaecati amet ",
  //       "phone": "+1 (856) 522-3687",
  //       "image": "http://nakha.test/images/default/image.jpg",
  //       "status": "active",
  //       "working_time": "morning",
  //       "delivery_available": 1,
  //       "preparation_time": 23,
  //       "city": {
  //         "id": 1,
  //         "name": "جدة"
  //       },
  //       "region": null
  //     }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      workingTime: json['working_time'] ?? '',
      deliveryAvailable: json['delivery_available'] == 1,
      preparationTime: json['preparation_time'] ?? 0,
      city: NameIdModel.fromJson(json['city'] ?? {}),
      accessToken: json['access_token'] ?? '',
      userType: json['user_type'] ?? '',
      deliveryPrice: int.tryParse('${json['delivery_price'] ?? 0}') ?? 0,
      coverImage: json['cover_image'] ?? '',
      region: json['region'] != null
          ? NameIdModel.fromJson(json['region'])
          : null,
    );
  }

  bool get isVendor => userType == 'vendor';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'phone': phone,
      'status': status,
      'working_time': workingTime,
      'cover_image': coverImage,
      'delivery_price': deliveryPrice,
      'delivery_available': deliveryAvailable ? 1 : 0,
      'preparation_time': preparationTime,
      'city': city.toJson(),
      'region': region?.toJson(),
      'access_token': accessToken,
      'user_type': userType,
    };
  }
}
