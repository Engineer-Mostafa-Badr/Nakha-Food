import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class CheckoutCartUseCase
    extends BaseUseCase<BaseResponse<OrdersModel>, CheckoutCartParameters> {
  CheckoutCartUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<OrdersModel>>> call(
    CheckoutCartParameters parameters,
  ) {
    return repository.checkoutCart(parameters);
  }
}

class CheckoutCartParameters extends Equatable {
  const CheckoutCartParameters();

  Map<String, dynamic> toJson() {
    return {'accept_terms': 1};
  }

  @override
  List<Object?> get props => [];
}
