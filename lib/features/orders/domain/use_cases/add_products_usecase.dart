import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/orders/domain/repositories/base_repo.dart';

class RateProductsUseCase extends BaseUseCase<BaseResponse, AllRatesParams> {
  RateProductsUseCase(this.repository);

  final BaseOrdersRepository repository;

  @override
  Future<Either<Failure, BaseResponse>> call(AllRatesParams parameters) {
    return repository.rateProducts(parameters);
  }
}

class AllRatesParams extends Equatable {
  const AllRatesParams({
    required this.vendorRate,
    required this.rates,
    required this.orderId,
  });

  final RateProductsParameters vendorRate;
  final List<RateProductsParameters> rates;
  final int orderId;

  Map<String, dynamic> toJson() {
    return {
      'vendor_rating': vendorRate.toJson(),
      'product_ratings': rates.map((e) => e.toJson()).toList(),
    };
  }

  AllRatesParams copyWith({
    RateProductsParameters? vendorRate,
    List<RateProductsParameters>? rates,
    int? orderId,
  }) {
    return AllRatesParams(
      vendorRate: vendorRate ?? this.vendorRate,
      rates: rates ?? this.rates,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  List<Object?> get props => [vendorRate, rates, orderId];
}

class RateProductsParameters extends Equatable {
  const RateProductsParameters({
    required this.rate,
    this.comment = '',
    required this.productId,
  });

  final double rate;
  final String comment;
  final int productId;

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'comment': comment,
      if (productId > 0) 'product_id': productId,
    };
  }

  RateProductsParameters copyWith({
    double? rate,
    String? comment,
    int? productId,
  }) {
    return RateProductsParameters(
      rate: rate ?? this.rate,
      comment: comment ?? this.comment,
      productId: productId ?? this.productId,
    );
  }

  @override
  List<Object?> get props => [rate, comment, productId];
}
