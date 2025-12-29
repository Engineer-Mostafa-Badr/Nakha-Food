import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/add_to_cart_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class UpdateToCartUseCase
    extends BaseUseCase<BaseResponse<AddToCartModel>, UpdateToCartParameters> {
  UpdateToCartUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<AddToCartModel>>> call(
    UpdateToCartParameters parameters,
  ) {
    return repository.updateToCart(parameters);
  }
}

class UpdateToCartParameters extends Equatable {
  final int productId;
  final int qty;

  const UpdateToCartParameters({required this.productId, this.qty = 1});

  Map<String, dynamic> toJson() {
    return {'product_id': productId, 'qty': qty};
  }

  UpdateToCartParameters copyWith({int? productId, int? qty}) {
    return UpdateToCartParameters(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object?> get props => [productId, qty];
}
