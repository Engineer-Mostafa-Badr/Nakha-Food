import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/profile/domain/repositories/base_profile_repo.dart';

class GetProfileUseCase
    extends BaseUseCase<BaseResponse<UserModel>, NoParameters> {
  final BaseProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> call(
    NoParameters parameters,
  ) {
    return repository.getProfile();
  }
}
