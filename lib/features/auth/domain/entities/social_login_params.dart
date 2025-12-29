import 'dart:io';

import 'package:equatable/equatable.dart';

class SocialLoginParameters extends Equatable {
  final String? email;
  final String fullName;
  final String provider;

  /// [accessProviderToken] is the token that we get from the provider google
  final String? accessProviderToken;

  /// [code] is the token that we get from the provider apple
  final String? code;

  const SocialLoginParameters({
    required this.email,
    required this.fullName,
    required this.provider,
    required this.accessProviderToken,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      'full_name': fullName,
      'provider': provider,
      if (accessProviderToken != null)
        'access_provider_token': accessProviderToken,
      if (code != null) 'code': code,
      'use_bundle_id': Platform.isIOS,
    };
  }

  @override
  List<Object?> get props => [
    email,
    provider,
    accessProviderToken,
    fullName,
    code,
  ];
}
