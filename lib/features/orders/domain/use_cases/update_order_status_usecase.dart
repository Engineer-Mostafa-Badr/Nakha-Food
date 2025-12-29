import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class UpdateOrderStatusUseCase
    extends
        BaseUseCase<BaseResponse<OrdersModel>, UpdateOrderStatusParameters> {
  UpdateOrderStatusUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<OrdersModel>>> call(
    UpdateOrderStatusParameters parameters,
  ) {
    return repository.updateOrderStatus(parameters);
  }
}

class UpdateOrderStatusParameters extends Equatable {
  final int orderId;
  final String? cancelReason;
  final OrdersStatusEnum status;

  const UpdateOrderStatusParameters({
    required this.orderId,
    this.cancelReason,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      if (cancelReason != null) 'cancel_reason': cancelReason,
      'status': status.name,
    };
  }

  @override
  List<Object?> get props => [orderId, cancelReason, status];
}
