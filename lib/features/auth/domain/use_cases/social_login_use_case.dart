import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/auth/domain/entities/social_login_params.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';

class SocialLoginUseCase
    extends BaseUseCase<BaseResponse<UserModel?>, SocialLoginParameters> {
  final BaseLoginRepository baseLoginRepository;

  SocialLoginUseCase(this.baseLoginRepository);

  @override
  Future<Either<Failure, BaseResponse<UserModel?>>> call(
    SocialLoginParameters parameters,
  ) async {
    return baseLoginRepository.startSocialLogin(parameters);
  }
}
