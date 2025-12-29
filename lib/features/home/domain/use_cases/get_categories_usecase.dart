import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/domain/repositories/base_home_repo.dart';

class GetCategoriesUseCase
    extends BaseUseCase<BaseResponse<List<CategoriesModel>>, NoParameters> {
  GetCategoriesUseCase(this.repository);

  final BaseHomeRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<CategoriesModel>>>> call(
    NoParameters parameters,
  ) {
    return repository.getCategories(parameters);
  }
}
