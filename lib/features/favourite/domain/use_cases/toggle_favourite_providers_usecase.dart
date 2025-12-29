import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/favourite/domain/repositories/base_repo.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

class ToggleFavouriteProvidersUseCase
    extends
        BaseUseCase<
          BaseResponse<ProvidersModel>,
          ToggleFavouriteProvidersParameters
        > {
  ToggleFavouriteProvidersUseCase(this.repository);

  final BaseFavouriteRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ProvidersModel>>> call(
    ToggleFavouriteProvidersParameters parameters,
  ) {
    return repository.toggleFavouriteProviders(parameters);
  }
}

class ToggleFavouriteProvidersParameters extends Equatable {
  const ToggleFavouriteProvidersParameters({required this.providerId});

  final int providerId;

  Map<String, dynamic> toJson() {
    return {'vendor_id': providerId};
  }

  @override
  List<Object?> get props => [providerId];
}
