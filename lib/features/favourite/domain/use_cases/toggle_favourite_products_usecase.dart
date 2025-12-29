import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/favourite/domain/repositories/base_repo.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';

class ToggleFavouriteProductsUseCase
    extends
        BaseUseCase<
          BaseResponse<ProductsModel>,
          ToggleFavouriteProductsParameters
        > {
  ToggleFavouriteProductsUseCase(this.repository);

  final BaseFavouriteRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ProductsModel>>> call(
    ToggleFavouriteProductsParameters parameters,
  ) {
    return repository.toggleFavouriteProducts(parameters);
  }
}

class ToggleFavouriteProductsParameters extends Equatable {
  const ToggleFavouriteProductsParameters({required this.productId});

  final int productId;

  Map<String, dynamic> toJson() {
    return {'product_id': productId};
  }

  @override
  List<Object?> get props => [productId];
}
