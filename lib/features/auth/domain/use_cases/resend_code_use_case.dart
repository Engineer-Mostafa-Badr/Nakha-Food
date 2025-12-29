import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';

class ResendCodeUseCase extends BaseUseCase<BaseResponse, LoginParameters> {
  final BaseLoginRepository baseLoginRepository;

  ResendCodeUseCase(this.baseLoginRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(LoginParameters parameters) async {
    return baseLoginRepository.startResendCode(parameters);
  }
}
