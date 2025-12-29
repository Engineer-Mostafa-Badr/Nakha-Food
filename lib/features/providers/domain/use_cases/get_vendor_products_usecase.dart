import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class GetVendorProductsUseCase
    extends
        BaseUseCase<BaseResponse<List<ProductsModel>>, PaginationParameters> {
  GetVendorProductsUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> call(
    PaginationParameters parameters,
  ) {
    return repository.getVendorProducts(parameters);
  }
}
