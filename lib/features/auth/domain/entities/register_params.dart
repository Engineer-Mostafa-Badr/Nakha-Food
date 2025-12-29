import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String phone;
  final int cityId;
  final int districtId;
  final bool acceptTerms;
  final String userType;
  final String birthDate;
  final String civil;
  final String gender;

  const RegisterParams({
    required this.name,
    this.email = '',
    this.phone = '',
    this.cityId = 0,
    this.acceptTerms = false,
    this.userType = 'client',
    this.birthDate = '',
    this.civil = '',
    this.gender = '',
    this.districtId = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (email.isNotEmpty) 'email': email,
      if (phone.isNotEmpty) 'phone': phone,
      if (cityId != 0) 'city_id': cityId,
      if (districtId != 0) 'region_id': districtId,
      'accept_terms': acceptTerms ? 1 : 0,
      'user_type': userType,
      if (birthDate.isNotEmpty) 'birthdate': birthDate,
      if (civil.isNotEmpty) 'civil': civil,
      if (gender.isNotEmpty) 'gender': gender,
    };
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    districtId,
    acceptTerms,
    userType,
    birthDate,
    civil,
    gender,
  ];
}
