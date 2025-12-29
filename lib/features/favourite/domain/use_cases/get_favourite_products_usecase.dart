import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/favourite/domain/repositories/base_repo.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class GetFavouriteProductsUseCase
    extends
        BaseUseCase<
          BaseResponse<List<ProductsModel>>,
          FavouriteProductsParameters
        > {
  GetFavouriteProductsUseCase(this.repository);

  final BaseFavouriteRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> call(
    FavouriteProductsParameters parameters,
  ) {
    return repository.getFavouriteProducts(parameters);
  }
}

class FavouriteProductsParameters extends PaginationParameters {
  const FavouriteProductsParameters({super.page = 1});

  @override
  Map<String, dynamic> toJson() {
    return {'page': page};
  }

  @override
  FavouriteProductsParameters copyWith({int page = 1}) {
    return FavouriteProductsParameters(page: page);
  }

  @override
  List<Object?> get props => [page];
}
