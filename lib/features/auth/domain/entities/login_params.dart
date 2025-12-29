import 'package:equatable/equatable.dart';

class LoginParameters extends Equatable {
  /// login is username or email
  final String phone;
  final String email;

  /// [loginType] email,phone
  final String loginType;

  /// [userType] user, marketer, coordinator, trainer,
  final String userType;
  final String password;

  const LoginParameters({
    this.phone = '',
    this.password = '',
    this.email = '',
    this.loginType = 'phone',
    this.userType = 'user',
  });

  Map<String, dynamic> toJson() {
    return {
      if (phone.isNotEmpty) 'phone': phone,
      if (password.isNotEmpty) 'password': password,
      if (email.isNotEmpty) 'email': email,
      if (loginType.isNotEmpty) 'login_type': loginType,
      if (userType.isNotEmpty) 'user_type': userType,
    };
  }

  @override
  List<Object?> get props => [phone, password, email, loginType, userType];
}
