import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/add_to_cart_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class GetCartUseCase
    extends BaseUseCase<BaseResponse<CartModel>, NoParameters> {
  GetCartUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<CartModel>>> call(
    NoParameters parameters,
  ) {
    return repository.getCart();
  }
}
