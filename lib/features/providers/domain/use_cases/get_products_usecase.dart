import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class GetProductsUseCase
    extends BaseUseCase<BaseResponse<List<ProductsModel>>, ProductsParameters> {
  GetProductsUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<ProductsModel>>>> call(
    ProductsParameters parameters,
  ) {
    return repository.getProducts(parameters);
  }
}

class ProductsParameters extends PaginationParameters {
  final int? categoryId;
  final int? providerId;
  final String categoryName;

  const ProductsParameters({
    super.page = 1,
    this.categoryId,
    this.providerId,
    this.categoryName = '',
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (categoryId != null) 'category_id': categoryId,
      if (providerId != null) 'provider_id': providerId,
    };
  }

  @override
  ProductsParameters copyWith({
    int page = 1,
    int? categoryId,
    int? providerId,
    String? categoryName,
  }) {
    return ProductsParameters(
      page: page,
      categoryId: categoryId ?? this.categoryId,
      providerId: providerId ?? this.providerId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  List<Object?> get props => [page, categoryId, providerId, categoryName];
}
