import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class GetProvidersUseCase
    extends
        BaseUseCase<BaseResponse<List<ProvidersModel>>, ProvidersParameters> {
  GetProvidersUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<ProvidersModel>>>> call(
    ProvidersParameters parameters,
  ) {
    return repository.getProviders(parameters);
  }
}

class ProvidersParameters extends PaginationParameters {
  final int? cityId;
  final int? regionId;

  const ProvidersParameters({super.page = 1, this.cityId, this.regionId});

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (cityId != null) 'city_id': cityId,
      if (regionId != null) 'region_id': regionId,
    };
  }

  @override
  ProvidersParameters copyWith({int page = 1, int? cityId, int? regionId}) {
    return ProvidersParameters(
      page: page,
      cityId: cityId ?? this.cityId,
      regionId: regionId ?? this.regionId,
    );
  }

  @override
  List<Object?> get props => [page, cityId, regionId];
}
