import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/domain/repositories/base_home_repo.dart';

class GenerateNewPayLinkUseCase
    extends BaseUseCase<BaseResponse<String>, NoParameters> {
  final BaseHomeRepository repository;

  GenerateNewPayLinkUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<String>>> call(NoParameters parameters) {
    return repository.generateNewPayLink();
  }
}
