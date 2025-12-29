import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class DeleteProductUseCase extends BaseUseCase<BaseResponse<int>, int> {
  DeleteProductUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<int>>> call(int parameters) {
    return repository.deleteProduct(parameters);
  }
}
