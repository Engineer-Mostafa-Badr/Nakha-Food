import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class ShowOrderUseCase
    extends BaseUseCase<BaseResponse<OrdersModel>, ShowOrderParams> {
  ShowOrderUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<OrdersModel>>> call(
    ShowOrderParams parameters,
  ) {
    return repository.showOrder(parameters);
  }
}

class ShowOrderParams extends Equatable {
  const ShowOrderParams({required this.orderId});

  final int orderId;

  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  List<Object?> get props => [orderId];
}
