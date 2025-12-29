import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/domain/entities/register_params.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';

class RegisterUseCase extends BaseUseCase<BaseResponse, RegisterParams> {
  final BaseLoginRepository baseLoginRepository;

  RegisterUseCase(this.baseLoginRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(RegisterParams parameters) async {
    return baseLoginRepository.startRegister(parameters);
  }
}
