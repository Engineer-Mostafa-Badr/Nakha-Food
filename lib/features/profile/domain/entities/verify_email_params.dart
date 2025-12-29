import 'package:equatable/equatable.dart';

class VerifyEmailParams extends Equatable {
  // final String email;
  final String verificationCode;

  Map<String, dynamic> toJson() {
    return {
      // 'email': email,
      'code': verificationCode,
    };
  }

  const VerifyEmailParams({
    // required this.email,
    required this.verificationCode,
  });

  @override
  List<Object> get props => [verificationCode];
}
