import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class UpdateProfileParams extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String image;
  final String birthDate;
  final String deliveryPrice;
  final String coverImage;
  final int cityId;
  final int districtId;
  final String workingTime;
  final int preparationTime;
  final bool? deliveryAvailable;

  Future<Map<String, dynamic>> toJson() async {
    return {
      if (name.isNotEmpty) 'name': name,
      if (phone.isNotEmpty) 'phone': phone,
      if (image.isNotEmpty) 'image': await MultipartFile.fromFile(image),
      if (coverImage.isNotEmpty)
        'cover_image': await MultipartFile.fromFile(coverImage),
      if (email.isNotEmpty) 'email': email,
      if (birthDate.isNotEmpty) 'birthdate': birthDate,
      if (cityId != 0) 'city_id': cityId,
      if (districtId != 0) 'region_id': districtId,
      if (workingTime.isNotEmpty) 'working_time': workingTime,
      if (preparationTime != 0) 'preparation_time': preparationTime,
      if (deliveryAvailable != null)
        'delivery_available': deliveryAvailable! ? 1 : 0,
      if (deliveryPrice.isNotEmpty) 'delivery_price': deliveryPrice,
    };
  }

  const UpdateProfileParams({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
    this.coverImage = '',
    this.deliveryPrice = '',
    this.birthDate = '',
    this.cityId = 0,
    this.districtId = 0,
    this.workingTime = '',
    this.preparationTime = 0,
    this.deliveryAvailable,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    email,
    image,
    cityId,
    birthDate,
    districtId,
    workingTime,
    preparationTime,
    deliveryAvailable,
    deliveryPrice,
    coverImage,
  ];
}
