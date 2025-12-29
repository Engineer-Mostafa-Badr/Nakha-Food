import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/data/models/show_product_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class ShowProductUseCase
    extends BaseUseCase<BaseResponse<ShowProductModel>, ShowProductParameters> {
  ShowProductUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ShowProductModel>>> call(
    ShowProductParameters parameters,
  ) {
    return repository.showProduct(parameters);
  }
}

class ShowProductParameters extends Equatable {
  const ShowProductParameters({required this.productId});

  final int productId;

  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  List<Object?> get props => [productId];
}
