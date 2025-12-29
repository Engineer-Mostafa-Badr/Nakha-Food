import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class GetOrdersUseCase
    extends BaseUseCase<BaseResponse<OrdersDataModel>, OrdersParameters> {
  GetOrdersUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<OrdersDataModel>>> call(
    OrdersParameters parameters,
  ) {
    return repository.getOrders(parameters);
  }
}

class OrdersParameters extends PaginationParameters {
  final OrdersStatusEnum status;

  const OrdersParameters({super.page = 1, this.status = OrdersStatusEnum.all});

  @override
  Map<String, dynamic> toJson() {
    return {'page': page, 'status': status.name};
  }

  @override
  OrdersParameters copyWith({int page = 1, OrdersStatusEnum? status}) {
    return OrdersParameters(page: page, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [page, status];
}
