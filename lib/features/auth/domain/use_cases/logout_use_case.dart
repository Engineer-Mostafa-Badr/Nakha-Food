import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/domain/entities/logout_params.dart';
import 'package:nakha/features/auth/domain/repositories/base_login_repo.dart';

class LogoutUseCase extends BaseUseCase<BaseResponse, LogoutParameters> {
  final BaseLoginRepository baseLogoutRepository;

  LogoutUseCase(this.baseLogoutRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(
    LogoutParameters parameters,
  ) async {
    return baseLogoutRepository.startLogout(parameters);
  }
}
