import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';

class VerifyUseCase extends BaseUseCase<BaseResponse<UserModel>, VerifyParams> {
  final BaseLoginRepository baseLoginRepository;

  VerifyUseCase(this.baseLoginRepository);

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> call(
    VerifyParams parameters,
  ) async {
    return baseLoginRepository.startVerify(parameters);
  }
}

class VerifyParams extends Equatable {
  final String email;
  final String code;
  final String phone;
  final String userType;

  const VerifyParams({
    required this.email,
    required this.code,
    required this.phone,
    this.userType = 'client',
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      if (email.isNotEmpty) 'email': email,
      if (code.isNotEmpty) 'code': code,
      if (phone.isNotEmpty) 'phone': phone,
      'login_type': phone.isNotEmpty ? 'phone' : 'email',
      'user_type': userType,
      if (AppConst.fcmToken.isNotEmpty) 'device_token': AppConst.fcmToken,
      'device_id': await MostUsedFunctions.getDeviceId(),
    };
  }

  @override
  List<Object?> get props => [email, code, phone, userType];
}
