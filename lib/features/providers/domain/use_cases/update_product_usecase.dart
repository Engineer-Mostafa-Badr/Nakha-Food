import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';

class UpdateProductUseCase
    extends BaseUseCase<BaseResponse<ProductsModel>, AddProductParameters> {
  UpdateProductUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ProductsModel>>> call(
    AddProductParameters parameters,
  ) {
    return repository.updateProduct(parameters);
  }
}
