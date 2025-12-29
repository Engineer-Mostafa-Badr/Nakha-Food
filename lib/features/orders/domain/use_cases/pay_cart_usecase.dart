import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class PayOrderUseCase
    extends BaseUseCase<BaseResponse<String>, PayOrderParameters> {
  PayOrderUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<String>>> call(
    PayOrderParameters parameters,
  ) {
    return repository.payOrder(parameters);
  }
}

class PayOrderParameters extends Equatable {
  const PayOrderParameters({required this.orderId});

  final int orderId;

  Map<String, dynamic> toJson() {
    return {'order_id': orderId};
  }

  @override
  List<Object?> get props => [orderId];
}
